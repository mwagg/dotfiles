set fish_greeting

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

set -l AUTOJUMP_PATH /usr/share/autojump/autojump.fish /usr/local/share/autojump/autojump.fish
for path in $AUTOJUMP_PATH
    if test -e $path
        source $path
    end
end

if test -d $HOME/.pyenv
    set -Ux PYENV_ROOT $HOME/.pyenv
    set -x PATH $HOME/.pyenv/bin $PATH
    status --is-interactive; and source (pyenv init -|psub)
    status --is-interactive; and pyenv virtualenv-init - | source
end

if test -n "$DESKTOP_SESSION"
    set (gnome-keyring-daemon --start | string split "=")
end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.fish ]; and . ~/.config/tabtab/__tabtab.fish; or true
set -g fish_user_paths "/usr/local/opt/libpq/bin" $fish_user_paths

alias vim=nvim

starship init fish | source
