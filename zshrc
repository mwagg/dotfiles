#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

alias gs="git status"
alias gsk="git add -u ."
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -- ";
alias gc="git commit -v"
alias lg="lazygit"
alias be="bundle exec"

alias tf="tmux-sessionizer"

if (( $+commands[nvim])); then
    alias vim=nvim
fi

function ga() {
    git add $1
}

function ctop() {
    docker run --rm -ti --name=ctop -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest
}

function git-clean() {
    echo "Pruning remote branches which have been deleted"
    git remote prune origin
    if (git branch | grep main > /dev/null)
    then
        main="main"
    elif (git branch | grep master > /dev/null)
    then
        main="master"
    else
        echo "Can't figure out what the main branch name is"
        exit 1
    fi
    echo "Deleting local branches which are already merged"
    for branch in $(git branch --merged $main | grep -v $main | grep -v "*" | xargs)
    do
        git branch -d $branch
    done
    echo "Removing local branches not present on origin"
    for branch in $(git branch | grep -v $main | grep -v "*" | xargs)
    do
        git branch -r | grep $branch > /dev/null
        if [[ "$status" == "1" ]]
        then
            git branch -D $branch
        fi
    done
}

[ -f /etc/zsh/zshrc.default.inc.zsh ] && source /etc/zsh/zshrc.default.inc.zsh
if [ "$SPIN" ]; then
    export TERM=xterm-256color
fi

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
[ -f "$HOME/.asdf/asdf.sh" ] && . $HOME/.asdf/asdf.sh
[ -d "$HOME/go/" ] && export PATH="$HOME/go/bin":$PATH
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin":$PATH

# FZF
[[ $- == *i* ]] && [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ] && source /opt/homebrew/opt/fzf/shell/completion.zsh 2> /dev/null
[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh 
[ -f /usr/local/docs/fzf/examples/key-bindings.zsh ] && source /usr/local/docs/fzf/examples/key-bindings.zsh
