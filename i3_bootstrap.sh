#!/usr/bin/env bash

./bootstrap.sh

# i3 + related packages
sudo pacman -S --noconfirm --needed i3-gaps
sudo pacman -S --noconfirm --needed i3blocks
sudo pacman -S --noconfirm --needed ttf-font-awesome
sudo pacman -S --noconfirm --needed i3status
sudo pacman -S --noconfirm --needed nitrogen
sudo pacman -S --noconfirm --needed rofi
sudo pacman -S --noconfirm --needed compton
sudo pacman -S --noconfirm --needed dunst
sudo pacman -S --noconfirm --needed gnome-screenshot
yay -S --noconfirm --needed mons

# polybar
sudo pacman -S --noconfirm --needed python-dbus
sudo pacman -S --noconfirm --needed xorg-fonts-misc
yay -S --noconfirm --needed siji
yay -S --noconfirm --needed polybar

# nautilus
sudo pacman -S --noconfirm --needed nautilus
