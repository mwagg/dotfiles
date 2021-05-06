#!/usr/bin/env bash

set -e

function link_dots {
  pushd "dots/$1" &> /dev/null
  DIRS=$(find "$PWD" -mindepth 1 -maxdepth 1 -type d -not -name ".*")

  for dir in $DIRS; do
    echo "Linking $(basename $dir)"
    stow $(basename $dir) -t $HOME
  done
  popd &> /dev/null
}

link_dots shared
link_dots $OSTYPE

# secrets
function decrypt_file {
    target="$HOME/$1"
    source="$HOME/.config/secret/$1.gpg"

    echo "Decrypting $1"

    if [[ ! -f "$target" ]] && [[ -f "$source" ]]; then
        echo "Decrypting: $source"
	gpg --output $target --decrypt $source
    fi
}
mkdir -p "$HOME/.aws"
decrypt_file ".aws/config"
decrypt_file ".aws/credentials"
mkdir -p ~/.ssh
decrypt_file ".ssh/config"
decrypt_file ".terraformrc"

popd &> /dev/null
