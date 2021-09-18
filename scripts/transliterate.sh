#!/bin/bash

# transliterate.sh
#
# This script uses mandarinspot.
# FOR EDUCATIONAL PURPOSES ONLY. NOT MY RESPONSIBILITY FOR ANYTHING
# BAD THAT YOU DO WITH THIS SCRIPT.
#
# Author: Raymo111
# 
# HISTORY
# v0.1 - Feb 20th, 2020 - Created!

# Generate random IP
IP1=$( shuf -n 1 <(seq 255 | grep -Fxv -e{1,10,192}) )
IP2=$(( RANDOM % 255 ))
IP3=$(( RANDOM % 255 ))
IP4=$(( RANDOM % 255 ))
IP="$IP1.$IP2.$IP3.$IP4"

curl -sH "X-Forwarded-For: $IP" --data "e=utf-8&text$1&phs=pinyin&show=reading&spaces=1&pr=0" "https://mandarinspot.com/annotate" -o test.html #| jq -r '.result'

echo ""
