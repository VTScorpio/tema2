#!/bin/bash

USER="$1"
PROC="$2"

id -u "$USER" &>/dev/null || { echo "Utilizatorul nu există."; exit 0; }

pgrep -u "$USER" "$PROC" &>/dev/null && echo "Utilizatorul rulează procesul." || {  echo "Utilizatorul nu rulează procesul."; }
