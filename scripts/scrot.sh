#!/bin/bash
for f in /tmp/screenshots/*; do
	if [ $(stat --format=%Y $f) -le $(( $(date +%s) - 3600 )) ]; then
		mv $f $HOME/.local/share/Trash/files
	fi
done
