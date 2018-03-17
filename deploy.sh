#!/bin/bash

if ! which kickstart > /dev/null; then
  echo kickstart not found on the PATH.
  echo installing kickstart temporarily
  source recipes/kickstart.sh
  install_temporarily_kickstart
fi

kickstart local --sudo bash git kickstart neovim
rm -rf compile
