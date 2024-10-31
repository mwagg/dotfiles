#
# Executes commands at the start of an interactive session.
#

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

alias gs="git status"
alias gsk="git add -u ."
alias gl="git log --graph --oneline"
alias gc="git commit -v"
alias lg="lazygit"
alias be="bundle exec"
alias gb="git branch | fzf | git switch -"
alias gcd='cd $(find ~/src/github.com -type d -depth 2 -prune | fzf)'

alias tf="tmux-sessionizer"
alias rt="rails_test"
alias drb="rm -rf ~/.config/nix-darwin/flake.nix && cp ~/dotfiles/nix-darwin/flake.nix ~/.config/nix-darwin/flake.nix && darwin-rebuild switch --flake ~/.config/nix-darwin"

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
    export TERM=screen-256color
fi

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
[ -f "$HOME/.asdf/asdf.sh" ] && . $HOME/.asdf/asdf.sh
[ -d "$HOME/go/" ] && export PATH="$HOME/go/bin":$PATH
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin":$PATH

# FZF
[[ $- == *i* ]] && [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ] && source /opt/homebrew/opt/fzf/shell/completion.zsh 2> /dev/null
[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh 
[ -f /usr/local/docs/fzf/examples/key-bindings.zsh ] && source /usr/local/docs/fzf/examples/key-bindings.zsh

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '
