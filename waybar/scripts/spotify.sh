#!/bin/bash

# Check if Spotify is running
if ! pgrep -x spotify >/dev/null; then
  echo "{\"text\": \"[ spotify ]\", \"class\": \"inactive\"}"
  exit 0
fi

# Get player status
status=$(playerctl status 2>/dev/null)

# When paused, display special text
if [[ "$status" == "Paused" ]]; then
  echo "{\"text\": \" [ paused ]\", \"class\": \"paused\"}"
  exit 0
fi

# When playing, get and sanitize metadata
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

sanitize() {
  local input="$1"
  input="${input//\\/\\\\}"
  input="${input//&/&amp;}"
  input="${input//</&lt;}"
  input="${input//>/&gt;}"
  input="${input//\"/&quot;}"
  input="${input//\'/&apos;}"
  input="${input//$'\n'/ }"
  echo "$input"
}

artist=$(sanitize "$artist")
title=$(sanitize "$title")

# Fallback if metadata is missing
if [ -z "$artist" ] || [ -z "$title" ]; then
  echo "{\"text\": \" [ no music ]\", \"class\": \"playing\"}"
else
  echo "{\"text\": \" [ $title || $artist ]\", \"class\": \"playing\"}"
fi
