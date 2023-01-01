#!/bin/bash

# Keyboard
openrgb -p Arch
./keyboard/konsole.sh &

# System
xdotool key Num_Lock
ksuperkey
