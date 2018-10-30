#!/bin/bash

_generic_install() {
    if command -v brew > /dev/null 2>&1; then
        brew install -y "$@"
        return 0;
    fi
    if command -v apt > /dev/null 2>&1; then
        sudo apt install -y "$@"
        return 0;
    fi
    if command -v yum > /dev/null 2>&1; then
        yum install -y "$@"
        return 0;
    fi
    if command -v pacman > /dev/null 2>&1; then
        pacman -S --noconfirm "$@"
        return 0;
    fi
    return 1;
}

_generic_update() {
    if command -v brew > /dev/null 2>&1; then
        brew update -y
        return 0;
    fi
    if command -v apt > /dev/null 2>&1; then
        sudo apt update
        return 0;
    fi
    if command -v yum > /dev/null 2>&1; then
        yum update -y
        return 0;
    fi
    if command -v pacman > /dev/null 2>&1; then
        pacman -Sy --noconfirm
        return 0;
    fi
    return 1;
}

kickstart.file.copy() {
    if kickstart.os.is "Mac"; then
        cp -p "$@"
    else
        cp --preserve=mode,ownership "$@"
    fi
}

kickstart.file.mkdir_and_chown() {
    kickstart.mute mkdir -p "$1" || true
    if kickstart.os.is "Mac"; then
        kickstart.mute chown -R "$MYUSER" "$1"
    else
        kickstart.mute chown "$MYUSER:$MYUSER" -R "$1"
    fi
}
