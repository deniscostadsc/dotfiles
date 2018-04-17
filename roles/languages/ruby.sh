#!/bin/bash

kickstart.context 'Ruby'

source recipes/git.sh

kickstart.command_exists git || {
    echo "This role depends on Git role"
    exit 1
}

kickstart.git.cloneandpull https://github.com/rbenv/rbenv.git ~/.rbenv

cd ~/.rbenv || exit 1
src/configure
make -C src
cd - || exit 1

echo >> ~/.bashrc
echo "# Ruby - added by kickstart" >> ~/.bashrc

kickstart.info "Add rbenv config to bashrc"
# shellcheck disable=SC2016
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
# shellcheck disable=SC2016
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
