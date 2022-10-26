#!/bin/bash
# shellcheck disable=SC2154
LOCK="$scriptdir/i3lock.sh"
xidlehook --not-when-fullscreen --not-when-audio --timer 360 "$LOCK" '' --detect-sleep
