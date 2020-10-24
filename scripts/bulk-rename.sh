#!/bin/bash
a=1
NAME="The Action Bible (2010)"
for i in *.jpg; do
  new=$(printf "$NAME%03d.jpg" "$a") #03 pad to length of 3
  mv -i -- "$i" "$new"
  let a=a+1
done
