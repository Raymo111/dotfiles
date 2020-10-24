#!/bin/bash
read -p "[CC]YY: " CCYY
read -p "MM: " MM
read -p "DD: " DD
read -p "hh: " hh
read -p "mm[.ss]: " mm
touch -t $CCYY$MM$DD$hh$mm $1
