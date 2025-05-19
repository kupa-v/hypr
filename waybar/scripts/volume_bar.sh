#!/bin/bash

# Get the default sink
sink=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')

# Get volume from that sink
volume=$(pactl list sinks | awk -v sink="$sink" '
  $0 ~ "Name: "sink {in_sink=1}
  in_sink && /Volume:/ {
    match($0, /[0-9]+%/, vol)
    print substr(vol[0], 1, length(vol[0])-1)
    exit
  }
')

# Get mute state
muted=$(pactl get-sink-mute "$sink" | awk '{print $2}')

# Ensure we have a valid integer volume
volume=${volume:-0}
volume=$((volume < 0 ? 0 : volume > 100 ? 100 : volume))

# Pad to two digits
volume_fmt=$(printf "%02d" "$volume")

# Clamp and calculate bar
filled=$((volume / 10))
((filled > 10)) && filled=10
empty=$((10 - filled))
((empty < 0)) && empty=0

bar=""
if (( filled > 0 )); then
  bar+=$(printf '█%.0s' $(seq 1 $filled))
fi
if (( empty > 0 )); then
  bar+=$(printf '░%.0s' $(seq 1 $empty))
fi

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
  printf "%s [ %s ] %s%%\n" "$icon" "$bar" "$volume_fmt"
fi
