#!/usr/bin/env bash

set -e

function install {
  sudo dnf install -y $1
}

function clone_src {
  path="$HOME/.local/src/$2"
  if [[ ! -d $path ]]; then
    git clone $1 $path --depth 1
  fi
}

install stow
./link_dotfiles.sh

# rpmfusion
version=$(rpm -E %fedora)
install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$version.noarch.rpm
install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$version.noarch.rpm

# emacs
install adobe-source-code-pro-fonts
install aspell
install aspell-en
install ripgrep
install emacs

# fish shell
install fish
install util-linux-user
sudo chsh -s /usr/bin/fish $USER

# power management
install acpi
install powertop
sudo cp templates/powertop.service /usr/lib/systemd/system/powertop.service
sudo systemctl enable powertop.service
sudo systemctl start powertop.service

# gnome
install gnome-tweaks

# nodejs
export PATH=~/.local/node/bin:$PATH
if ! command -v node &> /dev/null; then
  NODE_VERSION=10.15.3
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
install clojure

# elm
npm_g elm
npm_g elm-test
npm_g elm-oracle
npm_g elm-format

# heroku
npm_g heroku

# htop
install htop

# fzf
install fzf

# autojump
install autojump
install autojump-fish

# github hub
install hub

# containers
install podman
install buildah
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install --releasever=29 docker-ce docker-ce-cli -y
sudo systemctl enable --now docker
sudo usermod -a -G docker $USER

# chromium
install chromium

# aws
install awscli

# flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.spotify.Client -y
flatpak install flathub com.slack.Slack -y
flatpak install flathub com.uploadedlobster.peek -y
flatpak install flathub us.zoom.Zoom -y

# syncthing
install syncthing
# sudo ufw allow syncthing
sudo systemctl enable syncthing@$USER.service
sudo systemctl start syncthing@$USER.service

# tldr
install tldr

# jq
install jq

# transmission
install transmission

# vim
install vim

# qemu
install qemu
install edk2-ovmf
install virt-manager
mkdir -p $HOME/.config/libvirt

# look and feel
mkdir -p $HOME/.local/src
# icons
mkdir -p $HOME/.local/share/icons
clone_src https://github.com/cbrnix/Newaita Newaita
ln -sf $HOME/.local/src/Newaita/Newaita $HOME/.local/share/icons/Newaita
gsettings set org.gnome.desktop.interface icon-theme Newaita

# gtk theme
clone_src https://github.com/vinceliuice/Qogir-theme Qogir-theme
$HOME/.local/src/Qogir-theme/Install
gsettings set org.gnome.desktop.interface gtk-theme Qogir-light

# video
install mpv
install youtube-dl
install ffmpeg-libs
install compat-ffmpeg28

# lednf copr enable abn/throttled
sudo dnf copr enable abn/throttled -y
install throttled

sudo systemctl enable throttled
sudo systemctl start throttled

# tmux
install tmux
