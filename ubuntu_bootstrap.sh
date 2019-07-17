#!/bin/bash
set -e

# apt setup

DISTRO="$(lsb_release -s -c)"

# dotfiles
sudo apt install -y stow
./link_dotfiles.sh

# powertop
sudo apt install -y powertop
sudo cp templates/powertop.service /usr/lib/systemd/system/powertop.service
sudo systemctl enable powertop.service
sudo systemctl start powertop.service

#firewall
sudo ufw default allow outgoing
sudo ufw default deny incoming

# hub
sudo apt install -y hub

# tdlr
sudo apt install -y tldr

# shell
sudo apt install -y fish fzf autojump
sudo chsh -s /usr/bin/fish $USER

# vim
sudo apt install -y vim-nox

# curl
sudo apt install -y curl

# asdf
[ ! -e $HOME/.asdf ] && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.3
mkdir -p ~/.config/fish/completions && cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions
source ~/.asdf/asdf.sh
sudo apt install -y \
     automake autoconf libreadline-dev \
     libncurses-dev libssl-dev libyaml-dev \
     libxslt-dev libffi-dev libtool unixodbc-dev \
     unzip

# nodejs
asdf plugin-add nodejs || true
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs 10.16.0
npm install -g yarn

# python
asdf plugin-add python || true
sudo apt install -y zlib1g-dev
asdf install python 3.6.9
pip install pipenv
pip install virtualenv
pip install jedi
asdf reshim

# elm
mkdir -p $HOME/.local/elm/bin
[ ! -e $HOME/.local/elm/bin/elm ] && \
  curl -L https://github.com/elm/compiler/releases/download/0.19.0/binary-for-linux-64-bit.gz | gunzip - > $HOME/.local/elm/bin/elm && \
  chmod +x $HOME/.local/elm/bin/elm
npm install -g elm-format

# emacs
mkdir -p $HOME/.fonts
[ ! -e $HOME/.local/src/source-code-pro ] && git clone --depth 1 https://github.com/adobe-fonts/source-code-pro $HOME/.local/src/source-code-pro
cp $HOME/.local/src/source-code-pro/OTF/*.otf $HOME/.fonts/
fc-cache -f
sudo apt install -y ripgrep aspell-en emacs

# htop
sudo apt install -y htop

# ansible
sudo apt install -y ansible

# flatpak
sudo apt install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.spotify.Client -y
flatpak install flathub com.slack.Slack -y
flatpak install flathub com.uploadedlobster.peek -y
flatpak install flathub us.zoom.Zoom -y

# syncthing
if [[ ! -f /etc/apt/sources.list.d/syncthing.list ]]; then
  curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
  echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
  sudo apt update
fi
sudo apt install -y syncthing
sudo systemctl enable syncthing@mike.service

# docker
if [[ ! $(type docker) ]]; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $DISTRO test"
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose
fi
sudo usermod -aG docker $USER

# gnome
sudo apt install -y gnome-tweaks gnome-shell-timer

# postgresql client
sudo apt install -y postgresql-client

# tmux
sudo apt install -y tmux
