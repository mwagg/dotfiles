#!/usr/bin/env bash

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
bash "$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring"
asdf install nodejs 12.18.4
type yarn || npm install -g yarn
type tern || yarn global add tern
type eslint || yarn global add eslint
type eslint_d || yarn global add eslint_d
type js-beautify || yarn global add js-beautify
type prettier || yarn global add prettier
type tsc || yarn global add typescript
type typescript-language-server|| yarn global add typescript-language-server
type eslint_d || yarn global add eslint_d
type yaml-language-server || yarn global add yaml-language-server
type bash-language-server || yarn global add bash-language-server
yarn global add vim-language-server
yarn global add pyright
yarn global add neovim

# elm
type elm || yarn global add elm
type elm-test || yarn global add elm-test
type elm-format || yarn global add elm-format
type elm-language-server || yarn global add @elm-tooling/elm-language-server

if [[ "$OSTYPE" == "linux-gnu"* ]]
then
  asdf plugin add python || true
  [[ -f /home/mike/.asdf/installs/python/3.6.9 ]] || CC=clang asdf install python 3.6.9
  asdf shell python 3.6.9
  type virtualenv || pip install virtualenv
fi

# ruby
asdf plugin add ruby || true
asdf install ruby 3.0.1

# elasticsearch and it's insatiable hunger for files
if [[ -f /usr/lib/sysctl.d/elasticsearch.conf ]]; then
  echo "vm.max_map_count=262144" | sudo tee -a /usr/lib/sysctl.d/elasticsearch.conf
fi

asdf reshim
