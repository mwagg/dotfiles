#!/usr/bin/env bash

mypidfile="/run/user/$(id -u)/wallpaper-auto-change.pid"

if [ -f "$mypidfile" ]; then
    echo "Already running"
    exit 0
fi

trap "rm -f -- '$mypidfile'" EXIT

echo $$ > "$mypidfile"

while true; do
    $HOME/.local/bin/randomise-wallpaper
    sleep 3600
done
