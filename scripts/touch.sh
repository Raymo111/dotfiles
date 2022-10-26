#!/bin/bash
read -rp "[CC]YY: " CCYY
read -rp "MM: " MM
read -rp "DD: " DD
read -rp "hh: " hh
read -rp "mm[.ss]: " mm
touch -t "$CCYY$MM$DD$hh$mm" "$1"
