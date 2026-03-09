# 🏠 Homepage

Homepage è una dashboard centralizzata e altamente personalizzabile
che raccoglie in un'unica schermata tutti i servizi del homelab,
con widget di stato, metriche live e link rapidi.

---

## Perché Homepage

Con oltre dieci servizi attivi, avere un punto di accesso unico
fa risparmiare tempo e dà una visione immediata della salute
dell'intero stack. Homepage si integra nativamente con Docker
per mostrare lo stato dei container in tempo reale.

---

## Configurazione

| Parametro | Valore |
|---|---|
| **Immagine** | `ghcr.io/gethomepage/homepage:latest` |
| **Interfaccia** | HTTP |
| **Accesso** | LAN only |
| **Restart policy** | `unless-stopped` |
| **Rete** | `homepage_homepage-net` (bridge isolata) |

---

## Sicurezza: Docker Socket Proxy

Homepage legge lo stato dei container Docker per mostrare i widget
di monitoraggio. Il socket non viene montato direttamente: la
comunicazione avviene tramite `tecnativa/docker-socket-proxy`.

```
[Homepage] ──→ [socket-proxy-homepage] ──→ [Docker daemon]
```

Per i dettagli → [Docker Socket Proxy](../../../security/socket-proxy/README.md)

---

## File

| File | Descrizione |
|---|---|
| `docker-compose.yml` | Definizione del servizio e del socket proxy dedicato |
| `.env.example` | Variabili d'ambiente necessarie (copiare in `.env`) |

---

## Deploy

```bash
cp .env.example .env
nano .env
docker compose up -d
```

---

## Note

- La configurazione dei widget avviene tramite file YAML montati come volume — tutto versionabile su Git
- Supporta decine di integrazioni native: Grafana, Pi-hole, Immich, Portainer, Uptime Kuma e molti altri
- Tema e layout completamente personalizzabili
