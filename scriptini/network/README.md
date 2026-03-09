# 🌐 Network Scripts

Script per la diagnostica e il monitoraggio della connettività
di rete del server.

---

## Script

### `wifi_ceckup.sh`

Esegue un checkup completo della connettività di rete in un
colpo solo, utile per diagnosticare rapidamente problemi
di rete o verificare lo stato dopo un riavvio.

**Controlli eseguiti:**

- Ping a `8.8.8.8` — verifica connettività Internet
- Ping a `1.1.1.1` — verifica connettività su secondo DNS
- Ping a `google.com` — verifica risoluzione DNS
- Stato di tutte le interfacce di rete (`ip a`)
- Stato del firewall UFW

**Utilizzo:**

```bash
./wifi_ceckup.sh
```

**Output di esempio:**

```
==== CHECKUP WIFI SERVER 2026-03-09 23:00:00 ====

>> Test connessione a Internet:
PING 8.8.8.8: 1 packets transmitted, 1 received

>> Test risoluzione DNS:
PING google.com: 1 packets transmitted, 1 received

>> Stato interfacce di rete:
...

>> Stato del firewall:
Status: active
```

---

## Note

- Richiede `sudo` per la visualizzazione dello stato UFW
- Utile da eseguire dopo modifiche alla configurazione di rete
- In combinazione con `iperf3` per una diagnostica completa
