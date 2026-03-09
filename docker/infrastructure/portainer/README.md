# 🐳 Portainer

Portainer è una GUI web per la gestione completa di container, immagini,
volumi e reti Docker — tutto accessibile via browser senza toccare il terminale.

---

## Perché Portainer

Gestire decine di container solo da CLI diventa rapidamente dispersivo.
Portainer offre una visione centralizzata dello stato dell'intero stack Docker:
log in tempo reale, restart rapidi, ispezione delle variabili d'ambiente
e monitoraggio delle risorse per ogni container.

---

## Configurazione

| Parametro | Valore |
|---|---|
| **Immagine** | portainer/portainer-ce:latest |
| **Interfaccia** | HTTPS (certificato autofirmato) |
| **Accesso** | LAN only |
| **Restart policy** | unless-stopped |
| **Rete** | portainer_portainer-net (bridge isolata) |

---

## Sicurezza: Docker Socket Proxy

Portainer non monta /var/run/docker.sock direttamente.
Comunica con il Docker daemon tramite una istanza dedicata di
tecnativa/docker-socket-proxy con permessi minimi in sola lettura.

Questo impedisce che una compromissione di Portainer si traduca
in accesso root al sistema operativo host.

    [Portainer] ──→ [socket-proxy-portainer] ──→ [Docker daemon]

Per i dettagli sul pattern → security/socket-proxy/README.md

---

## File

| File | Descrizione |
|---|---|
| docker-compose.yml | Definizione del servizio e del socket proxy dedicato |
| .env.example | Variabili d'ambiente necessarie (copiare in .env) |

---

## Deploy

    cp .env.example .env
    nano .env
    docker compose up -d

---

## Note

- Al primo avvio Portainer crea un utente admin: accedere subito per impostare la password
- I dati di Portainer sono persistiti in un volume Docker dedicato
- Aggiornare Portainer con cautela: verificare sempre il changelog prima
