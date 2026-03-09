# 💾 Smartmontools

Smartmontools monitora la salute dei dischi fisici tramite la
tecnologia S.M.A.R.T. (Self-Monitoring, Analysis and Reporting
Technology), legge i sensori interni dei dischi e avvisa
in anticipo di possibili guasti imminenti.

---

## Perché Smartmontools

I dischi fisici si guastano è questione di quando, non di se.
Smartmontools legge continuamente i parametri S.M.A.R.T. dei
dischi (temperatura, settori danneggiati, ore di utilizzo,
errori di lettura) e permette di intervenire prima che un
guasto provochi perdita di dati irreversibile.

---

## Configurazione

| Parametro | Valore |
|---|---|
| **Tipo** | Servizio nativo systemd |
| **Daemon** | `smartd` |
| **Restart policy** | Automatico via systemd |

---

## Dischi Monitorati

| Disco | Dimensione | Utilizzo |
|---|---|---|
| `sda` | ~250 GB | Sistema operativo e dati Docker |
| `sdb` | ~1 TB | Storage Samba |
| `sdc` | ~500 GB | Libreria Jellyfin |

---

## Comandi Utili

```bash
# Stato di salute rapido di tutti i dischi
sudo smartctl -H /dev/sda
sudo smartctl -H /dev/sdb
sudo smartctl -H /dev/sdc

# Report completo con tutti i parametri S.M.A.R.T.
sudo smartctl -a /dev/sda

# Avvia un test breve sul disco (dura ~2 minuti)
sudo smartctl -t short /dev/sda

# Avvia un test esteso sul disco (dura ore)
sudo smartctl -t long /dev/sda

# Visualizza i risultati dell'ultimo test
sudo smartctl -l selftest /dev/sda
```

---

## Gestione del Servizio

```bash
# Stato del servizio
sudo systemctl status smartmontools

# Log in tempo reale
sudo journalctl -u smartmontools -f
```

---

## Parametri S.M.A.R.T. Critici

| Parametro | Descrizione | Soglia di allarme |
|---|---|---|
| `Reallocated_Sector_Ct` | Settori danneggiati rimappati | Qualsiasi valore > 0 |
| `Pending_Sector_Count` | Settori in attesa di rimappatura | Qualsiasi valore > 0 |
| `Temperature_Celsius` | Temperatura del disco | Sopra 50°C |
| `Power_On_Hours` | Ore totali di utilizzo | Riferimento per età disco |

---

## Note

- Un valore `PASSED` al controllo di salute non garantisce che il disco
  non si guasti; monitorare nel tempo i trend dei parametri critici
- In caso di `Reallocated_Sector_Ct` > 0 pianificare subito la sostituzione
- Fare sempre backup prima di qualsiasi operazione su dischi con anomalie
