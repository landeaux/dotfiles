#!/usr/bin/env bash
# toggle-touchpad script
#
# Toggles the touchpad on and off. Bind this script to a button to turn on and off
# your touchpad/trackpad. The hardware button above the HP G60's touchpad is a great choice.

# This is the version for Ubuntu MATE on the HP G60-230US
# #######################################################
# Larry Bushey
#
if [ $(xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Device Enabled" | awk -F ':\t' '{print $2}') -eq 0 ]; then
xinput enable "SynPS/2 Synaptics TouchPad"
notify-send --icon=/usr/share/icons/mate/scalable/actions/touchpad-enabled.svg "Enabled" "Your computer's touchpad is enabled."
else
xinput disable "SynPS/2 Synaptics TouchPad"
notify-send --icon=/usr/share/icons/mate/scalable/actions/touchpad-disabled.svg "Disabled" "Your computer's touchpad is disabled."
fi
