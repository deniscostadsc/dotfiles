#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")" || exit 1

# shellcheck source=recipes/kickstart.sh
source recipes/kickstart.sh
# shellcheck source=recipes/os.sh
source recipes/os.sh

[ -f /etc/redhat-release ] && generic_install which
if ! command -v kickstart > /dev/null; then
  echo "kickstart not found on the PATH. Installing kickstart temporarily..."
  install_temporarily_kickstart
fi

cp _install.sh install.sh
echo "export MYUSER=$USER" >> install.sh
echo "export MYHOME=$HOME" >> install.sh
if [ -z "${NO_GPG_VERIFY:-}" ]; then
    echo "export NO_GPG_VERIFY=0" >> install.sh
else
    echo "export NO_GPG_VERIFY=${NO_GPG_VERIFY}" >> install.sh
fi

# bash needs be the first role to be played
kickstart local --sudo \
    bash \
    browsers \
    dev-tools \
    editors/atom \
    editors/neovim \
    git \
    gnupg \
    image-edition-tools \
    kickstart \
    languages/javascript \
    languages/python \
    languages/ruby \
    os \
    password-managers \
    terminator \
    tmux \
    video \
    virtualization \
    keybase # https://github.com/keybase/client/issues/6996#issuecomment-430355029
    # communication/coyim # old stuff
    # communication/irssi # old stuff
    # languages/c # old stuff

rm -rf compile
rm -rf install.sh
