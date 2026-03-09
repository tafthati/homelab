# 🛠️ Scriptini

Raccolta di script bash scritti per automatizzare operazioni
ricorrenti sul server — manutenzione, monitoraggio e gestione
dei servizi Docker.

---

## Struttura

| Cartella | Descrizione |
|---|---|
| [network/](./network/) | Script per diagnostica e monitoraggio della rete |
| [system/](./system/) | Script per manutenzione e monitoraggio del sistema |
| [docker/](./docker/) | Script per la gestione dei container Docker |

---

## Script Disponibili

| Script | Categoria | Descrizione |
|---|---|---|
| [wifi_ceckup.sh](./network/wifi_ceckup.sh) | Network | Diagnostica completa della connettività di rete |
| [disk_salute.sh](./system/disk_salute.sh) | System | Monitoraggio salute S.M.A.R.T. dei dischi fisici |
| [luminosita_giorno.sh](./system/luminosita_giorno.sh) | System | Ripristina luminosità schermo per uso diurno |
| [luminosita_notte.sh](./system/luminosita_notte.sh) | System | Riduce luminosità schermo per uso notturno |
| [aggiorna_docker.sh](./docker/aggiorna_docker.sh) | Docker | Aggiornamento interattivo dei servizi Docker con notifiche Telegram |

---

## Utilizzo Generale

```bash
# Rendere eseguibile uno script
chmod +x nomescript.sh

# Eseguire uno script
./nomescript.sh

# Eseguire con privilegi elevati (se richiesto)
sudo ./nomescript.sh
```

---

## Note

- Gli script che richiedono variabili d'ambiente sensibili (token, ID)
  hanno un file `.env.example` nella stessa cartella
- Nessun segreto è hardcoded — le credenziali vanno sempre in `.env`
- I file `.env` reali sono esclusi dal repository tramite `.gitignore`
