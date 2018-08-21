#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")" || exit 1

# shellcheck disable=SC1091
source recipes/kickstart.sh
# shellcheck disable=SC1091
source recipes/os.sh

[ -f /etc/redhat-release ] && generic_install which
if ! command -v kickstart > /dev/null; then
  echo "kickstart not found on the PATH. Installing kickstart temporarily..."
  install_temporarily_kickstart
fi

cp _install.sh install.sh
echo "export MYUSER=$USER" >> install.sh
echo "export MYHOME=$HOME" >> install.sh

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
rm -rf install.sh
