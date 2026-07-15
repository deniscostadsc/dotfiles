#!/usr/bin/env bash

set -euo pipefail

ROOT_FOLDER="${HOME}/.pr-description/"

mkdir -p "${ROOT_FOLDER}"

current_branch=$(git current-branch)
current_filename="${current_branch//dcosta\//}"

echo "${ROOT_FOLDER}${current_filename}.md"
