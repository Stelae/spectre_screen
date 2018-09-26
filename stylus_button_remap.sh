#!/usr/bin/env bash
#Remaps Touchscreen Pen buttons so that so that the back button on the DELL 750-AAHC stylus is equivalent to a right-click.

export DISPLAY=":0"
export XAUTHORITY="/home/stelios/.Xauthority"
xinput set-button-map "ELAN Touchscreen Pen" 1 3 2 4 5

#echo "Script stylus_button_remap.sh done"
#date >> /home/stelios/.scripts/stylus_button_remap.log