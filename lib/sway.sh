#!/usr/bin/env bash

set -e

if [[ "true" != "$CORE_SOURCED" ]]; then
  source "$(dirname $BASH_SOURCE)/core.sh"
fi

pacman_install sway
pacman_install waybar
pacman_install rofi
pacman_install light
sudo usermod -a -G video mike
yay_install dot-desktop
yay_install wldash
