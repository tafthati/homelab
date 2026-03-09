# 🐳 Servizi Docker

Tutti i servizi del homelab girano come container Docker,
organizzati per categoria tramite Docker Compose.
Ogni servizio ha la propria cartella con `docker-compose.yml`,
`.env.example` e `README.md` dedicato.

---

## Categorie

| Categoria | Descrizione |
|---|---|
| [infrastructure](./infrastructure/) | Backbone operativo del server |
| [monitoring](./monitoring/) | Observability stack completo |
| [media](./media/) | Gestione file e contenuti multimediali |
| [productivity](./productivity/) | Strumenti di produttività personale |

---

## Servizi

| Servizio | Categoria | Immagine |
|---|---|---|
| [Portainer](./infrastructure/portainer/) | Infrastructure | `portainer/portainer-ce` |
| [Homepage](./infrastructure/homepage/) | Infrastructure | `ghcr.io/gethomepage/homepage` |
| [Pi-hole](./infrastructure/pihole/) | Infrastructure | `pihole/pihole` |
| [Diun](./infrastructure/diun/) | Infrastructure | `crazymax/diun` |
| [Grafana + Prometheus](./monitoring/grafana-prometheus/) | Monitoring | `grafana/grafana` + `prom/prometheus` |
| [Uptime Kuma](./monitoring/uptime-kuma/) | Monitoring | `louislam/uptime-kuma` |
| [Immich](./media/immich/) | Media | `ghcr.io/immich-app/immich-server` |
| [File Browser](./media/file-browser/) | Media | `filebrowser/filebrowser` |
| [BookStack](./productivity/bookstack/) | Productivity | `lscr.io/linuxserver/bookstack` |
| [Memos](./productivity/memos/) | Productivity | `neosmemo/memos` |
| [OpenSpeedTest](./productivity/openspeedtest/) | Productivity | `openspeedtest/latest` |

---

## Convenzioni

- Ogni cartella contiene sempre `docker-compose.yml`, `.env.example` e `README.md`
- I file `.env` reali sono esclusi dal repository tramite `.gitignore`
- I servizi che necessitano di accesso al Docker daemon usano
  `tecnativa/docker-socket-proxy` — mai il socket diretto
- Tutte le porte sono esposte esclusivamente in LAN, mai su internet
