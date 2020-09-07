#!/usr/bin/env fish

set monitors (xrandr | grep " connected" | cut -d ' ' -f 1)

if contains DP-2 $monitors
    xrandr --output eDP-1 --off --output DP-2 --auto
else
    xrandr --auto
end

nitrogen --restore
