function mkcd {
    mkdir -p "$1" && cd "$1" || return 1
}
