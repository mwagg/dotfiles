#!/usr/bin/env bash
set -e

trap 'rm -rf /tmp/key' EXIT

export PATH=$PATH:~/.local/bin

mkdir -p ~/.local/bin
type bw || { curl -L -o /tmp/bw.zip 'https://vault.bitwarden.com/download/?app=cli&platform=linux'; unzip /tmp/bw.zip -d ~/.local/bin/; chmod +x ~/.local/bin/bw; }
export BW_SESSION="$(bw login --raw)"
export BW_SESSION="$(bw unlock --raw)"

bw get attachment 9p6xj344ur9dce8y93msj2gsstem3ml3 --itemid dcedc674-089c-4f7f-a7d1-aa8e00b8b5ed --raw > /tmp/key
gpg --import /tmp/key
bw get attachment qgarlw2wotzg18s4etkyt3jjo47dsnfh --itemid dcedc674-089c-4f7f-a7d1-aa8e00b8b5ed --raw | gpg --import-ownertrust

bw get attachment iazv38i80dl0gq9ctn80p0zcoizlaglx --itemid e93fa440-324a-419e-acd4-aa7300d8ed5d --output ~/.ssh/eporta.pub
bw get attachment chocg8j9jn0ce67leh3u8my7ybp24d73 --itemid e93fa440-324a-419e-acd4-aa7300d8ed5d --output ~/.ssh/eporta

bw get attachment wvb3nx6m5evq5qgk76li684hqv34zksi --itemid 2b3bfe9d-ef76-4bba-9a27-a80000d36e86 --output ~/.ssh/id_rsa
bw get attachment 2gnovdize9kfq9maa0g1oenj9fn823wt --itemid 2b3bfe9d-ef76-4bba-9a27-a80000d36e86 --output ~/.ssh/id_rsa.pub

bw get attachment u563oebpumoyatmx9hxavnijbfk56jy7 --itemid 2e5b58ea-79a6-4421-8300-aa2200f9bfdf --output ~/.ssh/digital-ocean

chmod 600 ~/.ssh/*

./http_to_git_ssh.sh
