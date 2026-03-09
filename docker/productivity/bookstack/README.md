# 📚 BookStack

BookStack è una piattaforma wiki self-hosted per la documentazione
interna, organizzata gerarchicamente in Scaffali, Libri, Capitoli
e Pagine — semplice da usare, potente da organizzare.

---

## Perché BookStack

Un homelab cresce nel tempo e con esso la complessità delle
configurazioni, delle procedure e delle decisioni tecniche prese.
BookStack permette di documentare tutto in modo strutturato:
guide di installazione, configurazioni, troubleshooting, note
di progetto — tutto consultabile e ricercabile in un secondo.

---

## Componenti

| Container | Immagine | Ruolo |
|---|---|---|
| `bookstack` | `lscr.io/linuxserver/bookstack:latest` | Applicazione web principale |
| `bookstack_db` | `lscr.io/linuxserver/mariadb:latest` | Database MySQL/MariaDB |

---

## Configurazione

| Parametro | Valore |
|---|---|
| **Interfaccia** | HTTP, LAN only |
| **Restart policy** | `unless-stopped` |
| **Rete** | `bookstack_default` (bridge isolata) |

---

## Struttura dei Contenuti

BookStack organizza i contenuti in quattro livelli gerarchici:

    Scaffale (Shelf)
    └── Libro (Book)
        └── Capitolo (Chapter)
            └── Pagina (Page)

---

## Funzionalità

- Editor visuale WYSIWYG e editor Markdown
- Ricerca full-text su tutti i contenuti
- Storico delle revisioni per ogni pagina
- Permessi granulari per utenti e gruppi
- Esportazione in PDF, HTML e testo semplice
- Supporto immagini e allegati nelle pagine

---

## File

| File | Descrizione |
|---|---|
| `docker-compose.yml` | Definizione di BookStack e MariaDB |
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

- Il database MariaDB va avviato e pronto prima che BookStack si connetta
- Fare backup regolari del volume del database — contiene tutta la documentazione
- I dati sono persistiti in volumi Docker dedicati per app e database
