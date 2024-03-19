#!/usr/bin/env bash

git_root_dir=$(git rev-parse --show-toplevel)

if ! compgen -G "${git_root_dir}"/.git/hooks/post-checkout-* > /dev/null; then
    exit 0
fi

for hook in "${git_root_dir}"/.git/hooks/post-checkout-*; do
    if ! "${hook}"; then
        exit 1
    fi
done

exit 0
