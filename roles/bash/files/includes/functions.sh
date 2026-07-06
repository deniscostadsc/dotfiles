# shellcheck disable=SC2148
function mkcd {
    mkdir -p "$1" && cd "$1" || return 1
}

function __now {
    date +%H:%M:%S
}

function current_todo_task {
    local task
    task=$(todo current 2>/dev/null)
    if [[ -n "${task}" ]]; then
        echo -e "\nCURRENT TODO TASK: ${task}"
    fi
}
