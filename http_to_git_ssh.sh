#!/usr/bin/env bash

set -e

if git remote show origin | grep "Fetch URL: https"; then
    git remote rm origin
    git remote add origin git+ssh://git@github.com/mwagg/dotfiles.git
    git fetch
fi
