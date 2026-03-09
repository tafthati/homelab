# 🖥️ Webmin

Webmin è un pannello di amministrazione web per la gestione
del sistema operativo Linux e permette di configurare utenti,
servizi, firewall, aggiornamenti e molto altro tramite
interfaccia grafica senza usare il terminale.

---

## Perché Webmin

Alcune operazioni di amministrazione di sistema sono più rapide
e meno soggette a errori tramite interfaccia grafica. Webmin
offre un pannello centralizzato per gestire gli aspetti del
sistema operativo che non sono coperti da Portainer: utenti
di sistema, cron job, configurazioni di rete, log di sistema
e stato dei servizi systemd.

---

## Configurazione

| Parametro | Valore |
|---|---|
| **Tipo** | Servizio nativo systemd |
| **Interfaccia** | HTTPS, LAN only |
| **Porta** | 10000 |
| **Restart policy** | Automatico via systemd |

---

## Funzionalità

- Gestione utenti e gruppi di sistema
- Monitoraggio e controllo servizi systemd
- Configurazione firewall (iptables/ufw)
- Gestione pacchetti e aggiornamenti di sistema
- Visualizzazione e rotazione dei log
- Gestione cron job con interfaccia visuale
- File manager integrato
- Dashboard con metriche CPU, RAM e disco

---

## Gestione del Servizio

```bash
# Stato del servizio
sudo systemctl status webmin

# Riavvio
sudo systemctl restart webmin

# Log in tempo reale
sudo journalctl -u webmin -f
```

---

## Note

- Webmin usa HTTPS con certificato autofirmato, il browser mostrerà
  un avviso alla prima apertura, è normale
- Accessibile esclusivamente dalla rete locale
- Complementare a Portainer: Webmin gestisce il sistema operativo,
  Portainer gestisce i container Docker
