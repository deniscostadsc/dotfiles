alias git-remove-branchs='git branch -D $(git branch | grep -v "*\|master")'

function __git_arrows {
    git rev-parse --abbrev-ref @"{u}" &>/dev/null || return
    local branch_status

    branch_status="$(git rev-list --left-right --count HEAD...@"{u}" 2>/dev/null)"

    [ "$?" == 0 ] || return
    local left_arrow
    local right_arrow

    left_arrow=$(echo $branch_status | cut -f 1 -d " ")
    right_arrow=$(echo $branch_status | cut -f 2 -d " ")

    local arrows
    [ "$left_arrow" != 0 ] && arrows="⇡"
    [ "$right_arrow" != 0 ] && arrows="${arrows}⇣"

    echo $arrows
}

function __git_branch {
    echo -n "$(git branch 2>/dev/null | grep "^*" | sed "s/* //g")"
}
