#!/bin/bash

capacity=$(cat /sys/class/power_supply/BAT*/capacity)
status=$(cat /sys/class/power_supply/BAT*/status)

# Bar logic
filled=$((capacity / 10))
empty=$((10 - filled))

bar=""
if (( filled > 0 )); then
  bar+=$(printf '█%.0s' $(seq 1 $filled))
fi
if (( empty > 0 )); then
  bar+=$(printf '░%.0s' $(seq 1 $empty))
fi

capacity_fmt=$(printf "%02d" "$capacity")

# Icon selection
if [ "$status" = "Charging" ]; then
  icon="󰂄"
  color_class="charging"
else
  if [ "$capacity" -le 15 ]; then
    color_class="verylow"
	icon="󰁺"
  elif [ "$capacity" -le 40 ]; then
    color_class="low"
	icon="󰁽"
  elif [ "$capacity" -le 60 ]; then
    color_class="medium"
	icon="󰁿"
  elif [ "$capacity" -le 80 ]; then
    color_class="good"
	icon="󰂁"
  else
    color_class="full"
	icon="󰁹"
  fi
fi

# Output as JSON
echo "{\"text\": \"$icon [ $bar ] $capacity_fmt%\", \"class\": \"$color_class\"}"
