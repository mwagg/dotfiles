set fish_greeting

if test -f $HOME/.asdf/asdf.sh
    source ~/.asdf/asdf.fish
end
if test -f /opt/asdf-vm/asdf.sh
    source /opt/asdf-vm/asdf.fish
end

for path in $HOME/.local/bin \
		$HOME/.local/node/bin \
		$HOME/.local/elm/bin \
		/usr/local/bin \
		/usr/local/opt/libpq/bin \
		/usr/local/sbin \
		/opt/homebrew/bin
	if test -d "$path"
		set -g fish_user_paths "$path" $fish_user_paths
	end
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
    set -g fish_user_paths "$HOME/.pyenv/bin" $fish_user_paths
	status --is-interactive; and source (pyenv init -|psub)
	status --is-interactive; and source (pyenv virtualenv-init -|psub)
end

if test -n "$DESKTOP_SESSION"
    set (gnome-keyring-daemon --start | string split "=")
end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.fish ]; and . ~/.config/tabtab/__tabtab.fish; or true

alias vim=nvim

starship init fish | source
