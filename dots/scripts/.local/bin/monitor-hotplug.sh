#!/usr/bin/env bash

external_connected=$(swaymsg -t get_outputs | jq .[].name | grep -w "DP-1" | head)

if [[ "$external_connected" = '"DP-1"' ]]; then
  swaymsg output eDP-1 disable
  swaymsg output DP1 enable
else
  swaymsg output eDP-1 enable
fi
