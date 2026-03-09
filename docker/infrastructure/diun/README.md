# 🔔 Diun

Diun (Docker Image Update Notifier) monitora automaticamente
tutte le immagini Docker in uso e invia una notifica quando
viene rilasciata una nuova versione upstream — nessun
aggiornamento inaspettato, pieno controllo su quando aggiornare.

---

## Perché Diun

Tenere le immagini Docker aggiornate è fondamentale per la
sicurezza, ma farlo manualmente su decine di container è
dispersivo. Diun automatizza il controllo e avvisa in tempo
reale, lasciando però la decisione di aggiornare sempre
all'amministratore.

---

## Configurazione

| Parametro | Valore |
|---|---|
| **Immagine** | `crazymax/diun:latest` |
| **Accesso** | Nessuna porta esposta |
| **Restart policy** | `unless-stopped` |
| **Rete** | `diun_diun-net` (bridge isolata) |

---

## Sicurezza: Docker Socket Proxy

Diun necessita di leggere la lista delle immagini Docker in uso.
Il socket non viene montato direttamente: la comunicazione
avviene tramite una istanza dedicata di
`tecnativa/docker-socket-proxy` con permessi minimi.

```
[Diun] ──→ [socket-proxy-diun] ──→ [Docker daemon]
```

Per i dettagli → [Docker Socket Proxy](../../../security/socket-proxy/README.md)

---

## Funzionalità

- Monitora automaticamente tutte le immagini dei container in esecuzione
- Confronta il digest locale con quello del registry remoto
- Invia notifiche via canali configurabili (Telegram, Slack, email, Gotify e altri)
- Scheduling personalizzabile via cron expression
- Supporta registry privati e pubblici (Docker Hub, GHCR, Quay.io)

---

## File

| File | Descrizione |
|---|---|
| `docker-compose.yml` | Definizione del servizio e del socket proxy dedicato |
| `.env.example` | Variabili d'ambiente necessarie (copiare in `.env`) |


---

## Note

- Diun non aggiorna mai automaticamente le immagini — si limita a notificare
- Il canale di notifica va configurato nel `.env` prima del primo avvio
- I log mostrano in dettaglio ogni immagine monitorata e il suo stato
