function git-clean --no-scope-shadowing
    echo "Pruning remote branches which have been deleted"
    git remote prune origin

    echo "Deleting local branches which are already merged"
    for branch in (git branch --merged master | grep -v master | grep -v "*" | string trim)
        git branch -d $branch
    end

    echo "Removing local branches not present on origin"
    for branch in (git branch | grep -v master | grep -v "*" | string trim)
        git branch -r | grep $branch > /dev/null
        if test $status = 1
            git branch -D $branch
        end
    end
end
