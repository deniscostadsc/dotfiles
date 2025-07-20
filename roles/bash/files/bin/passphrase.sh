#!/usr/bin/env bash

set -euo pipefail

DEFAULT_MIN_WORD_LENGTH=4
DEFAULT_MAX_WORD_LENGTH=6
DEFAULT_PASSPHRASE_WORD_COUNT=5

min_word_length=${DEFAULT_MIN_WORD_LENGTH}
max_word_length=${DEFAULT_MAX_WORD_LENGTH}
passphrase_word_count=${DEFAULT_PASSPHRASE_WORD_COUNT}

have_min_word_arg=0
have_max_word_arg=0

function show_help {
    echo
    echo "passphrase"
    echo
    echo " --min (-n) sets minimum number of characters in the words"
    echo " --max (-m) sets maximum number of characters in the words"
    echo " --count (-c) sets how many word the passphrase will contain"
    echo " --help (-h) shows help message and exit"
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
        have_min_word_arg=1
        shift
        ;;
    --max | -m)
        if [[ -z "${2:-}" ]]; then
            echo "Invalid option"
            exit 1
        fi
        max_word_length=$2
        have_max_word_arg=1
        shift
        ;;
    --count | -c)
        if [[ -z "${2:-}" ]]; then
            echo "Invalid option"
            exit 1
        fi
        passphrase_word_count=$2
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

validate_range "${min_word_length}" 1 100 "Min word length"
validate_range "${max_word_length}" 1 100 "Max word length"
validate_range "${passphrase_word_count}" 0 1000 "Word count"

if [[ ${have_min_word_arg} -eq 1 ]] && [[ ${have_max_word_arg} -eq 1 ]]; then
    if [[ ${max_word_length} -lt ${min_word_length} ]]; then
        echo "Max should be greater than min"
        exit 1
    fi
fi

set +e
if [[ ${have_min_word_arg} -eq ${have_max_word_arg} ]]; then
    elegible_words=$(
        grep -E "^[A-Za-z]{${min_word_length},${max_word_length}}$" /usr/share/dict/words | tr '\n' ' '
    )
elif [[ ${have_min_word_arg} -eq 1 ]]; then
    elegible_words=$(
        grep -E "^[A-Za-z]{${min_word_length},}$" /usr/share/dict/words | tr '\n' ' '
    )
else
    elegible_words=$(
        grep -E "^[A-Za-z]{0,${max_word_length}}$" /usr/share/dict/words | tr '\n' ' '
    )
fi
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

    if [[ $i -lt $((passphrase_word_count - 1)) ]]; then
        echo -n "${word} "
    else
        echo "${word}"
    fi
done

exit 0
