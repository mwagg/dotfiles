function rebase
    if contains '* master' (git branch)
        printf "\e[031mDon't run me on master!\n\e[0m"
        return 1
    end

    git fetch
    git rebase origin/master
    printf "\e[032mYou are now "(git rev-list origin/master.. --count)" commit(s) ahead of origin/master\n\e[0m"
end
