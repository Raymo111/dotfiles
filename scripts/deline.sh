#!/bin/bash
cat $2 | grep $1
/home/raymo/scripts/confirm.sh "Delete lines?" && sed -i "/$1/d" ./$2
