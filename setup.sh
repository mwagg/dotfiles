#!/usr/bin/env bash

set -e

function pacman_install {
  pacman -Q $1 || sudo pacman -S --needed --noconfirm $1
}

function yay_install {
  pacman -Q $1 || yay -S --needed --noconfirm $1
}

pacman_install stow
./link_dotfiles.sh

function install_yay {
  mkdir -p $HOME/.local/src
  [ -d $HOME/.local/src/yay ] || git clone https://aur.archlinux.org/yay.git $HOME/.local/src/yay
  pushd $HOME/.local/src/yay
  makepkg -si --noconfirm
  popd
  rm -rf $HOME/.local/src/yay
}

type yay || install_yay

yay -Syu --noconfirm

# ssh-agent
systemctl enable ssh-agent --user
systemctl start ssh-agent --user

# firewall
pacman_install ufw
sudo systemctl enable ufw.service
sudo systemctl start ufw.service
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw enable || true

# terminal
pacman_install alacritty
pacman_install adobe-source-code-pro-fonts
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']" | true
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal' | true
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'alacritty' | true
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>Return' | true

# neovim
pacman_install python-neovim
yay_install neovim-nightly-bin
pacman_install xsel
pacman_install ninja
yay_install lua-language-server
yay_install efm-langserver
yay_install lua-format
yay_install terraform-ls
pacman_install aspell-en
pacman_install cmake

# tmux
pacman_install tmux

# firefox
pacman_install firefox

# base devel
pacman_install base-devel
pacman_install clang

# USB drives
pacman_install exfat-utils

# fzf
pacman_install fzf

# autojump
yay_install autojump

# fish shell
pacman_install starship
pacman_install fish
sudo chsh -s /usr/bin/fish $USER

# vim/emacs shared
pacman_install ripgrep
pacman_install ttf-nerd-fonts-symbols
yay_install nerd-fonts-source-code-pro
pacman_install noto-fonts-emoji

# github
pacman_install github-cli

# chromium
pacman_install chromium

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

flatpak update -y

flatpak install flathub com.spotify.Client -y

yay_install slack-desktop

# syncthing
pacman_install syncthing
sudo ufw allow syncthing
sudo systemctl enable syncthing@$USER.service
sudo systemctl start syncthing@$USER.service

# jq
pacman_install jq
yay_install ijq

# transmission
pacman_install transmission-gtk

# tldr
pacman_install tldr

yay_install zoom

pacman_install htop

#docker
pacman_install docker
pacman_install docker-compose
sudo usermod -a -G docker $USER
sudo systemctl enable --now docker.service

# peek
pacman_install peek

# dev
yay_install asdf-vm

pacman_install postgresql

pacman_install libreoffice

yay_install circleci-cli-bin
yay_install pgformatter-git

pacman_install inetutils

pacman_install man-db
pacman_install man-pages

pacman_install fd
pacman_install entr
pacman_install httpie
pacman_install wget

# bluetooth
pacman_install pulseaudio-bluetooth
pacman_install bluez-utils
pacman_install bluez
sudo systemctl enable --now bluetooth.service

# time/locale
sudo ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
echo "KEYMAP=uk" | sudo tee -a /etc/vconsole.conf
sudo hwclock --systohc
sudo sed -i /etc/locale.gen -e 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/'
sudo locale-gen
echo "LANG=en_GB.UTF-8" | sudo tee -a /etc/locale.conf

# sway
pacman_install sddm
pacman_install upower
pacman_install light
pacman_install wofi
