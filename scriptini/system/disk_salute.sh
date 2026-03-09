#!/bin/bash
#
# Script di monitoraggio salute dischi per ubuserver
# Controlla parametri SMART critici di /dev/sda e /dev/sdb
# Salva log in ~/disk_health_logs/
#

# Configurazione
LOG_DIR="$HOME/disk_health_logs"
LOG_FILE="$LOG_DIR/disk_health_$(date +%Y-%m).log"
ALERT_EMAIL=""  # Lascia vuoto o inserisci tua email per notifiche

# Colori per output terminale
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Crea directory log se non esiste
mkdir -p "$LOG_DIR"

# Funzione per stampare e loggare
log_print() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

# Funzione per controllare un disco
check_disk() {
    local DISK=$1
    local DISK_NAME=$2
    
    log_print "\n${YELLOW}=== Controllo $DISK_NAME ($DISK) ===${NC}"
    
    # Health check generale
    HEALTH=$(sudo smartctl -H "$DISK" 2>/dev/null | grep "SMART overall-health" | awk '{print $NF}')
    if [ "$HEALTH" == "PASSED" ]; then
        log_print "${GREEN}✓ Health Status: PASSED${NC}"
    else
        log_print "${RED}✗ Health Status: $HEALTH${NC}"
        ALERT=1
    fi
    
    # Parametri critici
    log_print "\nParametri SMART Critici:"
    
    # Reallocated Sectors
    REALOC=$(sudo smartctl -A "$DISK" 2>/dev/null | grep "Reallocated_Sector_Ct" | awk '{print $10}')
    if [ -n "$REALOC" ]; then
        if [ "$REALOC" -eq 0 ]; then
            log_print "${GREEN}  Reallocated_Sector_Ct: $REALOC (OK)${NC}"
        elif [ "$REALOC" -lt 10 ]; then
            log_print "${YELLOW}  Reallocated_Sector_Ct: $REALOC (Attenzione)${NC}"
        else
            log_print "${RED}  Reallocated_Sector_Ct: $REALOC (CRITICO)${NC}"
            ALERT=1
        fi
    fi
    
    # Current Pending Sectors
    PENDING=$(sudo smartctl -A "$DISK" 2>/dev/null | grep "Current_Pending_Sector" | awk '{print $10}')
    if [ -n "$PENDING" ]; then
        if [ "$PENDING" -eq 0 ]; then
            log_print "${GREEN}  Current_Pending_Sector: $PENDING (OK)${NC}"
        else
            log_print "${RED}  Current_Pending_Sector: $PENDING (PROBLEMA)${NC}"
            ALERT=1
        fi
    fi
    
    # UDMA CRC Errors
    UDMA=$(sudo smartctl -A "$DISK" 2>/dev/null | grep "UDMA_CRC_Error_Count" | awk '{print $10}')
    if [ -n "$UDMA" ]; then
        if [ "$UDMA" -eq 0 ]; then
            log_print "${GREEN}  UDMA_CRC_Error_Count: $UDMA (OK)${NC}"
        else
            log_print "${YELLOW}  UDMA_CRC_Error_Count: $UDMA (Controlla cavo SATA/USB)${NC}"
        fi
    fi
    
    # Temperature
    TEMP=$(sudo smartctl -A "$DISK" 2>/dev/null | grep "Temperature_Celsius" | awk '{print $10}')
    if [ -n "$TEMP" ]; then
        if [ "$TEMP" -lt 50 ]; then
            log_print "${GREEN}  Temperatura: ${TEMP}°C (OK)${NC}"
        elif [ "$TEMP" -lt 60 ]; then
            log_print "${YELLOW}  Temperatura: ${TEMP}°C (Alta)${NC}"
        else
            log_print "${RED}  Temperatura: ${TEMP}°C (CRITICA)${NC}"
            ALERT=1
        fi
    fi
    
    # Power On Hours
    POH=$(sudo smartctl -A "$DISK" 2>/dev/null | grep "Power_On_Hours" | awk '{print $10}')
    if [ -n "$POH" ]; then
        POH_DAYS=$((POH / 24))
        log_print "  Power On Hours: $POH ore ($POH_DAYS giorni)"
    fi
    
    # Conta errori nel log SMART
    ERROR_COUNT=$(sudo smartctl -l error "$DISK" 2>/dev/null | grep "ATA Error Count:" | awk '{print $4}')
    if [ -n "$ERROR_COUNT" ] && [ "$ERROR_COUNT" != "No" ]; then
        log_print "  Errori registrati: $ERROR_COUNT"
    fi
}

# Banner iniziale
log_print "\n=========================================="
log_print "  Monitoraggio Salute Dischi"
log_print "  Data: $(date '+%Y-%m-%d %H:%M:%S')"
log_print "  Host: $(hostname)"
log_print "=========================================="

# Flag per alert
ALERT=0

# Controlla entrambi i dischi
check_disk "/dev/sda" "Disco Sistema (Seagate 250GB)"
check_disk "/dev/sdb" "Disco Jellyfin (Hitachi 500GB USB)"

# Riepilogo finale
log_print "\n${YELLOW}=========================================="
if [ $ALERT -eq 0 ]; then
    log_print "${GREEN}✓ Tutti i dischi sono in buone condizioni${NC}"
else
    log_print "${RED}⚠ ATTENZIONE: Rilevati problemi sui dischi!${NC}"
    log_print "Considera backup immediato e sostituzione disco."
    
    # Invia email se configurata
    if [ -n "$ALERT_EMAIL" ]; then
        echo "ATTENZIONE: Problemi rilevati sui dischi di $(hostname)" | \
        mail -s "ALERT Salute Dischi - $(date +%Y-%m-%d)" "$ALERT_EMAIL"
    fi
fi
log_print "==========================================${NC}\n"

# Info sui log
log_print "Log salvato in: $LOG_FILE"
log_print "Log mensili in: $LOG_DIR"

# Mostra ultimi 3 check per confronto
log_print "\n${YELLOW}Ultimi controlli effettuati:${NC}"
grep "Data:" "$LOG_DIR"/*.log 2>/dev/null | tail -n 3

exit $ALERT
