#!/bin/bash

[ $# -ne 2 ] && { echo "Utilizare: $0 NUME_VARIABILA VALOARE_IMPLICITA"; exit 1;}

VAR_NAME="$1"
IMPLICIT="$2"

printenv | awk -F= '{ printf "%-30s → %s\n", $1, $2 }'

VAR_VAL="${!VAR_NAME}"

if [ -z "$VAR_VAL" ]; then
    echo "$VAR_NAME nu este setată. O setăm la valoarea implicită: $IMPLICIT"
    export "$VAR_NAME=$IMPLICIT"
else
    echo "$VAR_NAME este setată și are valoarea: $VAR_VAL"
    export "$VAR_NAME=$VAR_VAL"
fi

echo "Pornim un proces nou de bash și verificăm dacă variabila este setată:"
bash -c "echo \${$VAR_NAME}"
