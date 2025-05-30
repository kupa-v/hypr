#!/bin/bash

# Is Spotify running?
if pgrep -x spotify >/dev/null; then
  # If it's running, toggle playback
  playerctl play-pause
else
  # Otherwise, start Spotify
  spotify &
fi
