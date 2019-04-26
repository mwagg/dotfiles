#!/usr/bin/env bash

set -e

function pacman_install {
  pacman -Q $1 || sudo pacman -S --needed --noconfirm $1
}

function yay_install {
  pacman -Q $1 || yay -S --needed --noconfirm $1
}

numberofcores=$(grep -c ^processor /proc/cpuinfo)

case $numberofcores in
  16)
    echo "You have " $numberofcores" cores."
    echo "Changing the makeflags for "$numberofcores" cores."
    sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j17"/g' /etc/makepkg.conf
    echo "Changing the compression settings for "$numberofcores" cores."
    sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 16 -z -)/g' /etc/makepkg.conf
    ;;
  8)
    echo "You have " $numberofcores" cores."
    echo "Changing the makeflags for "$numberofcores" cores."
    sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j9"/g' /etc/makepkg.conf
    echo "Changing the compression settings for "$numberofcores" cores."
    sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 8 -z -)/g' /etc/makepkg.conf
    ;;
  6)
    echo "You have " $numberofcores" cores."
    echo "Changing the makeflags for "$numberofcores" cores."
    sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j7"/g' /etc/makepkg.conf
    echo "Changing the compression settings for "$numberofcores" cores."
    sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 6 -z -)/g' /etc/makepkg.conf
    ;;
  4)
    echo "You have " $numberofcores" cores."
    echo "Changing the makeflags for "$numberofcores" cores."
    sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j5"/g' /etc/makepkg.conf
    echo "Changing the compression settings for "$numberofcores" cores."
    sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 4 -z -)/g' /etc/makepkg.conf
    ;;
  2)
    echo "You have " $numberofcores" cores."
    echo "Changing the makeflags for "$numberofcores" cores."
    sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j3"/g' /etc/makepkg.conf
    echo "Changing the compression settings for "$numberofcores" cores."
    sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 2 -z -)/g' /etc/makepkg.conf
    ;;
  *)
    echo "We do not know how many cores you have."
    echo "Do it manually."
    ;;
esac

sudo pacman -Syyu --noconfirm --needed

pacman_install base-devel
pacman_install stow
./link_dotfiles.sh

function install_yay {
  mkdir -p $HOME/.local/src
  pushd $HOME/.local/src
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  popd
}

type yay || install_yay

pacman_install intel-ucode
pacman_install openssh

# network
sudo sed -i -e 's/#MulticastDNS=yes/MulticastDNS=no/' /etc/systemd/resolved.conf
sudo systemctl enable systemd-resolved.service

# power management
pacman_install acpi
pacman_install powertop
sudo cp templates/powertop.service /usr/lib/systemd/system/powertop.service
sudo systemctl enable powertop.service
sudo systemctl start powertop.service

# suspend on lid close
sudo sed -i -e 's/HandleLidSwitch=ignore/handleLidSwitch=suspend/' /etc/systemd/logind.conf

# firewall
pacman_install ufw
sudo systemctl enable ufw.service
sudo systemctl start ufw.service
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw enable || true

# gdm
pacman_install gdm
set +e
sudo systemctl disable lightdm.service
set -e
sudo systemctl enable gdm.service
sudo systemctl set-default graphical.target

# gnome
pacman_install gnome-extra
pacman_install gnome-control-center
pacman_install gnome-backgrounds
pacman_install gnome-tweaks

# fonts
yay_install ttf-mononoki
pacman_install noto-fonts-emoji

# sound
pacman_install pulseaudio
pacman_install pavucontrol
pacman_install pulseaudio-alsa
pacman_install alsa-utils
pacman_install alsa-plugins
pacman_install alsa-lib
pacman_install alsa-firmware
pacman_install gstreamer
pacman_install gst-plugins-good
pacman_install gst-plugins-bad
pacman_install gst-plugins-base
pacman_install gst-plugins-ugly
pulseaudio --start
echo ".include /etc/pulse/default.pa" > $HOME/.config/pulse/default.pa
echo ".ifexists module-switch-on-connect.so" >> $HOME/.config/pulse/default.pa
echo "load-module module-switch-on-connect" >> $HOME/.config/pulse/default.pa
echo ".endif" >> $HOME/.config/pulse/default.pa

# bluetooth
pacman_install pulseaudio-bluetooth
pacman_install bluez
pacman_install bluez-libs
pacman_install bluez-utils
pacman_install blueberry

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf

