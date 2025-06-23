#!/bin/bash

[ $# -ne 3 ] && {  echo "Utilizare: $0 nume_fisier valoare_veche valoare_noua" ; exit 1; }
FILE="$1"
VAL_OLD="$2"
VAL_NEW="$3"
[ ! -f "$FILE" ] && { echo "Eroare: Fisierul '$FILE' nu exista." ; exit 2; }

sed -i "s/${VAL_OLD}/${VAL_NEW}/g"  "$FILE" 

echo "Am inlocuit toate valorile '${VAL_OLD}' din fisierul '${FILE}' cu '${VAL_NEW}'."
