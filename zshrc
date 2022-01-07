#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
if [ -e /Users/mike/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/mike/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

alias gs="git status";
alias gsk="git add -u .";
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -- ";
alias gc="git commit";

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

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

if [ -f /etc/zsh/zshrc.default.inc.zsh ]; then
    source /etc/zsh/zshrc.default.inc.zsh
fi

if [ "$SPIN" ]; then
    export TERM=xterm-256color
fi

