#!/bin/bash

# Gives a dmenu prompt to search DuckDuckGo.
# Without input, will open DuckDuckGo.com.
# URLs will be directly handed to the browser.
# Anything else, it search it.
browser=${BROWSER:-firefox}

pgrep -x dmenu && exit

choice=$(rofi -lines 1 -color-normal "argb:00131920, #ffffff, argb:e54b5160, argb:00131920, #f9f9f9" -dmenu -i -p "Search DuckDuckGo:") || exit 1

if [ -z "$choice" ]; then
  $browser "https://duckduckgo.com"
else
  # Detect if url
  if [[ "$choice" =~ ^(http:\/\/|https:\/\/)?[a-zA-Z0-9]+\.[a-zA-Z]+(/)?.*$ ]]; then
    $browser "$choice"
  else
    $browser "https://duckduckgo.com/?q=$choice&t=ffab&atb=v1-1"
  fi
fi

i3-msg workspace 3
