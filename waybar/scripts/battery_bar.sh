#!/bin/bash

capacity=$(cat /sys/class/power_supply/BAT*/capacity)
status=$(cat /sys/class/power_supply/BAT*/status)

# Format percentage, allow >100
capacity_fmt=$(printf "%03d" "$capacity")

# Clamp bar at 10 blocks max
filled=$((capacity > 100 ? 10 : capacity / 10))
filled=$((filled > 10 ? 10 : filled))  # Safety clamp
empty=$((10 - filled))
empty=$((empty < 0 ? 0 : empty))       # Prevent negative empty blocks

bar=""
if (( filled > 0 )); then
  bar+=$(printf '█%.0s' $(seq 1 $filled))
fi
if (( empty > 0 )); then
  bar+=$(printf '░%.0s' $(seq 1 $empty))
fi

# Icon and class logic
if [ "$status" = "Charging" ]; then
  icon="󰂄"
  color_class="charging"
else
  if [ "$capacity" -le 15 ]; then
    icon="󰁺"
    color_class="verylow"
  elif [ "$capacity" -le 40 ]; then
    icon="󰁽"
    color_class="low"
  elif [ "$capacity" -le 60 ]; then
    icon="󰁿"
    color_class="medium"
  elif [ "$capacity" -le 80 ]; then
    icon="󰂁"
    color_class="good"
  else
    icon="󰁹"
    color_class="full"
  fi
fi

# Output
echo "{\"text\": \"$icon [ $bar ] ${capacity_fmt}%\", \"class\": \"$color_class\"}"
