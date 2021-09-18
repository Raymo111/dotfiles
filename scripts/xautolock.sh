#!/bin/bash
LOCK="$scriptdir/i3lock.sh"
xidlehook --not-when-fullscreen --not-when-audio --timer 360 $LOCK '' --detect-sleep
