#!/bin/bash

active=$(hyprctl activeworkspace | awk '/ID:/ {print $2}')
output=""

for i in 3 4; do
  if [ "$i" -eq "$active" ]; then
    output+="<span class='icon' style='color:#66ccff;'></span> "
  else
    output+="<span class='icon'>󰏝</span> "
  fi
done

echo "$output"
