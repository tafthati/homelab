# 🎬 Jellyfin

Jellyfin è un media server self-hosted per lo streaming di film,
serie TV, musica e foto in rete locale, un'alternativa open source
e completamente gratuita a Plex e Emby.

---

## Perché Jellyfin

Avere una libreria multimediale personale significa poter accedere
ai propri contenuti da qualsiasi dispositivo in casa senza
abbonamenti, senza limitazioni e senza che i dati passino
per server di terze parti. Jellyfin è installato nativamente
sul sistema operativo per avere accesso diretto e performante
ai dischi di storage.

---

## Configurazione

| Parametro | Valore |
|---|---|
| **Tipo** | Servizio nativo systemd |
| **Interfaccia** | HTTP, LAN only |
| **Restart policy** | Automatico via systemd |

---

## Storage

| Mount Point | Contenuto |
|---|---|
| `/cartella/nome_mount` | Libreria multimediale principale (~500 GB) |

---

## Funzionalità

- Streaming video con transcodifica automatica in base al dispositivo
- Supporto subtitoli embedded e file esterni
- App native per Android, iOS, TV, browser e console
- Libreria organizzata automaticamente con copertine e metadati
- Gestione utenti con profili e controllo genitori
- Nessun abbonamento, nessun account obbligatorio

---

## Gestione del Servizio

```bash
# Stato del servizio
sudo systemctl status jellyfin

# Riavvio
sudo systemctl restart jellyfin

# Log in tempo reale
sudo journalctl -u jellyfin -f
```

---

## Note

- Installato come pacchetto nativo per performance di transcodifica ottimali
- In combinazione con Samba, i file possono essere aggiunti alla libreria
  anche tramite file sharing dalla rete locale
