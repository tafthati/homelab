# 🐳 Docker Scripts

Script per la gestione e l'aggiornamento dei servizi Docker
in esecuzione sul server.

---

## Script

### `aggiorna_docker.sh`

Gestisce l'aggiornamento interattivo dei servizi Docker Compose.
Individua automaticamente tutti i progetti, permette di selezionare
quali aggiornare, verifica la salute dei container dopo l'update
e invia notifiche in tempo reale via Telegram.

**Funzionalità:**

- Scansione automatica di tutti i `docker-compose.yml` presenti
- Selezione interattiva dei servizi da aggiornare
- Modalità `--all` per aggiornare tutto in un colpo solo
- Verifica dello stato e dell'healthcheck dopo ogni aggiornamento
- Notifiche Telegram per successi ed errori
- Pulizia automatica delle immagini inutilizzate a fine aggiornamento

**Utilizzo:**

```bash
# Modalità interattiva — seleziona i servizi da aggiornare
./aggiorna_docker.sh

# Modalità automatica — aggiorna tutti i servizi
./aggiorna_docker.sh --all
```

**Output di esempio:**

```
==========================================
   Gestore Aggiornamenti Docker 🐳
==========================================
Data: Mon Mar 09 23:00:00 2026

Servizi trovati:
 1. bookstack
 2. grafana-prometheus
 3. immich
 ...

Inserisci numeri servizi (es: 1 3 5 o 1,3,5):
```

---

## Note

- Le credenziali Telegram non vanno mai hardcoded nello script
- In caso di errore su un servizio lo script si interrompe subito
  e invia una notifica Telegram con il dettaglio del problema
