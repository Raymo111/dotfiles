#!/bin/bash
for d in */ ; do
	echo "${d%/}.zip"
	zip -r "${d%/}.zip" "$d"
done
