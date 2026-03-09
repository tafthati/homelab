# ⚙️ System Scripts

Script per la manutenzione e il monitoraggio del sistema operativo
e dell'hardware del server.

---

## Script

### `disk_salute.sh`

Monitoraggio completo della salute dei dischi fisici tramite
parametri S.M.A.R.T. — controlla i valori critici di tutti
i dischi e salva un log mensile con storico nel tempo.

**Controlli eseguiti:**

- Health status generale (`PASSED` / `FAILED`)
- Reallocated Sector Count — settori danneggiati rimappati
- Current Pending Sectors — settori in attesa di rimappatura
- UDMA CRC Error Count — errori di trasmissione (cavo SATA/USB)
- Temperatura del disco
- Power On Hours — ore totali di utilizzo

**Utilizzo:**

```bash
sudo ./disk_salute.sh
```

**Log:**

I log vengono salvati automaticamente in `~/disk_health_logs/`
con un file per mese — utile per monitorare i trend nel tempo.

```
~/disk_health_logs/
├── disk_health_2026-01.log
├── disk_health_2026-02.log
└── disk_health_2026-03.log
```

---

### `luminosita_giorno.sh`

Ripristina la luminosità dello schermo al valore ottimale
per l'uso diurno tramite il backlight controller Intel.

**Utilizzo:**

```bash
sudo ./luminosita_giorno.sh
```

---

### `luminosita_notte.sh`

Riduce la luminosità dello schermo al minimo per l'uso
notturno — ideale per non affaticare gli occhi di notte.

**Utilizzo:**

```bash
sudo ./luminosita_notte.sh
```

---

## Note

- `disk_salute.sh` richiede `smartmontools` installato sul sistema
- Gli script di luminosità richiedono `sudo` e funzionano solo
  su hardware con backlight Intel (`intel_backlight`)
- Eseguire `disk_salute.sh` regolarmente — consigliato via cron
  almeno una volta a settimana
