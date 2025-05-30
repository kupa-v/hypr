#!/bin/bash

artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

if [ -n "$artist" ] && [ -n "$title" ]; then
  echo "{\"text\": \"[  $artist || $title\ ]", \"class\": \"playing\"}"
else
  echo "{\"text\": \"[ no music ]\", \"class\": \"paused\"}"
fi
