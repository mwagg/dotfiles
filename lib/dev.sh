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
type tsc yarn global add typescript
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
  # python
  [ -d $HOME/.pyenv ] || git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  [ -d $HOME/.pyenv/plugins/pyenv-virtualenv ] || git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
  [ -d $HOME/.poetry ] || curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  pyenv install 3.6.9 -s
fi

# elasticsearch and it's insatiable hunger for files
if [[ -f /usr/lib/sysctl.d/elasticsearch.conf ]]; then
  echo "vm.max_map_count=262144" | sudo tee -a /usr/lib/sysctl.d/elasticsearch.conf
fi

asdf reshim
