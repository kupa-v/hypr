#!/bin/bash

# Get the active default sink
sink=$(pactl info | grep "Default Sink" | cut -d ' ' -f3)

# Get volume and mute state
volume=$(pactl get-sink-volume "$sink" | grep -oP '[0-9]+(?=%)' | head -1)
muted=$(pactl get-sink-mute "$sink" | awk '{print $2}')

# Clamp and build bar
volume=$((volume > 100 ? 100 : volume))
filled=$((volume / 10))
empty=$((10 - filled))

bar=$(printf '█%.0s' $(seq 1 $filled))
bar+=$(printf '░%.0s' $(seq 1 $empty))

# Output with icon
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
  printf "%s [ %s ] %s%%\n" "$icon" "$bar" "$volume"
fi
