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

kickstart.file.append_once ~/.bashrc ""
kickstart.file.append_once ~/.bashrc "# Ruby - added by kickstart"

kickstart.info "Add rbenv config to bashrc"
# shellcheck disable=SC2016
kickstart.file.append_once ~/.bashrc 'export PATH="$HOME/.rbenv/bin:$PATH"'
# shellcheck disable=SC2016
kickstart.file.append_once ~/.bashrc 'eval "$(rbenv init -)"'
