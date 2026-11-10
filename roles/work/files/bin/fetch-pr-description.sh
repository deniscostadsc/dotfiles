#!/usr/bin/env bash

set -euo pipefail

description_file=$(current-ticket-pr-decription-file)

# Cleanup: remove description files not modified in over 30 days
find "${HOME}/.pr-description" -name "*.md" -mtime +30 -delete 2>/dev/null || true

[[ -f "${description_file}" ]] && exit 0

if gh pr view --json number &>/dev/null; then
    gh pr view --json body --jq '.body' >"${description_file}"
else
    cp "$(git rev-parse --show-toplevel)/.github/PULL_REQUEST_TEMPLATE.md" "${description_file}"
fi
