#!/bin/bash
capacity=$(cat /sys/class/power_supply/BAT*/capacity)
bars=$(printf "█%.0s" $(seq 1 $((capacity / 10))))
spaces=$(printf "░%.0s" $(seq 1 $((10 - capacity / 10))))
echo "[ $bars$spaces ] $capacity%"
