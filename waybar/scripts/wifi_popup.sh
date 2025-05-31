#!/bin/bash

# List unique SSIDs, sorted by signal strength (optional)
ssid=$(nmcli -t -f SSID,SIGNAL dev wifi list | grep -v '^$' | sort -t: -k2 -nr | cut -d: -f1 | uniq | wofi --dmenu -p "Wi-Fi")

# If a network was selected
if [ -n "$ssid" ]; then
  # Connect (will auto-prompt for password via NetworkManager if needed)
  nmcli dev wifi connect "$ssid"
fi
