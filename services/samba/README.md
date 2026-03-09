# 🗂️ Samba

Samba implementa il protocollo SMB/CIFS per la condivisione di file
in rete locale, trasforma il server in un NAS accessibile da
qualsiasi dispositivo: Windows, macOS, Linux, Android e iOS.

---

## Perché Samba

Avere un disco da 1 TB sul server è utile solo se è facilmente
accessibile da tutti i dispositivi di casa. Samba espone le cartelle
del server come unità di rete montabili, esattamente come un NAS
commerciale senza hardware aggiuntivo.

---

## Configurazione

| Parametro | Valore |
|---|---|
| **Tipo** | Servizio nativo systemd |
| **Protocollo** | SMB/CIFS |
| **Porte** | 139 (NetBIOS) · 445 (SMB) |
| **Accesso** | LAN only |
| **Restart policy** | Automatico via systemd |

---

## Storage

| Mount Point | Contenuto | Dimensione |
|---|---|---|
| `/percorso/della/cartella` | Cartella condivisa principale | ~931 GB |

---

## Funzionalità

- Condivisione file SMB compatibile con tutti i sistemi operativi
- Autenticazione con utenti dedicati Samba
- Accesso come unità di rete montabile (es. `\\homeserver\media`)
- Permessi granulari per utente e cartella
- Integrazione con Jellyfin per aggiungere contenuti alla libreria

---

## Gestione del Servizio

```bash
# Stato del servizio
sudo systemctl status smbd

# Riavvio
sudo systemctl restart smbd nmbd

# Log in tempo reale
sudo journalctl -u smbd -f

# Lista utenti Samba
sudo pdbedit -L
```

---

## Note

- `smbd` gestisce le condivisioni SMB, `nmbd` la risoluzione dei nomi NetBIOS
- Gli utenti Samba sono separati dagli utenti di sistema e vanno creati
  con `sudo smbpasswd -a nomeutente`
