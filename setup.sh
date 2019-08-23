#!/usr/bin/env bash

set -e

source lib/core.sh

sudo pacman -Syyu --noconfirm --needed

pacman_install base-devel
pacman_install stow
./link_dotfiles.sh

function install_yay {
  mkdir -p $HOME/.local/src
  [ -d $HOME/.local/src/yay ] || git clone https://aur.archlinux.org/yay.git $HOME/.local/src/yay
  pushd $HOME/.local/src/yay
  makepkg -si --noconfirm
  popd
}

type yay || install_yay

pacman_install intel-ucode
pacman_install openssh

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
pacman_install gnome
pacman_install gnome-extra
pacman_install gnome-control-center
pacman_install gnome-backgrounds
pacman_install gnome-tweaks

# tilix
pacman_install tilix
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'tilix -e tmux'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>Return'

# vim
pacman_install vim

# tmux
pacman_install tmux

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
pacman_install xdg-utils
xdg-settings set default-web-browser firefox.desktop

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

flatpak install flathub com.spotify.Client -y
flatpak install flathub com.slack.Slack -y

# syncthing
pacman_install syncthing
sudo ufw allow syncthing
sudo systemctl enable syncthing@$USER.service
sudo systemctl start syncthing@$USER.service

# jq
pacman_install jq

# transmission
pacman_install transmission-gtk

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
mkdir -p $HOME/.config/libvirt
echo "nvram = [" > $HOME/.config/libvirt/qemu.conf
echo '"/usr/share/ovmf/x64/OVMF_CODE.fd:/usr/share/ovmf/x64/OVMF_VARS.fd"' >> $HOME/.config/libvirt/qemu.conf
echo "]" >> $HOME/.config/libvirt/qemu.conf

yay_install systemd-boot-pacman-hook

yay_install throttled
sudo systemctl enable --now lenovo_fix.service

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

# dsvpn
yay_install dsvpn-git

pacman_install postgresql

source lib/dev.sh

pacman_install libreoffice

pacman_install python-neovim
pacman_install neovim
yay_install nerd-fonts-complete
