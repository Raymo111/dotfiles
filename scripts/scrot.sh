#!/bin/bash
if [ -d /tmp/screenshots/ ]; then
	if [ "$(ls -A /tmp/screenshots/)" ]; then
		for f in /tmp/screenshots/*; do
			if [[ "$(stat --format=%Y "$f")" -le $(( $(date +%s) - 3600 )) ]]; then
				#kioclient5 move "$f" trash:/
				mv "$f" .local/share/Trash/files/
			fi
		done
	fi
fi
