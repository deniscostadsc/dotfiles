#!/bin/bash

cd "$(dirname "$0")"

function install() {
    rsync \
        --exclude ".git/" \
        --exclude ".gitignore" \
        --exclude "README.md" \
        --exclude "prepare_environment.sh" \
        --exclude "*.swp" \
        --exclude "*~" \
        -av . ~
}

if [[ $1 =~ ^(-f|--force)$ ]]; then
    install
else
    read -p "Running this file, you'll override some config files. Do you want to continue? (y/n) "

    if [[ $REPLY =~ ^[yY]$ ]]; then
        install
    fi
fi
