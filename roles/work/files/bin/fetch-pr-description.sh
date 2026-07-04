#!/usr/bin/env bash

set -euo pipefail

description_file=$(current-ticket-pr-decription-file)

[[ -f "${description_file}" ]] && exit 0

if gh pr view --json number &>/dev/null; then
    gh pr view --json body --jq '.body' >"${description_file}"
else
    cp "$(git rev-parse --show-toplevel)/.github/PULL_REQUEST_TEMPLATE.md" "${description_file}"
fi
