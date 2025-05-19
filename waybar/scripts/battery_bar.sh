#!/bin/bash

capacity=$(cat /sys/class/power_supply/BAT*/capacity)
status=$(cat /sys/class/power_supply/BAT*/status)

filled=$((capacity / 10))
empty=$((10 - filled))

bar=$(printf '█%.0s' $(seq 1 $filled))
bar+=$(printf '░%.0s' $(seq 1 $empty))

# Choose icon
if [ "$status" = "Charging" ]; then
  icon=""
elif [ "$capacity" -le 15 ]; then
  icon=""
elif [ "$capacity" -le 30 ]; then
  icon=""
elif [ "$capacity" -le 50 ]; then
  icon=""
elif [ "$capacity" -le 80 ]; then
  icon=""
else
  icon=""
fi

echo "$icon [ $bar ] $capacity%"
