#!/usr/bin/env bash
# original from: https://gist.github.com/RichardBronosky/56d8f614fab2bacdd8b048fb58d0c0c7

set -euo pipefail

function linux_copy {
    cat | xclip -selection clipboard
}

function linux_paste {
    xclip -selection clipboard -o
}

function wsl_copy {
    cat | /mnt/c/Windows/System32/clip.exe
}

function wsl_paste {
    /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe Get-Clipboard | sed 's/\r//'
}

function cygwin_copy {
    cat >/dev/clipboard
}

function cygwin_paste {
    cat /dev/clipboard
}

function macos_copy {
    cat | pbcopy
}

function macos_paste {
    pbpaste
}

function stdin_is_a_pipe {
    [[ -p /dev/stdin ]]
}

function stdin_is_a_tty {
    [[ -t 0 ]]
}

function stdin_is_pipe_like {
    stdin_is_a_pipe || ! stdin_is_a_tty
}

function stdout_is_pipe_like {
    ! stdout_is_a_tty
}

function stdout_is_a_tty {
    [[ -t 1 ]]
}

function requested_open_ended {
    [[ "${args[0]:-}" == "-" ]]
}

function requested_test_suite {
    [[ "${args[0]:-}" == "--test" ]]
}

function enable_tee_like_chaining {
    # see `man tee`
    if stdout_is_pipe_like; then
        "${os}_paste"
    elif requested_open_ended; then
        "${os}_paste"
        echo
    fi
}

function prevent_prompt_from_being_on_the_same_line {
    if stdout_is_a_tty; then
        echo
    fi
}

function detect_os {
    if [[ -f /proc/version ]] && grep -iq Microsoft /proc/version; then
        printf wsl
    else
        case "$(uname -s)" in
        Linux*)
            printf linux
            ;;
        Darwin*)
            printf macos
            ;;
        cygwin*)
            printf cygwin
            ;;
        *)
            echo "Clipboard only supports Linux and MacOS."
            exit 1
            ;;
        esac
    fi
}

function test_suite {
    printf '1234' | ${BASH_SOURCE[0]}

    printf "\n1. output to TTY\n"
    ${BASH_SOURCE[0]}
    printf "1234 should be above.\n"

    printf "\n2. output to pipe\n"
    ${BASH_SOURCE[0]} | cat
    echo
    printf "1234 should be above.\n"

    printf "\n3. input from pipe and output to pipe\n"
    printf '1234' | ${BASH_SOURCE[0]} | cat
    echo
    printf "1234 should be above.\n"
}

function debug {
    stdin_is_a_pipe && echo "stdin_is_a_pipe: 1" >>/tmp/ono || echo "stdin_is_a_pipe: 0" >>/tmp/ono
    stdin_is_a_tty && echo "stdin_is_a_tty: 1" >>/tmp/ono || echo "stdin_is_a_tty: 0" >>/tmp/ono
    stdin_is_pipe_like && echo "stdin_is_pipe_like: 1" >>/tmp/ono || echo "stdin_is_pipe_like: 0" >>/tmp/ono
    stdout_is_pipe_like && echo "stdout_is_pipe_like: 1" >>/tmp/ono || echo "stdout_is_pipe_like: 0" >>/tmp/ono
    stdout_is_a_tty && echo "stdout_is_a_tty: 1" >>/tmp/ono || echo "stdout_is_a_tty: 0" >>/tmp/ono
    echo >>/tmp/ono
}

function main {
    os="$(detect_os)"
    if stdin_is_pipe_like; then
        "${os}_copy"
        enable_tee_like_chaining
    else
        "${os}_paste"
        prevent_prompt_from_being_on_the_same_line
    fi
}

args=("$@")
if requested_test_suite; then
    export DEBUG=1
    test_suite
else
    [[ ${DEBUG:-} == 1 ]] && debug
    main
fi
