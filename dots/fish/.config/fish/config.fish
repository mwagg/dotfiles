if test -f $HOME/.asdf/asdf.sh
    source ~/.asdf/asdf.fish
end
if test -f /opt/asdf-vm/asdf.sh
    source /opt/asdf-vm/asdf.fish
end

if test -d $HOME/.local/bin
    set -x PATH $HOME/.local/bin $PATH
end

if test -d $HOME/.local/node/bin
    set -x PATH $HOME/.local/node/bin $PATH
end

if test -d $HOME/.local/elm/bin
    set -x PATH $HOME/.local/elm/bin $PATH
end

set -x PGHOST localhost
set -x EDITOR nvim
set -x COUNTRY uk

if test -d $HOME/dev/carwow/dev-environment
    set -x PATH $HOME/dev/carwow/dev-environment/bin $PATH
    set -x PATH $HOME/dev/carwow/dev-environment/bin/stubs $PATH
end

set -l AUTOJUMP_PATH /usr/share/autojump/autojump.fish /usr/local/share/autojump/autojump.fish
for path in $AUTOJUMP_PATH
  if test -e $path
      source $path
   end
end

if test -d /usr/local/opt/postgresql@9.6/bin
    set -x PATH /usr/local/opt/postgresql@9.6/bin $PATH
end

if test -d $HOME/.pyenv
    set -Ux PYENV_ROOT $HOME/.pyenv
    set -x PATH $HOME/.pyenv/bin $PATH
    status --is-interactive; and source (pyenv init -|psub)
    status --is-interactive; and pyenv virtualenv-init - | source
end

if test -d $HOME/.poetry/bin
   set -x PATH $HOME/.poetry/bin $PATH
end

fish_ssh_agent
