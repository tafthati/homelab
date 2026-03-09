#!/bin/bash
set -Eeuo pipefail

DOCKER_BASE_DIR="/home/tafthati/docker"
LOG_FILE="$HOME/docker_update.log"

# === TELEGRAM CONFIG ===
BOT_TOKEN="token_del_bot_telegram"
CHAT_ID="tuo_chat_id"
TELEGRAM_API="https://api.telegram.org/bot${BOT_TOKEN}/sendMessage"

# Log su file + terminale
#exec > >(tee -a "$LOG_FILE") 2>&1

send_telegram() {
    local message="$1"
    curl -s -X POST "$TELEGRAM_API" \
        -d chat_id="$CHAT_ID" \
        -d text="$message" \
        -d parse_mode="Markdown" >/dev/null
}

echo "=========================================="
echo "   Gestore Aggiornamenti Docker 🐳"
echo "=========================================="
echo "Data: $(date)"
echo ""

if ! command -v docker >/dev/null 2>&1; then
    echo "❌ Docker non trovato."
    send_telegram "❌ *ERRORE CRITICO*: Docker non trovato sul server."
    exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
    echo "❌ curl non installato."
    exit 1
fi

# Trova servizi
services=()
while IFS= read -r file; do
    dir=$(dirname "$file")
    service_name=$(basename "$dir")
    services+=("$service_name")
done < <(find "$DOCKER_BASE_DIR" -maxdepth 2 -name "docker-compose.yml" | sort)

if [ ${#services[@]} -eq 0 ]; then
    echo "❌ Nessun docker-compose.yml trovato!"
    exit 1
fi

echo "Servizi trovati:"
for i in "${!services[@]}"; do
    printf "%2d. %s\n" $((i+1)) "${services[i]}"
done
echo ""

if [[ "${1:-}" == "--all" ]]; then
    selected_nums=($(seq 1 ${#services[@]}))
else
    echo "Inserisci numeri servizi (es: 1 3 5 o 1,3,5), q per uscire:"
    read -r input
    [[ "$input" =~ ^[Qq]$ ]] && exit 0
    IFS=' ,' read -ra selected_nums <<< "$(echo "$input" | tr ',' ' ')"
fi

declare -A seen

for num in "${selected_nums[@]}"; do
    num=$(echo "$num" | xargs)

    if [[ ! "$num" =~ ^[0-9]+$ ]] || \
       [ "$num" -lt 1 ] || \
       [ "$num" -gt "${#services[@]}" ]; then
        echo "Numero invalido ignorato: $num"
        continue
    fi

    [[ -n "${seen[$num]:-}" ]] && continue
    seen[$num]=1

    service="${services[$((num-1))]}"
    service_path="$DOCKER_BASE_DIR/$service"

    echo "------------------------------------------"
    echo "Aggiornando: $service"
    echo "Percorso: $service_path"

    if ! cd "$service_path"; then
        msg="❌ *$service* - Errore accesso cartella."
        echo "$msg"
        send_telegram "$msg"
        exit 1
    fi

    if ! docker compose pull; then
        msg="❌ *$service* - Errore durante pull."
        echo "$msg"
        send_telegram "$msg"
        exit 1
    fi

    if ! docker compose up -d; then
        msg="❌ *$service* - Errore durante up."
        echo "$msg"
        send_telegram "$msg"
        exit 1
    fi

    # Attendi stabilizzazione container
    echo "Verifica stato container..."
    sleep 5

    containers=$(docker compose ps -q)

    for c in $containers; do
        state=$(docker inspect --format='{{.State.Status}}' "$c")
        health=$(docker inspect --format='{{if .State.Health}}{{.State.Health.Status}}{{else}}none{{end}}' "$c")

        if [[ "$state" != "running" ]]; then
            msg="❌ *$service* - Container non running."
            echo "$msg"
            send_telegram "$msg"
            exit 1
        fi

        if [[ "$health" != "healthy" && "$health" != "none" ]]; then
            msg="❌ *$service* - Healthcheck fallito (stato: $health)."
            echo "$msg"
            send_telegram "$msg"
            exit 1
        fi
    done

    echo "✅ $service aggiornato correttamente."
done

echo ""
echo "Pulizia immagini inutilizzate..."
docker image prune -f

echo "=========================================="
echo "Aggiornamento completato senza errori."
echo "Log salvato in: $LOG_FILE"
echo "=========================================="
exit 0
