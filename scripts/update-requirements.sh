#!/usr/bin/env bash

set -euo pipefail

requirements_file=$1

pip-compile \
    --upgrade \
    --build-isolation \
    --generate-hashes \
    --strip-extras \
    --cache-dir ./.cache \
    --output-file "${requirements_file%.txt}.lock" "${requirements_file}"
