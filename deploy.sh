#!/bin/bash

source recipes/kickstart.sh

if ! which kickstart > /dev/null; then
  echo "kickstart not found on the PATH. Installing kickstart temporarily..."
  install_temporarily_kickstart
fi

# bash needs be the first role to be played
kickstart local --sudo \
    bash \
    browsers \
    communication/irc \
    dev-tools \
    editors/atom \
    editors/neovim \
    git \
    gnupg \
    image-edition-tools \
    kickstart \
    os \
    python \
    ruby \
    terminator \
    tmux \
    virtualization

rm -rf compile
