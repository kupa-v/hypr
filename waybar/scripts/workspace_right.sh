#!/bin/bash

active=$(hyprctl activeworkspace | awk '/ID:/ {print $2}')
output=""

for i in 3 4; do
  if [ "$i" -eq "$active" ]; then
    output+="<span font_desc='JetBrainsMono Nerd Font 13' foreground='#66ccff'></span> "
  else
    output+="<span font_desc='JetBrainsMono Nerd Font 13'>󰏝</span> "
  fi
done

echo "$output"
