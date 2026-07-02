#!/usr/bin/env bash

set -euo pipefail

ROOT_FOLDER="${HOME}/.pr-description/"

mkdir -p "${ROOT_FOLDER}"

current_ticket_code=$(current-ticket)

echo "${ROOT_FOLDER}${current_ticket_code}.md"
