#!/usr/bin/env bash

emacsclient -a false -e 't' &> /dev/null || emacs --daemon &> /dev/null
emacsclient -nc
