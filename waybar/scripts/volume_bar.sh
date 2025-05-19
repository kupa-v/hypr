#!/bin/bash

# Get the default sink
sink=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')

# Get the highest volume percentage from all channels of the sink
volume=$(pactl list sinks | awk -v sink="$sink" '
  $0 ~ "Name: "sink {in_sink=1}
  in_sink && /Volume:/ {
    max=0
    for (i=1; i<=NF; i++) {
      if ($i ~ /%$/) {
        val = substr($i, 1, length($i)-1)
        if (val+0 > max) max=val
      }
    }
    print max
    exit
  }
')

# Get mute state
muted=$(pactl get-sink-mute "$sink" | awk '{print $2}')

# Format volume (allow >100%)
volume_fmt=$(printf "%03d" "$volume")

# Clamp bar at 100%
filled=$((volume > 100 ? 10 : volume / 10))
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
