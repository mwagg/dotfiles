#!/usr/bin/env bash

set -e

sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

sudo dnf groupinstall "Development Tools" "Development Libraries" -y
sudo dnf install -y \
	alacritty \
	syncthing \
	ninja-build \
 	libtool \
	cmake \
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
	autojump-fish \
	xsel \
	chromium \
	ripgrep \
	gnome-tweaks \
	entr \
	fd-find \
	openssh-server \
	htop \
	terraform \
	haproxy \
    postgresql \
    postgresql-devel \
    ranger

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'alacritty'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>Return'

systemctl --user enable --now syncthing.service

sudo usermod -s /usr/bin/fish mike

if [ ! -d ~/.asdf ]; then
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
fi

sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak update -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub com.slack.Slack -y
sudo flatpak override --filesystem=home:ro com.slack.Slack

if [ ! -d ~/.local/share/nerd-fonts ]; then
	git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git ~/.local/share/nerd-fonts
	pushd ~/.local/share/nerd-fonts
	./install.sh
	popd
fi

sudo systemctl enable --now sshd.service

type nvim > /dev/null 2>&1 || { git clone https://github.com/neovim/neovim.git ~/.local/share/neovim; cd ~/.local/share/neovim; git checkout nightly; make CMAKE_BUILD_TYPE=RelWithDebInfo; sudo make install; }

type gh || sudo dnf -y install https://github.com/cli/cli/releases/download/v1.9.2/gh_1.9.2_linux_amd64.rpm

type aws || { curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"; cd /tmp; unzip "/tmp/awscliv2.zip"; sudo ./aws/install; }
