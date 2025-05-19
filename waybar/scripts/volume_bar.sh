#!/bin/bash

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+%' | head -1 | tr -d '%')
muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP 'yes|no')

# Ensure volume is between 0–100
volume=$((volume > 100 ? 100 : volume))
filled=$((volume / 10))
empty=$((10 - filled))

bar=$(printf '█%.0s' $(seq 1 $filled))
bar+=$(printf '░%.0s' $(seq 1 $empty))

if [[ "$muted" == "yes" ]]; then
  icon=""
  echo "$icon [ ---------- ] --%"
else
  if [ "$volume" -eq 0 ]; then
    icon=""
  elif [ "$volume" -le 50 ]; then
    icon=""
  else
    icon=""
  fi
  echo "$icon [ $bar ] $volume%"
fi
