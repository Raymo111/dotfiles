#!/bin/bash
INTERFACE=XHC0
if [[ $(grep enabled /proc/acpi/wakeup) =~ $INTERFACE ]]; then sudo sh -c "echo $INTERFACE > /proc/acpi/wakeup"; fi
