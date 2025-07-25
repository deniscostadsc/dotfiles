#!/usr/bin/env bash

set -euo pipefail

# TODO:
# - Add entropy estimation and strength indicators

DEFAULT_MIN_WORD_LENGTH=4
DEFAULT_MAX_WORD_LENGTH=6
DEFAULT_PASSPHRASE_WORD_COUNT=6

min_word_length=${DEFAULT_MIN_WORD_LENGTH}
max_word_length=${DEFAULT_MAX_WORD_LENGTH}
passphrase_word_count=${DEFAULT_PASSPHRASE_WORD_COUNT}

search_cmd="grep -E"
if command -v rg >/dev/null 2>&1; then
    search_cmd="rg -N"
fi

dictionary_path=""
while read -r path; do
    if [[ -f "${path}" && -r "${path}" ]]; then
        dictionary_path="${path}"
        break
    fi
done <<'EOF'
/usr/share/dict/words
/usr/dict/words
/usr/share/dict/american-english
/usr/share/dict/british-english
EOF

if [[ -z "${dictionary_path}" ]]; then
    echo "No dictionary file found."
    exit 1
fi

validate_range() {
    local value=$1
    local min=$2
    local max=$3
    local name=$4

    if [[ ${value} -lt ${min} ]] || [[ ${value} -gt ${max} ]]; then
        echo "${name} must be between ${min} and ${max}"
        exit 1
    fi
}

function show_help {
    echo
    echo "passphrase"
    echo
    echo "--min (-n) sets minimum number of characters in the words (default: ${DEFAULT_MIN_WORD_LENGTH})"
    echo "--max (-m) sets maximum number of characters in the words (default: ${DEFAULT_MAX_WORD_LENGTH})"
    echo "--count (-c) sets how many word the passphrase will contain (default: ${DEFAULT_PASSPHRASE_WORD_COUNT})"
    echo "--help (-h) shows help message and exit"
    echo
}

while [[ $# -gt 0 ]]; do
    case $1 in
    --min | -n)
        if [[ -z "${2:-}" ]]; then
            echo "Invalid option"
            exit 1
        fi
        min_word_length=$2
        validate_range "${min_word_length}" 1 100 "Min word length"
        shift
        ;;
    --max | -m)
        if [[ -z "${2:-}" ]]; then
            echo "Invalid option"
            exit 1
        fi
        max_word_length=$2
        validate_range "${max_word_length}" 1 100 "Max word length"
        shift
        ;;
    --count | -c)
        if [[ -z "${2:-}" ]]; then
            echo "Invalid option"
            exit 1
        fi
        passphrase_word_count=$2
        validate_range "${passphrase_word_count}" 0 1000 "Word count"
        shift
        ;;
    --help | -h)
        show_help
        exit 0
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
    esac
    shift
done

if [[ ${max_word_length} -lt ${min_word_length} ]]; then
    echo "Max should be greater than min (current: min=${min_word_length}, max=${max_word_length})"
    exit 1
fi

# Temporarily disable exit on error to handle search failures gracefully
set +e
elegible_words=$(
    ${search_cmd} "^[a-z]{${min_word_length},${max_word_length}}$" "${dictionary_path}" | tr '\n' ' '
)
set -e

if [[ -z ${elegible_words} ]]; then
    echo "There are no available words with this size"
    exit 1
fi

word_count=$(wc -w <<<"${elegible_words}")

for ((i = 0; i < "${passphrase_word_count}"; i++)); do
    random_bytes=$(head -c 4 /dev/urandom | od -An -tu4 | tr -d ' ')
    word_index="$((random_bytes % word_count + 1))"
    word="$(cut -d ' ' -f "${word_index}" <<<"${elegible_words}" | tr '[:upper:]' '[:lower:]')"

    if [[ ${i} -lt $((passphrase_word_count - 1)) ]]; then
        echo -n "${word} "
    else
        echo "${word}"
    fi
done

exit 0
