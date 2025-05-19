#!/bin/bash
capacity=$(cat /sys/class/power_supply/BAT*/capacity)
filled=$((capacity / 10))
empty=$((10 - filled))
bar=$(printf "█%.0s" $(seq 1 $filled))
bar+=$(printf "░%.0s" $(seq 1 $empty))
echo "[ $bar ] $capacity%"
