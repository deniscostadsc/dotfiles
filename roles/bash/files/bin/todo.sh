#!/usr/bin/env bash

set -euo pipefail

TODO_FOLDER="${HOME}/.todo"
TODO_FILE="${TODO_FOLDER}/todo"
DONE_FILE="${TODO_FOLDER}/done"

# Create file if it doesn't exist
mkdir -p "${TODO_FOLDER}"
touch "${TODO_FILE}"
touch "${DONE_FILE}"

while [[ $# -gt 0 ]]; do
    case "${1}" in
    "add")
        read -r -p "Task: " task
        echo "- ${task}" >>"${TODO_FILE}"
        echo "Added: '${task}'"
        exit 0
        ;;
    "list")
        nl -w2 -s'. ' "${TODO_FILE}"
        exit 0
        ;;
    "start")
        nl -w2 -s'. ' "${TODO_FILE}"
        echo
        read -r -p "Task number to mark as current: " num
        if [[ -n "${num}" ]]; then
            sed -i '' "s/^* /- /" "${TODO_FILE}"
            sed -i '' "${num}s/^- /* /" "${TODO_FILE}"
            echo
            echo "Task ${num} marked as current!"
        fi
        exit 0
        ;;
    "current")
        grep '^\* ' "${TODO_FILE}" | sed 's/^\* //'
        exit 0
        ;;
    "stop")
        sed -i '' "s/^\* /- /" "${TODO_FILE}"
        exit 0
        ;;
    "done")
        current_num=$(grep -n '^\* ' "${TODO_FILE}" | cut -d: -f1 | head -n1)
        if [[ -z "${current_num}" ]]; then
            echo "No task is currently in progress."
        else
            task_line=$(sed -n "${current_num}p" "${TODO_FILE}")
            echo "Current task: ${task_line#'* '}"
            read -r -p "Are you sure you want to mark this task as done? [y/N] " confirm
            if [[ "${confirm}" =~ ^[Yy]$ ]]; then
                sed -i '' "${current_num}d" "${TODO_FILE}"
                echo "$(date '+%Y-%m-%d %H:%M:%S') - ${task_line#'* '}" >>"${DONE_FILE}"
                echo "Task marked as done and moved to done list!"
            else
                echo "Aborted. Task not marked as done."
            fi
        fi
        exit 0
        ;;
    "delete")
        nl -w2 -s'. ' "${TODO_FILE}"
        echo
        read -r -p "Task number to delete: " num
        if [[ -n "${num}" ]]; then
            sed -i '' "${num}d" "${TODO_FILE}"
            echo "Task ${num} deleted from todo list."
        fi
        exit 0
        ;;
    "help")
        echo "Usage:"
        echo "  todo.sh add"
        echo "  todo.sh list"
        echo "  todo.sh start"
        echo "  todo.sh current"
        echo "  todo.sh stop"
        echo "  todo.sh done"
        echo "  todo.sh delete"
        exit 0
        ;;
    *)
        echo "Unknown command: $1"
        echo "Run 'todo.sh help' for usage information."
        exit 1
        ;;
    esac
done
