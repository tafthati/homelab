# 🏗️ Architettura

Schema logico di tutti i servizi e come interagiscono tra loro.

---

## Overview

Il mio homelab gira su un server fisico Ubuntu con tre livelli principali:
Docker Engine per i servizi containerizzati, servizi nativi systemd per
le funzionalità di sistema, e due dischi secondari dedicati allo storage.

---

## Categorie di Servizi

### 🏗️ Infrastructure
Servizi che costituiscono il backbone operativo del server.

| Servizio | Ruolo |
|---|---|
| Portainer | GUI per gestione e monitoring dei container Docker |
| Homepage | Dashboard centralizzata con panoramica di tutti i servizi |
| Pi-hole | DNS server locale + blocco pubblicità a livello di rete |
| Diun | Notifiche automatiche per aggiornamenti immagini Docker |

### 📊 Monitoring
Stack completo di osservabilità per hardware e container.

| Servizio | Ruolo |
|---|---|
| Node Exporter | Raccoglie metriche hardware (CPU, RAM, disco, rete) |
| cAdvisor | Raccoglie metriche di ogni singolo container Docker |
| Prometheus | Aggrega e storicizza tutte le metriche nel tempo |
| Grafana | Visualizza le metriche in dashboard interattive |
| Uptime Kuma | Monitora l'uptime e la raggiungibilità di ogni servizio |

### 🖼️ Media
Gestione e accesso ai contenuti multimediali.

| Servizio | Ruolo |
|---|---|
| Immich | Backup automatico e gestione foto self-hosted (alternativa Google Photos) |
| File Browser | Esplorazione e gestione file via interfaccia web |

### 📝 Productivity
Strumenti di produttività personale self-hosted.

| Servizio | Ruolo |
|---|---|
| BookStack | Wiki e documentazione interna organizzata per libri e capitoli |
| Memos | Note rapide in stile microblog, self-hosted |
| OpenSpeedTest | Test della velocità della rete locale via browser |

### ⚙️ Servizi Nativi
Servizi installati direttamente sul sistema operativo via systemd.

| Servizio | Ruolo |
|---|---|
| Jellyfin | Media server per streaming film e serie in rete locale |
| Samba | File sharing SMB per accesso NAS da tutti i dispositivi in LAN |
| Fail2ban | Protezione automatica da tentativi di brute-force SSH |
| Webmin | Pannello di amministrazione web del server |
| iperf3 | Testing delle performance di rete tra dispositivi |
| Smartmontools | Monitoraggio della salute S.M.A.R.T. dei dischi fisici |

---

## Stack di Monitoring — Flusso dei Dati

Il monitoring segue un flusso unidirezionale a quattro stadi:

  [Hardware + Container]
          │
          ▼
  [Node Exporter + cAdvisor]   ← raccolta metriche
          │
          ▼
      [Prometheus]              ← aggregazione e storage
          │
          ▼
       [Grafana]                ← visualizzazione e alerting

---

## Pattern di Sicurezza: Docker Socket Proxy

Portainer, Homepage, Diun e Uptime Kuma necessitano di comunicare
con il Docker daemon per leggere lo stato dei container.

Esporre direttamente /var/run/docker.sock equivale a dare accesso root
al sistema operativo a chiunque riesca a compromettere il container, e io sono scarso.

Quindi......

La soluzione adottata prevede un'istanza dedicata di
tecnativa/docker-socket-proxy per ogni servizio, con permessi minimi
e in sola lettura — principio di least privilege applicato a Docker.

  Portainer    →  socket-proxy-portainer  →  Docker daemon
  Homepage     →  socket-proxy-homepage   →  Docker daemon
  Diun         →  socket-proxy-diun       →  Docker daemon
  Uptime Kuma  →  socket-proxy-kuma       →  Docker daemon

---

## Gestione Aggiornamenti

Diun (Docker Image Update Notifier) monitora continuamente tutte le
immagini Docker in uso e invia una notifica Telegram non appena viene rilasciata
una nuova versione upstream. Gli aggiornamenti vengono quindi applicati
manualmente e consapevolmente — nessun auto-update inaspettato.
