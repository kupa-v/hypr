#!/bin/bash

# Get the default sink
sink=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')

# Get volume percentage from that sink
volume=$(pactl get-sink-volume "$sink" | grep -oP '[0-9]+(?=%)' | head -1)

# Check mute status
muted=$(pactl get-sink-mute "$sink" | awk '{print $2}')

# Clamp and bar logic
filled=$((volume / 10))
empty=$((10 - filled))

bar=$(printf '█%.0s' $(seq 1 $filled))
bar+=$(printf '░%.0s' $(seq 1 $empty))

# Output with icons
if [[ "$muted" == "yes" ]]; then
  icon=""
  printf "%s [ ---------- ] --%%\n" "$icon"
else
  if [ "$volume" -eq 0 ]; then
    icon=""
  elif [ "$volume" -le 50 ]; then
    icon=""
  else
    icon=""
  fi
  printf "%s [ %s ] %s%%%%\n" "$icon" "$bar" "$volume"
fi
