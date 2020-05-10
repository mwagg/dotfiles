#!/bin/bash
# baraction.sh for spectrwm status bar

## WIFI
wifi() {
    wifi=$(nmcli -t -f NAME connection show --active | grep -v docker | grep -v br-)
    echo -e "WIFI: $wifi"
}

## RAM
mem() {
    mem=`free | awk '/Mem/ {printf "%dM/%dM\n", $3 / 1024.0, $2 / 1024.0 }'`
    echo -e "MEM: $mem"
}

## CPU
cpu() {
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
    echo -e "CPU: $cpu%"
}

## VOLUME
vol() {
    vol=`amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }' | sed 's/on://g'`
    echo -e "VOL: $vol"
}

## BATTERY
bat() {
    bat0=$(cat /sys/class/power_supply/BAT0/capacity)
    bat1=$(cat /sys/class/power_supply/BAT1/capacity)
    echo -e "BAT0: $bat0% BAT1: $bat1%"
}

SLEEP_SEC=3

#loops forever outputting a line every SLEEP_SEC secs
# It seems that we are limited to how many characters can be displayed via
# the baraction script output. And the the markup tags count in that limit.
# So I would love to add more functions to this script but it makes the
# echo output too long to display correctly.

while :; do
    echo "+@fg=1;+@fn=0;$(cpu)+@fg=0; |+@fg=2; $(mem)+@fg=0; |+@fg=3; $(wifi) +@fg=0; | +@fg=4; $(vol) +@fg=0; | +@fg=5; $(bat) +@fg=0; |"
    sleep $SLEEP_SEC
done
