#!/usr/bin/env bash

SRC_URL="https://github.com/swaywm/sway/archive/1.0.tar.gz"
SRC_DIR=$HOME/.local/src/sway
SRC_TAR=$SRC_DIR/sway.tar.gz

if [[ ! -f $SRC_TAR ]]; then
  mkdir -p $SRC_DIR

  curl -o $SRC_TAR $SRC_URL
fi

rm -rf $SRC_DIR/build
mkdir $SRC_DIR/build
tar xzf $SRC_TAR -C $SRC_DIR/build/
