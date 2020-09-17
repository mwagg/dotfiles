#!/usr/bin/env bash

external_connected=$(xrandr | grep " connected" | cut -d ' ' -f 1 | grep -v eDP-1)

if [ "$external_connected" = "DP-1" ] || [ "$external_connected" = "DP-2" ]; then
    xrandr --output eDP-1 --off
else
    xrandr --auto
fi
