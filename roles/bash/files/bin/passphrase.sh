#!/usr/bin/env bash

set -euo pipefail

min_word_length=4
max_word_length=6
password_word_count=5

function show_help {
    echo
    echo "passphrase"
    echo
    echo " --min (-n) sets minimum number of characters in the words"
    echo " --max (-m) sets maximum number of characters in the words"
    echo " --count (-c) sets how many word the password will contain"
    echo " --help (-h) shows help message and exit"
    echo
}

while [[ $# -gt 0 ]]; do
    case $1 in
        --min|-n)
            min_word_length=$2
            shift
        ;;
        --max|-m)
            max_word_length=$2
            if [[ ${max_word_length} -lt ${min_word_length} ]]; then
                echo
                echo "max should be greater than min"
                exit 1
            fi
            shift
        ;;
        --count|-c)
            password_word_count=$2
            shift
        ;;
        --help|-h)
            show_help
            exit 0
        ;;
        *)
            echo
            echo "option not valid"
            exit 1
        ;;
    esac
    shift
done

elegible_words=$(
    grep -E "^[A-Za-z]{${min_word_length},${max_word_length}}$" /usr/share/dict/words | tr '\n' ' ')
word_count=$(wc -w <<< "${elegible_words}")

for ((i = 0; i < "${password_word_count}"; i++)); do
    word_index="$((RANDOM * RANDOM * RANDOM * RANDOM % word_count + 1))"
    word="$(cut -d ' ' -f "${word_index}" <<< "${elegible_words}" | tr '[:upper:]' '[:lower:]')"
    echo -n "${word} "
done

echo
exit 0
