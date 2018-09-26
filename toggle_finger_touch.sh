#!/bin/bash

#Toggles finger-touch functionality of ELAN Touchscreen (does not interfere with Touchscreen Pen).

device="ELAN Touchscreen"

state=`xinput list-props "$device" | grep "Device Enabled" | grep -o "[01]$"`
    
if [ $state == '1' ]; then
  xinput --disable "$device"
else
  xinput --enable "$device"
fi
