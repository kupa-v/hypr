#!/bin/bash

# Get the default sink
sink=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')

# Get volume from the first percentage on the first channel line
volume=$(pactl list sinks | awk -v sink="$sink" '
  $0 ~ "Name: "sink {in_sink=1}
  in_sink && /Volume:/ {
    match($0, /[0-9]+%/, vol)
    print substr(vol[0], 1, length(vol[0])-1)
    exit
  }
')

# Get mute status
muted=$(pactl get-sink-mute "$sink" | awk '{print $2}')

# Fallback to 0 if empty
volume=${volume:-0}

# Clamp and build bar
volume=$((volume > 100 ? 100 : volume))
filled=$((volume / 10))
empty=$((10 - filled))
bar=$(printf '█%.0s' $(seq 1 $filled))
bar+=$(printf '░%.0s' $(seq 1 $empty))

# Display
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
