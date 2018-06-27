#!/bin/bash
set -euo pipefail

cd $(dirname $0) || exit 1

source recipes/kickstart.sh

if ! which kickstart > /dev/null; then
  echo "kickstart not found on the PATH. Installing kickstart temporarily..."
  install_temporarily_kickstart
fi

# bash needs be the first role to be played
kickstart local --sudo \
    bash \
    browsers \
    communication/coyim \
    communication/irssi \
    dev-tools \
    editors/atom \
    editors/neovim \
    git \
    gnupg \
    image-edition-tools \
    kickstart \
    languages/c \
    languages/python \
    languages/ruby \
    os \
    password-managers \
    terminator \
    tmux \
    virtualization

rm -rf compile
