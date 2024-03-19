#!/usr/bin/env bash
# original from: https://gist.github.com/RichardBronosky/56d8f614fab2bacdd8b048fb58d0c0c7

set -euo pipefail

function linux_copy {
    cat | xclip -selection clipboard
}

function linux_paste {
    xclip -selection clipboard -o
}

function macos_copy {
    cat | pbcopy
}

function macos_paste {
    pbpaste
}

function stdin_is_pipe_or_redirection {
    [[ -p /dev/stdin ]] && [[ ! -t 0 ]]
}

function prevent_prompt_from_being_on_the_same_line {
    # is the stdout a tty
    if [[ -t 1 ]]; then
        echo
    fi
}

function detect_os {
    case "$(uname -s)" in
    Linux*)
        printf "linux"
        ;;
    Darwin*)
        printf "macos"
        ;;
    *)
        echo "Clipboard only supports Linux and MacOS."
        exit 1
        ;;
    esac
}

function main {
    os="$(detect_os)"

    stdin_is_pipe_or_redirection
    if $?; then
        "${os}_copy"
    else
        "${os}_paste"
        prevent_prompt_from_being_on_the_same_line
    fi
}

main
