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
type node || source "$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring"
asdf install nodejs 10.16.0
type yarn || npm install -g yarn
type tern || yarn global add tern
type eslint || yarn global add eslint
type js-beautify || yarn global add js-beautify
type prettier || yarn global add prettier
type javascript-typescript-langserver || yarn global add javascript-typescript-langserver
type eslint_d || yarn global add eslint_d
yarn global add neovim

# elm
type elm || yarn global add elm
type elm-test || yarn global add elm-test
type elm-format || yarn global add elm-format
type elm-language-server || yarn global add @elm-tooling/elm-language-server

# python
[ -d $HOME/.pyenv ] || git clone https://github.com/pyenv/pyenv.git ~/.pyenv
[ -d $HOME/.pyenv/plugins/pyenv-virtualenv ] || git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
[ -d $HOME/.poetry ] || curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
pyenv install 3.8.3 -s
pyenv install 3.6.9 -s

# clojure
asdf plugin-add java || true
asdf install java adopt-openjdk-12+33
asdf plugin-add clojure || true
asdf install clojure 1.10.1

# ruby
asdf plugin-add ruby || true
asdf install ruby 2.6.5
asdf shell ruby 2.6.5
gem install pry
gem install neovim

# elasticsearch and it's insatiable hunger for files
if [[ -f /usr/lib/sysctl.d/elasticsearch.conf ]]; then
  echo "vm.max_map_count=262144" | sudo tee -a /usr/lib/sysctl.d/elasticsearch.conf
fi

asdf reshim
