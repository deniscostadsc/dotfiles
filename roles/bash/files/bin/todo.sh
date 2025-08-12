#!/usr/bin/env bash

set -euo pipefail

if [[ "${OSTYPE}" == "darwin"* ]]; then
    SED_CMD="sed -i ''"
else
    SED_CMD="sed -i"
fi

TODO_FOLDER="${HOME}/.todo"
TODO_FILE="${TODO_FOLDER}/todo"
DONE_FILE="${TODO_FOLDER}/done"
DELETED_FILE="${TODO_FOLDER}/deleted"
ARCHIVE_FOLDER="${TODO_FOLDER}/archive"

function show_help {
    echo "Usage:"
    echo "  $(basename "$0") add"
    echo "  $(basename "$0") list"
    echo "  $(basename "$0") start"
    echo "  $(basename "$0") current"
    echo "  $(basename "$0") stop"
    echo "  $(basename "$0") done"
    echo "  $(basename "$0") delete"
}

function list_tasks {
    nl -w2 -s'. ' "${TODO_FILE}"
}

function create_archive {
    local timestamp=$(date '+%Y%m%d_%H%M%S')
    local counter=1
    local archive_name="${ARCHIVE_FOLDER}/todo_archive_${timestamp}_${counter}.zip"

    while [[ -f "${archive_name}" ]]; do
        counter=$((counter + 1))
        archive_name="${ARCHIVE_FOLDER}/todo_archive_${timestamp}_${counter}.zip"
    done

    cd "${TODO_FOLDER}" && zip -q "${archive_name}" todo done deleted >/dev/null 2>&1 || true
}

mkdir -p "${TODO_FOLDER}"
mkdir -p "${ARCHIVE_FOLDER}"
touch "${TODO_FILE}"
touch "${DONE_FILE}"
touch "${DELETED_FILE}"

while [[ $# -gt 0 ]]; do
    case "${1}" in
    "add")
        read -r -p "Task: " task
        create_archive
        echo "- ${task}" >>"${TODO_FILE}"
        echo "Added: '${task}'"
        exit 0
        ;;
    "list")
        list_tasks
        exit 0
        ;;
    "start")
        list_tasks
        echo
        read -r -p "Task number to mark as current: " num
        if [[ -n "${num}" ]]; then
            create_archive
            ${SED_CMD} "s/^\* /- /" "${TODO_FILE}"
            ${SED_CMD} "${num}s/^- /\* /" "${TODO_FILE}"
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
        create_archive
        ${SED_CMD} "s/^\* /- /" "${TODO_FILE}"
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
                create_archive
                ${SED_CMD} "${current_num}d" "${TODO_FILE}"
                echo "$(date '+%Y-%m-%d %H:%M:%S') - ${task_line#'* '}" >>"${DONE_FILE}"
                echo "Task marked as done and moved to done list!"
            else
                echo "Aborted. Task not marked as done."
            fi
        fi
        exit 0
        ;;
    "delete")
        list_tasks
        echo
        read -r -p "Task number to delete: " num
        if [[ -n "${num}" ]]; then
            task_line=$(sed -n "${num}p" "${TODO_FILE}")
            create_archive
            ${SED_CMD} "${num}d" "${TODO_FILE}"
            echo "$(date '+%Y-%m-%d %H:%M:%S') - ${task_line#'- '}" >>"${DELETED_FILE}"
            echo "Task ${num} deleted from todo list."
        fi
        exit 0
        ;;
    "help")
        show_help
        exit 0
        ;;
    *)
        echo "Unknown command: $1"
        show_help
        exit 1
        ;;
    esac
done

show_help
