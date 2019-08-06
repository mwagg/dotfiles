#!/usr/bin/env bash
set -e

if [[ -f $HOME/.asdf/asdf.sh ]]; then
  ASDF_PATH="$HOME/.asdf"
fi
if [[ -f /opt/asdf-vm/asdf.sh ]]; then
  ASDF_PATH="/opt/asdf-vm"
fi
if [[ "" == "$ASDF_PATH" ]];then
  echo "asdf not found"
  exit 1
fi

source "$ASDF_PATH/asdf.sh"

[ -f $HOME/.asdf/asdf.sh ] && source $HOME/.asdf/asdf.sh
[ -f /opt/asdf-vm/asdf.sh ] && source /opt/asdf-vm/asdf.sh

asdf reshim

# nodejs
asdf plugin-add nodejs || true
type node || source "$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring"
asdf install nodejs 10.16.0
type yarn || npm install -g yarn
type tern || yarn global add tern
type eslint || yarn global add eslint
type js-beautify || yarn global add js-beautify

# elm
type elm || yarn global add elm
type elm-test || yarn global add elm-test
type elm-format || yarn global add elm-format
type elm-language-server || yarn global add @elm-tooling/elm-language-server

# clojure
asdf plugin-add java || true
asdf install java openjdk-11
asdf plugin-add clojure || true
asdf install clojure 1.10.1

# python
asdf plugin-add python || true
asdf install python 3.6.9
asdf shell python 3.6.9
pip install pipenv
pip install virtualenv
pip install jedi

asdf reshim

# elasticsearch and it's insatiable hunger for files
echo "vm.max_map_count=262144" | sudo tee -a /usr/lib/sysctl.d/elasticsearch.conf

sudo pacman -S --needed --noconfirm racket
raco pkg install --skip-installed pie
