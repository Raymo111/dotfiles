#!/bin/bash
FLAG=0
while read -r line; do
	WINDOW_ID="$(echo  "$line" | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')"
	NAME=$(xprop -id "$WINDOW_ID" | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
	if [[ $NAME == *"Konsole" && $FLAG == 0 ]]; then
		FLAG=1
		openrgb -p Terminal &
	elif [[ $NAME != *"Konsole" && $FLAG == 1 ]]; then
		FLAG=0
		openrgb -p Arch &
	fi
done < <(xprop -spy -root _NET_ACTIVE_WINDOW)
