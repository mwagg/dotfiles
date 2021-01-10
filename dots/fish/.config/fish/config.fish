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

if test -d $HOME/.cargo/bin
    set -x PATH $HOME/.cargo/bin $PATH
end

fish_ssh_agent

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.fish ]; and . ~/.config/tabtab/__tabtab.fish; or true
set -g fish_user_paths "/usr/local/opt/libpq/bin" $fish_user_paths

function vterm_printf
    if [ -n "$TMUX" ]
        # tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end

function vterm_prompt_end
    vterm_printf '51;A'(whoami)'@'(hostname)':'(pwd)
end

functions --copy fish_prompt vterm_old_fish_prompt
function fish_prompt --description 'Write out the prompt; do not replace this. Instead, put this at end of your file.'
    # Remove the trailing newline from the original prompt. This is done
    # using the string builtin from fish, but to make sure any escape codes
    # are correctly interpreted, use %b for printf.
    printf "%b" (string join "\n" (vterm_old_fish_prompt))
    vterm_prompt_end
end

function vterm_cmd --description 'Run an Emacs command among the ones been defined in vterm-eval-cmds.'
    set -l vterm_elisp ()
    for arg in $argv
        set -a vterm_elisp (printf '"%s" ' (string replace -a -r '([\\\\"])' '\\\\\\\\$1' $arg))
    end
    vterm_printf '51;E'(string join '' $vterm_elisp)
end

function find-file
    set -q argv[1]; or set argv[1] "."
    vterm_cmd find-file (realpath "$argv")
end
