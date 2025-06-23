#!/bin/bash

dir_path() {
	while true; do
		read -p "Introduceti cale director: " DIR
		[ -z "$DIR" ] && echo "Nu ati introdus nimic." && continue
		[ -d "$DIR" ] && break
		echo " Directorul nu exista."
 	done		
}

if [ -z "$1" ]; then
	dir_path
else
	DIR="$1"
	[ ! -d "$DIR" ] && echo "Directorul '$DIR' nu exista." && dir_path
fi

abs_path=$(realpath "$DIR")

[[ "$abs_path" == /etc* ]] && { echo "Eroare: Access interzis in directorul  '$abs_path'."; exit 1; }

[ ! -r "$abs_path" ] && { echo "Eroare: Fara drept de citire pentru '$abs_path'."; exit 2; }

count=$(find "$abs_path" -maxdepth 1 -type f | wc -l)

echo "Sunt $count fișier$( [ "$count" -eq 1 ] && printf "" || printf "e" ) în directorul $abs_path"

exit 0
