#!/usr/bin/env bash

git_root_dir="$(git rev-parse --absolute-git-dir)"

cd "$(dirname "${git_root_dir}")" || exit 1

find . -name "*.pyc" -delete
