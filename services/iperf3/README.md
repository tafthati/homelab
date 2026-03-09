# 📡 iperf3

iperf3 è uno strumento per la misurazione delle performance di rete
tra due dispositivi; misura la banda reale disponibile, la latenza
e la qualità del collegamento in modo preciso e affidabile; in più fa figo.

---

## Perché iperf3

OpenSpeedTest misura la velocità tra un browser e il server.
iperf3 va più in profondità: misura la banda TCP/UDP reale
tra due endpoint qualsiasi, utile per diagnosticare colli
di bottiglia nella rete locale, confrontare Wi-Fi e cablato,
e verificare le performance effettive dei collegamenti.

---

## Configurazione

| Parametro | Valore |
|---|---|
| **Tipo** | Servizio nativo systemd |
| **Protocollo** | TCP/UDP |
| **Porta** | 5201 |
| **Modalità** | Server (in ascolto permanente) |
| **Restart policy** | Automatico via systemd |

---

## Utilizzo

Il server iperf3 gira in ascolto permanente sul server.
Per eseguire un test basta avere iperf3 installato sul
dispositivo client e lanciare:

```bash
# Test TCP (default) — misura banda in download
iperf3 -c <IP_SERVER>

# Test UDP — misura banda e packet loss
iperf3 -c <IP_SERVER> -u -b 1G

# Test bidirezionale — misura upload e download insieme
iperf3 -c <IP_SERVER> --bidir

# Test con durata personalizzata (es. 30 secondi)
iperf3 -c <IP_SERVER> -t 30
```

---

## Gestione del Servizio

```bash
# Stato del servizio
sudo systemctl status iperf3

# Riavvio
sudo systemctl restart iperf3

# Log in tempo reale
sudo journalctl -u iperf3 -f
```

---

## Note

- iperf3 in modalità server non consuma risorse quando non è in uso
- Utile in coppia con OpenSpeedTest per una diagnosi completa della rete
- Per test accurati usare connessione cablata sul dispositivo client
- L'IP del server va sostituito con quello reale in rete locale
