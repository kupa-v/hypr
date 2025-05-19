#!/bin/bash
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+%' | head -1 | tr -d '%')
filled=$((volume / 10))
empty=$((10 - filled))
bar=$(printf "█%.0s" $(seq 1 $filled))
bar+=$(printf "░%.0s" $(seq 1 $empty))
echo "[ $bar ] $volume%"
