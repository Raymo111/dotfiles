#!/bin/bash
for f in /tmp/screenshots/*; do
	if [ $(stat --format=%Y $f) -le $(( $(date +%s) - 3600 )) ]; then
		mv $f $homedir/.local/share/Trash/files
	fi
done
