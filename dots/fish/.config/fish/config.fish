if test -d $HOME/.rbenv/bin
    set -x PATH $HOME/.rbenv/bin $PATH
end
if test -d $HOME/.rbenv/shims
    set -x PATH $HOME/.rbenv/shims $PATH
end
if test -d $HOME/.rbenv
    source (rbenv init -|psub)
end

if test -d $HOME/.local/bin
    set -x PATH $HOME/.local/bin $PATH
end

if test -d $HOME/.local/node/bin
    set -x PATH $HOME/.local/node/bin $PATH
end

set -x PGHOST localhost
set -x PGUSER carwow
set -x PGPASSWORD carwow
set -x EDITOR nvim
set -x COUNTRY uk

if test -d $HOME/dev/carwow/dev-environment
    set -x PATH $HOME/dev/carwow/dev-environment/bin $PATH
    set -x PATH $HOME/dev/carwow/dev-environment/bin/stubs $PATH
end

begin
    set --local AUTOJUMP_PATH /usr/share/autojump/autojump.fish
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end
