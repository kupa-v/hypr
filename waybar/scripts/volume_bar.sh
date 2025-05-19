#!/bin/bash
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+%' | head -1 | tr -d '%')
bars=$(printf "█%.0s" $(seq 1 $((volume / 10))))
spaces=$(printf "░%.0s" $(seq 1 $((10 - volume / 10))))
echo "[ $bars$spaces ] $volume%"
