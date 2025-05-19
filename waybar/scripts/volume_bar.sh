#!/bin/bash

# Get volume and mute state from default sink via wpctl
info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
volume=$(echo "$info" | awk '{print $2}')
muted=$(echo "$info" | grep -q MUTED && echo "yes" || echo "no")

# Convert to 0–100 scale
volume_int=$(printf "%.0f" "$(echo "$volume * 100" | bc -l)")

filled=$((volume_int / 10))
empty=$((10 - filled))

bar=$(printf '█%.0s' $(seq 1 $filled))
bar+=$(printf '░%.0s' $(seq 1 $empty))

if [[ "$muted" == "yes" ]]; then
  icon=""
  printf "%s [ ---------- ] --%%\n" "$icon"
else
  if [ "$volume_int" -eq 0 ]; then
    icon=""
  elif [ "$volume_int" -le 50 ]; then
    icon=""
  else
    icon=""
  fi
  printf "%s [ %s ] %s%%%%\n" "$icon" "$bar" "$volume_int"
fi
