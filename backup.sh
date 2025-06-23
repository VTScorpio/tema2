#!/bin/bash

[ $# -ne 1 ] &&  { echo "Utilizare: $0 /cale/catre/fisier"; exit 1; }
FILE="$1"
[ ! -f "$FILE" ] && { echo "[$(date +"%Y-%m-%d %H:%M:%S")] Eroare: Fișierul '$FILE' nu există." >> ./backup.log; exit 2; } 

NAME_FILE=$(basename "$FILE")
DIR=$(dirname "$FILE")
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP="${DIR}/${NAME_FILE}_${TIMESTAMP}.bak"
LOGFILE="${DIR}/backup.log"

cp "$FILE" "$BACKUP"
echo "[$(date +"%Y-%m-%d_%H-%M-%S")] Backup creat: $BACKUP" >> "$LOGFILE"

SIZE=$(stat -c%s "$FILE")

if [ "$SIZE" -gt $((1024 * 1024)) ]; then
    gzip "$BACKUP"
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Backup arhivat: ${BACKUP}.gz" >> "$LOGFILE"
fi
