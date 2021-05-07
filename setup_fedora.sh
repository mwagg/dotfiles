#!/usr/bin/env bash

sudo dnf groupinstall "Development Tools" "Development Libraries" -y
sudo dnf install -y \
	alacritty \
	syncthing \
    ninja-build \
 	libtool \
 	gcc-c++ \
	stow \
    tldr \
	starship \
    fish \
    sqlite \
	tk-devel \
	clang \
	postgresql \
	autojump \
	autojump-fish

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'alacritty'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>Return'

systemctl --user enable --now syncthing.service

sudo usermod -s /usr/bin/fish mike

if [ ! -d ~/.asdf ]; then
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
fi
