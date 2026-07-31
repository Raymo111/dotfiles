#!/bin/bash

# Local-only secrets/paths (KEEPASS_DB, etc.); not tracked in the public repo.
# Sourced explicitly because autostart runs outside an interactive shell.
[ -f "$HOME/.aliases/private" ] && . "$HOME/.aliases/private"

# System
#xdotool key Num_Lock
#ksuperkey
mailspring -b &
kwallet-query -r keepassxc kdewallet | keepassxc --pw-stdin "$KEEPASS_DB"
sleep 5
systemctl --user restart alc294-sink.service
sudo sh -c 'echo 1 > /sys/devices/platform/asus-nb-wmi/leds/platform::micmute/brightness'
qdbus org.kde.kglobalaccel /component/kmix invokeShortcut mic_mute && sudo sh -c 'echo 0 > /sys/devices/platform/asus-nb-wmi/leds/platform::micmute/brightness'
