#!/usr/bin/env fish

set monitors (xrandr | grep " connected" | cut -d ' ' -f 1)

if contains DP1 $monitors
    mons -s --dpi 96
    echo "Xft.dpi: 96" > ~/.Xresources
else
    mons -o --dpi 196
    echo "Xft.dpi: 196" > ~/.Xresources
end

xrdb $HOME/.Xresources
i3-msg restart
$HOME/.local/bin/randomise-wallpaper
killall dunst
