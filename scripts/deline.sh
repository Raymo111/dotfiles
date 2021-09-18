#!/bin/bash
cat $2 | grep $1
$scriptdir/confirm.sh "Delete lines?" && sed -i "/$1/d" ./$2
