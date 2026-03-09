# 🌐 Rete

Architettura di rete del homelab: indirizzi, servizi esposti e isolamento.

---

## Topologia

Internet
│
Router
│
LAN (192.168.1.0/24)
│
ubuserver ←── IP statico assegnato dal router
│
├── Docker networks (bridge isolate per progetto)
└── VPN (WireGuard) ←── accesso remoto sicuro

---

## Indirizzi

| Interfaccia | Descrizione |
|---|---|
| LAN | IP statico in rete locale (assegnato via DHCP reservation) |
| VPN | Interfaccia WireGuard per accesso remoto |
| Docker bridge | Sottoreti interne isolate per ogni progetto Compose |

> Gli IP precisi non sono pubblicati per sicurezza.

---

## Servizi e Porte

Ogni servizio è raggiungibile **solo dalla rete locale** (o via VPN).
Nessun servizio è esposto direttamente su internet.

### 🐳 Servizi Docker

| Servizio | Categoria | Esposizione |
|---|---|---|
| Immich | Media | Porta dedicata, LAN only |
| Grafana | Monitoring | Porta dedicata, LAN only |
| Prometheus | Monitoring | Porta dedicata, LAN only |
| Node Exporter | Monitoring | Porta dedicata, LAN only |
| cAdvisor | Monitoring | Porta dedicata, LAN only |
| Uptime Kuma | Monitoring | Porta dedicata, LAN only |
| Portainer | Infrastructure | HTTPS, LAN only |
| Homepage | Infrastructure | Porta dedicata, LAN only |
| Pi-hole | Infrastructure | DNS su porta 53, LAN only |
| Memos | Productivity | Porta dedicata, LAN only |
| File Browser | Media | Porta dedicata, LAN only |
| BookStack | Productivity | Porta dedicata, LAN only |
| OpenSpeedTest | Productivity | Porta dedicata, LAN only |

### ⚙️ Servizi Nativi

| Servizio | Descrizione |
|---|---|
| Jellyfin | Streaming media, LAN only |
| Samba | File sharing SMB, LAN only |
| iperf3 | Test performance di rete |
| Webmin | Pannello admin, LAN only |
| SSH | Accesso amministrativo con chiave pubblica |

---

## DNS Locale con Pi-hole

Pi-hole funge da DNS resolver per tutta la rete locale:

- **Blocco pubblicità** a livello di rete per tutti i dispositivi
- **DNS personalizzati** per raggiungere i servizi con nomi leggibili
  invece di IP:porta (es. grafana.home invece di 192.168.1.x:3000)
- **Statistiche** su tutte le query DNS della rete

---

## Reti Docker Isolate

Ogni progetto Compose ha la propria rete bridge dedicata.
I container di progetti diversi non possono comunicare tra loro
a meno di una connessione esplicita — principio di least privilege.

| Rete | Progetto |
|---|---|
| bookstack_default | BookStack + MariaDB |
| diun_diun-net | Diun + Socket Proxy |
| grafana-prometheus_monitoring | Grafana · Prometheus · cAdvisor · Node Exporter |
| homepage_homepage-net | Homepage + Socket Proxy |
| immich_default | Immich · Postgres · Redis · Machine Learning |
| portainer_portainer-net | Portainer + Socket Proxy |
| uptime-kuma_kuma-net | Uptime Kuma + Socket Proxy |

---

## Accesso Remoto

L'accesso da fuori rete locale avviene esclusivamente tramite VPN WireGuard:
nessuna porta è aperta su internet, nessun reverse proxy pubblico (per ora).
Questo elimina alla radice la superficie di attacco esterna.
