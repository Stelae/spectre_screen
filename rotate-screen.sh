#!/bin/bash
# This script rotates the screen and touchscreen input 180 degrees, disables the touchpad, and enables the virtual keyboard
# And rotates screen back if the touchpad was disabled

touchpadEnabled=$(xinput --list-props 'SynPS/2 Synaptics TouchPad' | awk '/Device Enabled/{print $NF}')
screenMatrix=$(xinput --list-props 'ELAN Touchscreen' | awk '/Coordinate Transformation Matrix/{print $5$6$7$8$9$10$11$12$NF}')

# Matrix for rotation
# ⎡ 1 0 0 ⎤
# ⎜ 0 1 0 ⎥
# ⎣ 0 0 1 ⎦
normal='1 0 0 0 1 0 0 0 1'
normal_float='1.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,0.000000,1.000000'

#⎡ -1  0 1 ⎤
#⎜  0 -1 1 ⎥
#⎣  0  0 1 ⎦
inverted='-1 0 1 0 -1 1 0 0 1'
inverted_float='-1.000000,0.000000,1.000000,0.000000,-1.000000,1.000000,0.000000,0.000000,1.000000'

# 90° to the left 
# ⎡ 0 -1 1 ⎤
# ⎜ 1  0 0 ⎥
# ⎣ 0  0 1 ⎦
left='0 -1 1 1 0 0 0 0 1'
left_float='0.000000,-1.000000,1.000000,1.000000,0.000000,0.000000,0.000000,0.000000,1.000000'

# 90° to the right
#⎡  0 1 0 ⎤
#⎜ -1 0 1 ⎥
#⎣  0 0 1 ⎦
right='0 1 0 -1 0 1 0 0 1'


if [ $screenMatrix == $normal_float ]
then
  echo "Upside down"
  xrandr -o inverted
  xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' $inverted
  xinput disable 'SynPS/2 Synaptics TouchPad'
  # Remove hashtag below if you want pop-up the virtual keyboard  
  #onboard &
elif [ $screenMatrix == $inverted_float ]
then
  echo "90° to the left"
  xrandr -o left
  xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' $left
  xinput disable 'SynPS/2 Synaptics TouchPad'
  #killall onboard
elif [ $screenMatrix == $left_float ]
then
  echo "90° to the right"
  xrandr -o right
  xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' $right
  xinput disable 'SynPS/2 Synaptics TouchPad'
  #killall onboard
else
  echo "Back to normal"
  xrandr -o normal
  xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' $normal
  xinput enable 'SynPS/2 Synaptics TouchPad'
  #killall onboard
fi
