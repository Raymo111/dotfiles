#!/bin/bash
FLAG=0
while read -r line
do
	WINDOW_ID="$(echo  "$line" | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')"
	NAME=$(xprop -id "$WINDOW_ID" | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
	if [[ $NAME == *"Konsole" ]]
	then
		FLAG=1
		# shellcheck disable=SC2154
		"$scriptdir"/keyboard/konsole.py
	elif [[ $FLAG == 1 ]]
	then
		FLAG=0
		"$scriptdir"/keyboard/arch.py
	fi
done < <(xprop -spy -root _NET_ACTIVE_WINDOW)
