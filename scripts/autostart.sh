#!/bin/bash
# Scripts

# Keyboard
#pkill polychromatic-tray-applet
#cd keyboard
#./arch.py
#./konsole.sh &

# System
#exec --no-startup-id xss-lock --transfer-sleep-lock -- ./i3lock.sh
#kquitapp5 plasmashell && kstart5 plasmashell
#echo -e "document.getElementsByClassName('listItem-2P_4kh')[document.getElementsByClassName('listItem-2P_4kh').length-1].style.display='none',setInterval(\"Array.prototype.forEach.call(document.body.getElementsByTagName('*'),e=>{'rgb(47, 49, 54)'==window.getComputedStyle(e,null).getPropertyValue('color')&&(e.style.color='#000')})\",1e3)" | xclip -sel c
#picom --vsync --backend glx
xdotool key Num_Lock
ksuperkey
