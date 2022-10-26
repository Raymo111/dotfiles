#!/bin/bash
grep "$1" "$2"
# shellcheck source=confirm.sh disable=SC2154
"$scriptdir"/confirm.sh "Delete lines?" && sed -i "/$1/d" "$2"
