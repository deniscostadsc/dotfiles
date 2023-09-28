#!/usr/bin/env bash

set -euo pipefail

pip-compile \
    --upgrade \
    --build-isolation \
    --generate-hashes \
    --cache-dir ./.cache \
    --output-file .docker/lint-ansible-requirements.lock .docker/lint-ansible-requirements.txt
