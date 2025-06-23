#!/bin/bash

id -u bob &>/dev/null && echo "Utilizatorul 'bob' există deja." || { sudo useradd -m bob; echo "Utilizatorul 'bob' a fost creat."; }
id -u alice &>/dev/null && { echo "Se opresc procesele utilizatorului alice..."; sudo pkill -u alice; echo "Se șterge utilizatorul alice..."; sudo userdel -r alice; echo "Utilizatorul 'alice' a fost șters."; } || echo "Utilizatorul 'alice' nu există, nu se șterge."
echo "Pornește proces sleep ca bob..." && sudo -u bob bash -c "sleep 9999 &"
sleep 2

OUTPUT1=$(./verificare-user-proces.sh bob sleep)

[[ "$OUTPUT1" != "Utilizatorul rulează procesul." ]] && { echo "Eroare: Așteptam 'Utilizatorul rulează procesul.' pentru bob + sleep"; echo "Output real: $OUTPUT1"; exit 1; }

OUTPUT2=$(./verificare-user-proces.sh bob python)

[[ "$OUTPUT2" != "Utilizatorul nu rulează procesul." ]] && { echo  "Eroare: Așteptam 'Utilizatorul nu rulează procesul.' pentru bob + python"; echo "Output real: $OUTPUT2"; exit 1; }

OUTPUT3=$(./verificare-user-proces.sh alice python)

[[ "$OUTPUT3" != "Utilizatorul nu există." ]] &&  {  echo "Eroare: Așteptam 'Utilizatorul nu există.' pentru alice" ; echo "Output real: $OUTPUT3";  exit 1; }

echo "Toate testele au trecut cu succes!"

exit 0
