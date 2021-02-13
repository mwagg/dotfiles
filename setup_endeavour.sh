#!/usr/bin/env bash

set -e

function pacman_install {
  pacman -Q $1 || sudo pacman -S --needed --noconfirm $1
}

function yay_install {
  pacman -Q $1 || yay -S --needed --noconfirm $1
}

pacman_install base-devel
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

# vim
pacman_install vim

# tmux
pacman_install tmux

# base devel
pacman_install base-devel

# USB drives
pacman_install exfat-utils

# fzf
pacman_install fzf

# autojump
yay_install autojump

# fish shell
pacman_install fish
sudo chsh -s /usr/bin/fish $USER

# emacs
pacman_install adobe-source-code-pro-fonts
pacman_install aspell-en
pacman_install ripgrep
pacman_install emacs
sudo sed -i -e 's/^Exec=.*/Exec=\/usr\/bin\/fish -c emacs %f/' /usr/share/applications/emacs.desktop
pacman_install ttf-nerd-fonts-symbols
pacman_install cmake

# github hub
pacman_install hub

# chromium
pacman_install chromium
yay_install chromium-widevine

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
flatpak install flathub com.slack.Slack -y
flatpak install com.valvesoftware.Steam -y

# syncthing
pacman_install syncthing
sudo ufw allow syncthing
sudo systemctl enable syncthing@$USER.service
sudo systemctl start syncthing@$USER.service

# jq
pacman_install jq
yay_install ijq-bin

# transmission
pacman_install transmission-qt

# tldr
pacman_install tldr

yay_install zoom

pacman_install htop

#docker
pacman_install docker
pacman_install docker-compose
sudo usermod -a -G docker $USER
sudo systemctl enable --now docker.service

# ansible
pacman_install ansible

# peek
pacman_install peek

# dev
yay_install asdf-vm

pacman_install postgresql

pacman_install libreoffice

pacman_install python-neovim
pacman_install neovim

yay_install circleci-cli-bin
yay_install pgformatter-git

pacman_install inetutils

pacman_install man-db
pacman_install man-pages

pacman_install fd
pacman_install entr
pacman_install httpie
pacman_install wget
