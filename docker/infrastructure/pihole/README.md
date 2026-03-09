# 🕳️ Pi-hole

Pi-hole è un DNS server locale che funge da ad-blocker a livello
di rete — blocca pubblicità, tracker e domini malevoli per tutti
i dispositivi connessi alla rete locale, senza installare nulla
sui singoli dispositivi.

---

## Perché Pi-hole

Invece di installare un'estensione ad-blocker su ogni browser
di ogni dispositivo, Pi-hole intercetta le query DNS a livello
di rete e blocca i domini indesiderati alla fonte. Funziona su
qualsiasi dispositivo: PC, smartphone, TV, console.

---

## Configurazione

| Parametro | Valore |
|---|---|
| **Immagine** | `pihole/pihole:latest` |
| **Protocollo** | DNS (porta 53) |
| **Interfaccia web** | HTTP, LAN only |
| **Accesso** | LAN only |
| **Restart policy** | `unless-stopped` |
| **Rete** | `pihole_default` (bridge isolata) |

---

## Funzionalità

- **Blocco DNS** → le query verso domini pubblicitari ricevono risposta
  nulla, il browser non carica nemmeno la richiesta
- **DNS personalizzati** → permette di definire record DNS locali
  per raggiungere i servizi del homelab con nomi leggibili
  (es. `grafana.home`, `immich.home`) invece di `IP:porta`
- **Dashboard statistica** → mostra in tempo reale quante query
  vengono bloccate, i domini più richiesti e i dispositivi più attivi
- **Blocklist personalizzabili** → aggiornabili con semplici URL

---

## File

| File | Descrizione |
|---|---|
| `docker-compose.yml` | Definizione del servizio |
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

- Il router di rete deve essere configurato per usare l'IP del server
  come DNS primario, oppure impostarlo manualmente su ogni dispositivo
- In caso Pi-hole sia irraggiungibile, la rete perde la risoluzione DNS —
  configurare sempre un DNS secondario (es. `1.1.1.1`) come fallback
- Le statistiche e le blocklist sono persistite in un volume Docker
