<div align="center">

# 🏠 Casalab

**Documentazione completa del mio home server self-hosted**

[![Docker](https://img.shields.io/badge/Docker-20.10+-2496ED?style=flat-square&logo=docker&logoColor=white)](https://www.docker.com/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-Server-E95420?style=flat-square&logo=ubuntu&logoColor=white)](https://ubuntu.com/server)
[![Uptime](https://img.shields.io/badge/Uptime-99%25-brightgreen?style=flat-square)](https://github.com/tafthati/homelab)
[![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)](LICENSE)

</div>

---

## 📖 Cos'è questo progetto?

Questo repository documenta l'evoluzione del mio home server nel tempo: configurazioni,
servizi self-hosted, scelte architetturali, lezioni imparate e cose rotte.
Tutto gira su un server Ubuntu fisico in rete locale, collegato in Wi-Fi (brrr)

> 💡 **Filosofia**: ogni servizio è containerizzato con Docker Compose,
> isolato in reti dedicate, e protetto dove possibile tramite
> [Docker Socket Proxy](./security/socket-proxy/README.md).

---

## 🗂️ Struttura del Repository

| Cartella | Contenuto |
|---|---|
| 📁 [`docs/`](./docs/) | Architettura, hardware e rete |
| 📁 [`docker/infrastructure/`](./docker/infrastructure/) | Backbone del server |
| 📁 [`docker/monitoring/`](./docker/monitoring/) | Observability stack completo |
| 📁 [`docker/media/`](./docker/media/) | Gestione file e contenuti multimediali |
| 📁 [`docker/productivity/`](./docker/productivity/) | Strumenti di produttività personale |
| 📁 [`services/`](./services/) | Servizi installati nativamente su systemd |
| 📁 [`security/`](./security/) | Pattern e configurazioni di sicurezza |

---

## 🐳 Servizi Docker

| Categoria | Servizio | Descrizione |
|---|---|---|
| **Infrastructure** | [Portainer](./docker/infrastructure/portainer/) | GUI per la gestione dei container |
| **Infrastructure** | [Homepage](./docker/infrastructure/homepage/) | Dashboard centralizzata dei servizi |
| **Infrastructure** | [Pi-hole](./docker/infrastructure/pihole/) | DNS server + ad-blocking di rete |
| **Infrastructure** | [Diun](./docker/infrastructure/diun/) | Notifiche aggiornamenti immagini Docker |
| **Monitoring** | [Grafana + Prometheus](./docker/monitoring/grafana-prometheus/) | Metriche e dashboard di sistema |
| **Monitoring** | [Uptime Kuma](./docker/monitoring/uptime-kuma/) | Monitoraggio uptime dei servizi |
| **Media** | [Immich](./docker/media/immich/) | Backup e gestione foto self-hosted |
| **Media** | [File Browser](./docker/media/file-browser/) | Esplora file via web |
| **Productivity** | [BookStack](./docker/productivity/bookstack/) | Wiki e documentazione interna |
| **Productivity** | [Memos](./docker/productivity/memos/) | Note rapide self-hosted |
| **Productivity** | [OpenSpeedTest](./docker/productivity/openspeedtest/) | Test velocità rete locale |

---

## ⚙️ Servizi Nativi

| Servizio | Descrizione |
|---|---|
| [Jellyfin](./services/jellyfin/) | Media server per film e serie |
| [Samba](./services/samba/) | File sharing in rete locale (NAS) |
| [Fail2ban](./services/fail2ban/) | Protezione da brute-force SSH |
| [Webmin](./services/webmin/) | Pannello di amministrazione web |
| [iperf3](./services/iperf3/) | Testing performance di rete |
| [Smartmontools](./services/smartmontools/) | Monitoraggio salute dei dischi |

---

## 🔐 Sicurezza

Tutti i container che necessitano di accesso al Docker daemon usano
[`tecnativa/docker-socket-proxy`](./security/socket-proxy/README.md)
invece di montare `/var/run/docker.sock` direttamente, limitando i permessi
al minimo necessario.

---

## 📚 Documentazione

- [🏗️ Architettura](./docs/architecture.md) — Schema logico di tutti i servizi
- [🖥️ Hardware](./docs/hardware.md) — Specifiche del server fisico
- [🌐 Rete](./docs/network.md) — Schema IP, porte, DNS

---

<div align="center">

*Self-hosted with ❤️  and 🚬.  Built to learn, documented to share*

</div>
