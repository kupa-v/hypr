#!/bin/bash

# Get current input method
current=$(fcitx5-remote -n)

case "$current" in
    "keyboard-us")
        fcitx5-remote -s hangul
        echo '{"text": "[  한글 ]", "tooltip": "Input: Korean"}'
        ;;
    "hangul")
        fcitx5-remote -s mozc
        echo '{"text": "[  日本語 ]", "tooltip": "Input: Japanese"}'
        ;;
    "mozc")
        fcitx5-remote -s keyboard-us
        echo '{"text": "[  ENG ]", "tooltip": "Input: English"}'
        ;;
    *)
        fcitx5-remote -s keyboard-us
        echo '{"text": "[  ENG ]", "tooltip": "Input: English (fallback)"}'
        ;;
esac
