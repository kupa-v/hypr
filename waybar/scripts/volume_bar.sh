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

# Handle missing volume case
volume=${volume:-0}

# Format to two digits
volume_fmt=$(printf "%02d" "$volume")

# Build bar
filled=$((volume / 10))
empty=$((10 - filled))

bar=""
if (( filled > 0 )); then
  bar+=$(printf '█%.0s' $(seq 1 $filled))
fi
if (( empty > 0 )); then
  bar+=$(printf '░%.0s' $(seq 1 $empty))
fi

# Output
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
