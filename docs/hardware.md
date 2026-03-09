# 🖥️ Hardware

Specifiche del server fisico su cui gira l'intero homelab.

---

## Scheda Tecnica

| Componente | Dettaglio |
|---|---|
| **Hostname** | `ubuserver` |
| **OS** | Ubuntu Server 24.04 LTS (Noble Numbat) |
| **CPU** | Intel Core i3 4th Gen (2 core fisici · 4 thread) |
| **RAM** | ~8 GB DDR3 |
| **Swap** | ~11 GB |

---

## Archiviazione

| Dispositivo | Capacità (approx.) | Utilizzo |
|---|---|---|
| Disco di sistema | ~250 GB SSD | OS + dati Docker + root `/` |
| Disco NAS | ~1 TB HDD | Archiviazione Samba (file sharing LAN) |
| Disco Media | ~500 GB HDD | Libreria multimediale Jellyfin |

**Totale storage disponibile:** ~1.7 TB

---

## Note

- Server **fisico** con installazione bare-metal di Ubuntu Server
- Il disco di sistema ospita OS e tutti i volumi Docker
- I due dischi secondari sono dedicati esclusivamente allo storage
- La memoria swap da 11GB garantiscce aura infinita
- Regalato dal mio bff Ludovico
