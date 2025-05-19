#!/bin/bash

STATE_FILE="/tmp/current_kb_layout"
DEFAULT_LAYOUT="us"
SECOND_LAYOUT="jp"

get_current_layout() {
    hyprctl devices | awk '/layout:/{print $2; exit}'
}

toggle_layout() {
    local current=$(get_current_layout)
    local next="$SECOND_LAYOUT"
    if [ "$current" = "$SECOND_LAYOUT" ]; then
        next="$DEFAULT_LAYOUT"
    fi
    hyprctl keyword input:kb_layout "$next"
    echo "$next" > "$STATE_FILE"
}

if [ "$1" = "toggle" ]; then
    toggle_layout
else
    get_current_layout
fi
