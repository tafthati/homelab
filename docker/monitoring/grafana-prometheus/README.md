# 📊 Grafana + Prometheus

Stack completo di observability per il monitoraggio in tempo reale
di hardware e container. Prometheus raccoglie e storicizza le metriche,
Grafana le visualizza in dashboard interattive e personalizzabili.

---

## Perché questo stack

Un server che gira 24/7 con decine di container ha bisogno di essere
osservato, non solo gestito. Questo stack permette di vedere in un colpo
d'occhio l'utilizzo di CPU, RAM, disco e rete — sia del sistema operativo
che di ogni singolo container — con storico nel tempo e possibilità
di configurare alert.

---

## Componenti

| Container | Immagine | Ruolo |
|---|---|---|
| `grafana` | `grafana/grafana:latest` | Visualizzazione dashboard e alerting |
| `prometheus` | `prom/prometheus:latest` | Aggregazione e storage delle metriche |
| `node-exporter` | `quay.io/prometheus/node-exporter:latest` | Metriche hardware del sistema operativo |
| `cadvisor` | `gcr.io/cadvisor/cadvisor:latest` | Metriche di ogni container Docker |

---

## Flusso dei Dati

```
[Hardware OS]          [Container Docker]
      │                       │
[Node Exporter]          [cAdvisor]
      │                       │
      └──────────┬────────────┘
                 │
            [Prometheus]
            (scraping ogni 15s)
                 │
             [Grafana]
          (dashboard + alert)
```

---

## Configurazione

| Parametro | Valore |
|---|---|
| **Accesso Grafana** | HTTP, LAN only |
| **Accesso Prometheus** | HTTP, LAN only |
| **Restart policy** | `unless-stopped` |
| **Rete** | `grafana-prometheus_monitoring` (bridge isolata) |

---

## File

| File | Descrizione |
|---|---|
| `docker-compose.yml` | Definizione di tutti e 4 i container dello stack |
| `.env.example` | Variabili d'ambiente necessarie (copiare in `.env`) |


---

## Note

- Al primo avvio Grafana chiede di impostare una nuova password admin
- Prometheus scraping interval configurabile nel `prometheus.yml`
- I dati di Grafana e Prometheus sono persistiti in volumi Docker dedicati
- Node Exporter e cAdvisor non espongono interfacce grafiche — sono
  sorgenti dati per Prometheus

---

## ⚠️ Note di sicurezza

Il file `prometheus/prometheus.yml` non è incluso in questo repository
perché contiene credenziali di autenticazione per gli endpoint di scraping.

Per ripristinare la configurazione, crea manualmente il file
`prometheus/prometheus.yml` seguendo il template commentato nel compose.

