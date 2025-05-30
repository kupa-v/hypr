#!/bin/bash

current=$(fcitx5-remote -n)

case "$current" in
    "keyboard-us")
        echo '{"text": "[  ENG ]", "tooltip": "Input: English"}'
        ;;
    "hangul")
        echo '{"text": "[  한글 ]", "tooltip": "Input: Korean"}'
        ;;
    "mozc")
        echo '{"text": "[  日本語 ]", "tooltip": "Input: Japanese"}'
        ;;
    *)
        echo '{"text": "[  ??? ]", "tooltip": "Unknown input method"}'
        ;;
esac
