#!/usr/bin/env bash
mkdir -p ~/.emacs.d
touch ~/.emacs.d/emacs-custom.el

pushd dots &> /dev/null
DIRS=$(find "$PWD" -mindepth 1 -maxdepth 1 -type d -not -name ".*")

for dir in $DIRS; do
  stow $(basename $dir) -t $HOME
done

# secrets
function decrypt_file {
    target="$HOME/$1"
    source="$HOME/.config/secret/$1.gpg"

    echo "Decrypting: $source"

    if [[ ! -f "$target" ]] && [[ -f "$source" ]]; then
	gpg --output $target --decrypt $source
    fi
}
mkdir -p "$HOME/.aws"
decrypt_file ".aws/config"
decrypt_file ".aws/credentials"
mkdir -p ~/.ssh
decrypt_file ".ssh/config"

popd &> /dev/null
