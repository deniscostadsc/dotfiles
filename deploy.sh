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
    if [[ ! -d ~/.gnupg ]]; then
        echo "You need to restore ~/.gnupg folder in order to verify GPG signatures"
        exit 1
    fi
else
    echo "export NO_GPG_VERIFY=${NO_GPG_VERIFY}" >> install.sh
fi

# bash needs be the first role to be played
kickstart local --sudo \
    bash \
    browsers \
    communication/slack \
    dev-tools \
    editors/atom \
    editors/neovim \
    editors/vscode \
    git \
    gnupg \
    image-edition-tools \
    kickstart \
    languages/javascript \
    languages/python \
    languages/ruby \
    os \
    password-managers \
    spotify \
    terminator \
    tmux \
    video \
    virtualization \
    keybase # https://github.com/keybase/client/issues/6996#issuecomment-430355029
    # dropbox # not yet
    # communication/coyim # old stuff
    # communication/irssi # old stuff
    # languages/c # old stuff

rm -rf compile
rm -rf install.sh
