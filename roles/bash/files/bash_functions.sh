# shellcheck disable=SC2148
function mkcd {
    mkdir -p "$1" && cd "$1" || return 1
}

function __now {
    date +%H:%M:%S
}
