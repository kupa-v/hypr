#!/bin/bash

# Check if Spotify is running
if ! pgrep -x spotify >/dev/null; then
  exit 0
fi

# Get metadata
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

# Display formatted output if available
if [ -n "$artist" ] && [ -n "$title" ]; then
  echo "{\"text\": \"  [ $title || $artist ]\", \"class\": \"playing\"}"
else
  echo "{\"text\": \"[ no music ]\", \"class\": \"paused\"}"
fi
