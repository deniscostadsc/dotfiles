#!/usr/bin/env bash

git_root_dir="$(git rev-parse --absolute-git-dir)"

cd "$(dirname "${git_root_dir}")" || exit 1

staged_secrets_diff=$(git diff --staged secrets.enc)

echo

if grep '[a-z]\+: ' <(echo "${staged_secrets_diff}"); then
    echo
    echo 'Make sure you will not commit decrypted version of secrecrets.enc'
    echo

    exit 1
fi
