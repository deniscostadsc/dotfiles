# shellcheck disable=SC2148
function __git_arrows {
    git rev-parse --abbrev-ref @"{u}" &>/dev/null || return
    git rev-list --left-right --count HEAD...@"{u}" &>/dev/null || return

    local branch_status
    branch_status=$(git rev-list --left-right --count HEAD...@"{u}" 2>/dev/null)

    local left_arrow
    local right_arrow
    # $branch_status has a tab char, using cut withouts quotes is easier
    # shellcheck disable=SC2086
    left_arrow=$(echo ${branch_status} | cut -f 1 -d " ")
    # shellcheck disable=SC2086
    right_arrow=$(echo ${branch_status} | cut -f 2 -d " ")

    local arrows
    [[ "${left_arrow}" != 0 ]] && arrows="⇡"
    [[ "${right_arrow}" != 0 ]] && arrows="${arrows}⇣"

    echo "${arrows}"
}

function __git_branch {
    git branch 2>/dev/null | grep "^\*" | sed "s/* //g"
}
