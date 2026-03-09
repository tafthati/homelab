# 🔐 Docker Socket Proxy

Documentazione del pattern di sicurezza adottato per proteggere
l'accesso al Docker daemon da parte dei container che ne hanno bisogno.

---

## Il Problema: `/var/run/docker.sock`

Molti container (Portainer, Homepage, Uptime Kuma, Diun) necessitano
di comunicare con il Docker daemon per leggere lo stato dei container,
delle immagini e delle reti.

Il metodo più comune è montare direttamente il socket Unix:

```yaml
volumes:
  - /var/run/docker.sock:/var/run/docker.sock
```

Questo è **estremamente pericoloso**: chiunque riesca a compromettere
un container con accesso al socket ha di fatto **accesso root
all'intero sistema operativo host** e può creare container privilegiati,
montare il filesystem dell'host, eseguire comandi arbitrari.

---

## La Soluzione: Docker Socket Proxy

`tecnativa/docker-socket-proxy` è un proxy che si interpone tra
il container e il Docker daemon, esponendo solo le API Docker
strettamente necessarie e bloccando tutto il resto.

```
SENZA proxy (pericoloso)
[Container] ──→ /var/run/docker.sock ──→ [Docker daemon] ✗

CON proxy (sicuro)
[Container] ──→ [Socket Proxy] ──→ [Docker daemon] ✓
                  (API limitate)
```

---

## Implementazione nel Homelab

Ogni servizio che richiede accesso al Docker daemon ha la propria
istanza dedicata del proxy; principio di isolamento applicato
anche alla sicurezza.

| Servizio | Istanza Proxy | Permessi |
|---|---|---|
| Portainer | `socket-proxy-portainer` | Lettura container, immagini, volumi |
| Homepage | `socket-proxy-homepage` | Lettura container |
| Diun | `socket-proxy-diun` | Lettura immagini |
| Uptime Kuma | `socket-proxy-kuma` | Lettura container |

---

## Configurazione Tipo

Ogni `docker-compose.yml` che usa questo pattern segue questa struttura:

```yaml
services:
  socket-proxy:
    image: tecnativa/docker-socket-proxy:latest
    environment:
      CONTAINERS: 1   # permesso lettura container
      IMAGES: 1       # permesso lettura immagini
      POST: 0         # scrittura disabilitata
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
    networks:
      - proxy-net

  servizio-principale:
    image: ...
    environment:
      DOCKER_HOST: tcp://socket-proxy:2375
    networks:
      - proxy-net
```

---

## Principi Applicati

- **Least Privilege** → ogni proxy espone solo le API necessarie al servizio
- **Isolamento** → ogni servizio ha il proprio proxy dedicato
- **Read-only** → il socket viene montato in sola lettura sul proxy
- **Rete isolata** → proxy e servizio comunicano su una rete bridge privata,
  non raggiungibile dagli altri container
