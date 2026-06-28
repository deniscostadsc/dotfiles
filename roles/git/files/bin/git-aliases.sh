#!/usr/bin/env bash

set -euo pipefail

config_file="${HOME}/.gitconfig"
max_length=0
aliases_list=()

while read -r full_alias _; do
    alias_name="${full_alias//alias./}"
    aliases_list+=("${alias_name}")
    length=${#alias_name}
    if ((length > max_length)); then
        max_length=${length}
    fi
done < <(git config --get-regexp '^alias\.' || true)

padding=$((max_length))

git config --get-regexp '^alias\.' | while read -r full_alias _; do
    alias_name="${full_alias//alias./}"
    alias_line_number=$(grep -n "^[[:space:]]*${alias_name}[[:space:]]*=" "${config_file}" | cut -d: -f1)

    if [[ -n "${alias_line_number}" ]]; then
        alias_description=""
        alias_description_line_number=$((alias_line_number - 1))

        current_line=$(sed "${alias_description_line_number}q;d" "${config_file}")
        if [[ ${current_line} =~ ^[[:space:]]*# ]]; then
            # shellcheck disable=SC2001
            alias_description=$(echo "${current_line}" | sed 's/^[[:space:]]*#[[:space:]]*//')
        fi

        printf "%-${padding}s - %s\n" "${alias_name}" "${alias_description:-No description}"
    fi
done
