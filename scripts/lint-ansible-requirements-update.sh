#!/usr/bin/env bash

set -euo pipefail

pip-compile \
    --upgrade \
    --build-isolation \
    --generate-hashes \
    --strip-extras \
    --cache-dir ./.cache \
    --output-file .docker/lint-ansible-requirements.lock .docker/lint-ansible-requirements.txt
