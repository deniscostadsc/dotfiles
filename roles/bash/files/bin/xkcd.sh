#!/usr/bin/env bash

which_comic_show="random"
show_explanation=0
comic_number=0

set -euo pipefail

CACHE_DIR="${HOME}/.cache/xkcd"
mkdir -p "${CACHE_DIR}"

function get_cached_latest {
    local cache_file="${CACHE_DIR}/latest"
    if [[ -f "${cache_file}" ]]; then
        local cached_date
        cached_date=$(head -n1 "${cache_file}" 2>/dev/null)
        local today
        today=$(date +%Y-%m-%d)
        if [[ "${cached_date}" == "${today}" ]]; then
            tail -n1 "${cache_file}" 2>/dev/null
        fi
    fi
}

function cache_latest {
    local latest_num=$1
    local cache_file="${CACHE_DIR}/latest"
    date +%Y-%m-%d >"${cache_file}"
    echo "${latest_num}" >>"${cache_file}"
}

function get_cached_comic {
    local comic_num=$1
    local cache_file="${CACHE_DIR}/${comic_num}"
    if [[ -f "${cache_file}" ]]; then
        cat "${cache_file}"
    fi
}

function cache_comic {
    local comic_num=$1
    local json_data=$2
    local cache_file="${CACHE_DIR}/${comic_num}"
    echo "${json_data}" >"${cache_file}"
}

if command -v viu &>/dev/null; then
    render_cmd="viu"
elif command -v chafa &>/dev/null; then
    render_cmd="chafa"
else
    echo "Install 'viu' or 'chafa' to display images"
    exit 1
fi

function show_help {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

View XKCD comics in your terminal, random by default.

OPTIONS:
    -l, --latest              Show the latest comic (cannot be used with -n)
    -n, --number <NUMBER>     Show a specific comic (cannot be used with -l)
    -x, --show-explanation    Include explanation link in output
    -h, --help                Show this help message

EOF
}

function show_xkcd_comic {
    comic_number=$1
    show_explanation=$2

    comic_json=$(get_cached_comic "${comic_number}")

    if [[ -z "${comic_json}" ]]; then
        comic_json=$(curl -s "https://xkcd.com/${comic_number}/info.0.json")
        if [[ -n "${comic_json}" ]]; then
            cache_comic "${comic_number}" "${comic_json}"
        fi
    fi

    title=$(echo "${comic_json}" | jq -r '.title')
    alt_text=$(echo "${comic_json}" | jq -r '.alt')
    img_url=$(echo "${comic_json}" | jq -r '.img')

    echo
    echo "XKCD #${comic_number}: ${title}"
    echo
    curl -s "${img_url}" | ${render_cmd} -
    echo
    echo "Alt Text: ${alt_text}"
    echo "Comic URL: https://xkcd.com/${comic_number}/"
    echo "Explanation: https://www.explainxkcd.com/wiki/index.php/${comic_number}"
    echo
}

while [[ $# -gt 0 ]]; do
    case ${1} in
    -l | --latest)
        if [[ ${which_comic_show} == "specific" ]]; then
            echo "Error: -l and -n options cannot be used together."
            exit 1
        fi
        which_comic_show="latest"
        shift
        ;;
    -n | --number)
        if [[ ${which_comic_show} == "latest" ]]; then
            echo "Error: -l and -n options cannot be used together."
            exit 1
        fi
        shift
        if [[ -z ${1:-} ]]; then
            echo "You must inform the comic number"
            exit 1
        fi
        comic_number="${1}"
        shift
        which_comic_show="specific"
        ;;
    -x | --show-explanation)
        show_explanation=1
        shift
        ;;
    -h | --help)
        show_help
        exit 0
        ;;
    -c | --clear-cache)
        read -r -p "Are you sure you want to clear the cache? [y/N] " confirm
        if [[ "${confirm}" =~ ^[Yy]$ ]]; then
            rm -rf "${CACHE_DIR:?}"/*
        fi
        exit 0
        ;;
    *)
        echo "${1} is an invalid option."
        exit 1
        ;;
    esac
done

latest_comic_number=$(get_cached_latest)

if [[ -z "${latest_comic_number}" ]]; then
    latest_comic_number=$(curl -s https://xkcd.com/info.0.json | jq -r '.num')
    if [[ -n "${latest_comic_number}" ]]; then
        cache_latest "${latest_comic_number}"
    fi
fi

if [[ ${which_comic_show} == "latest" ]]; then
    comic_number=${latest_comic_number}
elif [[ ${which_comic_show} == "random" ]]; then
    comic_number=$((1 + RANDOM % latest_comic_number))
fi

show_xkcd_comic "${comic_number}" "${show_explanation}"
