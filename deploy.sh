#!/bin/bash

if ! which kickstart > /dev/null; then
  echo kickstart not found on the PATH.
  echo installing kickstart temporarily
  source recipes/kickstart.sh
  install_temporarily_kickstart
fi

# bash needs be the first
# git needs to be the second
kickstart local --sudo \
    bash \
    browsers \
    dev-tools \
    editors \
    git \
    gnupg \
    image-edition-tools \
    kickstart \
    os \
    python \
    ruby \
    terminator \
    tmux

rm -rf compile

# I run the whole deploy as sudo
# To fix ownership of files this is needed
find . -group root | xargs sudo chown -R denis:denis
