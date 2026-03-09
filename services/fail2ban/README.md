# 🛡️ Fail2ban

Fail2ban monitora i log di sistema e blocca automaticamente gli
indirizzi IP che mostrano comportamenti sospetti, tentativi
di brute-force SSH, accessi falliti ripetuti e scansioni di porte.

---

## Perché Fail2ban

Un server con SSH esposto riceve tentativi di accesso automatizzati
costantemente; bot che provano combinazioni di credenziali 24 ore
su 24. Fail2ban rileva questi pattern nei log e blocca l'IP
sorgente tramite regole firewall automatiche, riducendo
drasticamente la superficie di attacco.

---

## Configurazione

| Parametro | Valore |
|---|---|
| **Tipo** | Servizio nativo systemd |
| **Restart policy** | Automatico via systemd |

---

## Come Funziona

```
[Tentativo di login fallito]
          │
    [Fail2ban legge i log]
          │
    [Soglia superata?]
       │        │
      NO        SI
       │        │
   Ignora    [Blocco IP via iptables]
             [Notifica opzionale]
             [Ban temporaneo o permanente]
```

---

## Jail Attive

| Jail | Servizio Monitorato | Trigger |
|---|---|---|
| `sshd` | OpenSSH | Tentativi di login falliti |

---

## Gestione del Servizio

```bash
# Stato del servizio
sudo systemctl status fail2ban

# Lista IP bannati
sudo fail2ban-client status sshd

# Sbloccare un IP manualmente
sudo fail2ban-client set sshd unbanip <IP>

# Log in tempo reale
sudo journalctl -u fail2ban -f
```

---

## Note

- Fail2ban è la prima linea di difesa attiva del server
- Opera in sinergia con l'autenticazione SSH a chiave pubblica —
  insieme rendono praticamente impossibile un accesso non autorizzato
- I ban sono temporanei per default e configurabili in permanenti
  per IP particolarmente aggressivi
