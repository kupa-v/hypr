#!/bin/bash

current=$(fcitx5-remote -n)

case "$current" in
    "keyboard-us")
        fcitx5-remote -s hangul
        ;;
    "hangul")
        fcitx5-remote -s mozc
        ;;
    "mozc")
        fcitx5-remote -s keyboard-us
        ;;
    *)
        fcitx5-remote -s keyboard-us
        ;;
esac
