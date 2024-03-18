#!/usr/bin/env bash

set -euo pipefail

if git -C . rev-parse 2> /dev/null; then
    remote_url=$(git remote -v | head -1 | sed 's/.*\t\(.*\) .*/\1/')
    if [[ ${remote_url} != *"work.github.com"* ]]; then
        git remote set-url origin "${remote_url//github.com/work.github.com}"
    else
        git remote set-url origin "${remote_url//work.github.com/github.com}"
    fi
    git remote -v
fi
