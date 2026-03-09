# 🐻 Uptime Kuma

Uptime Kuma è uno strumento di monitoraggio dell'uptime self-hosted
che verifica continuamente la raggiungibilità di tutti i servizi
e invia notifiche immediate in caso di anomalie o downtime.

---

## Perché Uptime Kuma

Sapere che un servizio è "su" non basta — bisogna saperlo in tempo
reale quando va giù. Uptime Kuma effettua controlli periodici su
ogni servizio del homelab e notifica immediatamente via canali
configurabili, con uno storico visivo degli incidenti.

---

## Configurazione

| Parametro | Valore |
|---|---|
| **Immagine** | `louislam/uptime-kuma:1` |
| **Interfaccia** | HTTP, LAN only |
| **Restart policy** | `unless-stopped` |
| **Rete** | `uptime-kuma_kuma-net` (bridge isolata) |

---

## Sicurezza: Docker Socket Proxy

Uptime Kuma accede al Docker daemon per monitorare lo stato
dei container. Il socket non viene montato direttamente:
la comunicazione avviene tramite una istanza dedicata di
`tecnativa/docker-socket-proxy` con permessi minimi.

```
[Uptime Kuma] ──→ [socket-proxy-kuma] ──→ [Docker daemon]
```

Per i dettagli → [Docker Socket Proxy](../../../security/socket-proxy/README.md)

---

## Funzionalità

- Monitoraggio HTTP/HTTPS, TCP, DNS, ping e Docker container
- Dashboard visiva con storico uptime e tempi di risposta
- Notifiche via Telegram, Slack, email, Gotify e decine di altri canali
- Certificati SSL monitorati con alert prima della scadenza
- Status page pubblica o privata personalizzabile

---

## File

| File | Descrizione |
|---|---|
| `docker-compose.yml` | Definizione del servizio e del socket proxy dedicato |
| `.env.example` | Variabili d'ambiente necessarie (copiare in `.env`) |


---

## Note

- I monitor vanno configurati manualmente via interfaccia web al primo avvio
- I dati sono persistiti in un volume Docker dedicato
- Configurare almeno un canale di notifica prima di mettere in produzione
