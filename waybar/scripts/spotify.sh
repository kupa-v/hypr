#!/bin/bash

# Check if Spotify is running
if ! pgrep -x spotify >/dev/null; then
  echo "{\"text\": \"[  ]\", \"class\": \"inactive\"}"
  exit 0
fi

# Get metadata
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

# Escape special characters for JSON + Pango safety
sanitize() {
  local input="$1"
  input="${input//\\/\\\\}"   # backslash
  input="${input//&/&amp;}"   # ampersand
  input="${input//</&lt;}"    # less than
  input="${input//>/&gt;}"    # greater than
  input="${input//\"/&quot;}" # double quote
  input="${input//\'/&apos;}" # single quote
  input="${input//$'\n'/ }"   # newline to space
  echo "$input"
}

artist=$(sanitize "$artist")
title=$(sanitize "$title")

# Display formatted output if available
if [ -n "$artist" ] && [ -n "$title" ]; then
  echo "{\"text\": \" [ $title || $artist ]\", \"class\": \"playing\"}"
else
  echo "{\"text\": \" [ no music ]\", \"class\": \"paused\"}"
fi