# nodejs
export PATH=~/.local/node/bin:$PATH
if ! command -v node &> /dev/null; then
  NODE_VERSION=10.13.0
  NODE_SRC_PATH=~/.local/src/node-v$NODE_VERSION.tar.xz

  mkdir -p ~/.local/src

  curl -o "$NODE_SRC_PATH" https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz
  mkdir -p ~/.local/node
  tar xf "$NODE_SRC_PATH" -C ~/.local/node/ --strip-components=1
fi
function npm_g {
  package=$1
  npm_bin=$HOME/.local/node/bin/npm

  $npm_bin list -g $package &> /dev/null || $npm_bin install -g $package
}
npm_g yarn
npm_g tern
npm_g js-beautify
npm_g eslint

# clojure
pacman_install jdk8-openjdk
pacman_install clojure

# elm
npm_g elm
npm_g elm-test
npm_g elm-oracle
npm_g elm-format

# heroku
npm_g heroku

# gtop
pacman_install gtop

# base devel
pacman_install base-devel

# USB drives
pacman_install exfat-utils

# fzf
pacman_install fzf

# autojump
pacman_install autojump

# fish shell
pacman_install fish
sudo chsh -s /usr/bin/fish $USER

# termite
pacman_install termite

# emacs
pacman_install adobe-source-code-pro-fonts
pacman_install aspell-en
pacman_install ripgrep
pacman_install emacs
sudo sed -i -e 's/^Exec=.*/Exec=\/usr\/bin\/fish -c emacs %f/' /usr/share/applications/emacs.desktop

# github hub
pacman_install hub

# firefox
pacman_install firefox
sudo sed /usr/share/applications/firefox.desktop -i -e 's/^Exec=\/usr\/lib\/firefox\/firefox %u$/Exec=env MOZ_USE_XINPUT2=1 GDK_BACKEND=wayland \/usr\/lib\/firefox\/firefox %u/'
xdg-settings set default-web-browser firefox.desktop

# chromium
pacman_install chromium
yay_install chromium-widevine

# docker
pacman_install docker
sudo usermod -a -G docker $USER

# aws
pacman_install aws-cli

# mpv
pacman_install mpv
pacman_install youtube-dl

# terraform
pacman_install terraform

# flatpak
pacman_install flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.spotify.Client -y
flatpak install flathub com.slack.Slack -y
flatpak install flathub com.uploadedlobster.peek -y
flatpak install flathub us.zoom.Zoom -y
flatpak install flathub com.valvesoftware.Steam -y

# syncthing
pacman_install syncthing
sudo ufw allow syncthing
sudo systemctl enable syncthing@$USER.service
sudo systemctl start syncthing@$USER.service

# imagemagick
pacman_install imagemagick

# udevil - automounting disks
pacman_install udisks2

# eog - image viewer
pacman_install eog

# jq
pacman_install jq

# transmission
pacman_install transmission-gtk

# use dhclient over dhcpcd
pacman_install dhclient
sudo systemctl disable dhcpcd.service
sudo systemctl enable dhclient@mike.service
sudo systemctl start dhclient@mike.service

# tldr
pacman_install tldr

# vyprvpn
yay_install vyprvpn-linux-cli
sudo systemctl enable vyprvpn.service
sudo systemctl start vyprvpn.service

# printing
pacman_install cups
pacman_install avahi
pacman_install nss-mdns
sudo systemctl enable avahi-daemon.service
sudo systemctl enable org.cups.cupsd.service

# sway
pacman_install rofi
yay_install wlroots
yay_install sway
yay_install swayidle
pacman_install swaylock
pacman_install light
pacman_install waybar
pacman_install otf-font-awesome
pacman_install ttf-font-awesome
pacman_install nautilus
pacman_install mako

# vim
pacman_install vim

# gtk
yay_install newaita-icons-git
gsettings set org.gnome.desktop.interface icon-theme Newaita
yay_install qogir-gtk-theme-git
gsettings set org.gnome.desktop.interface gtk-theme Qogir-light
yay_install capitaine-cursors 3-2
gsettings set org.gnome.desktop.interface cursor-theme capitaine-cursors

# qemu
pacman_install qemu
pacman_install ovmf
pacman_install virt-manager
