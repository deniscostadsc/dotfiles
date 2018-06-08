#!/bin/bash

kickstart.context 'Languages/Python'

source recipes/bash.sh
source recipes/git.sh

kickstart.command_exists git || {
    echo "This role depends on Git role"
    exit 1
}

kickstart.package.install_pyenv

kickstart.info "Install python libs"
kickstart.mute pip install -U ipython
kickstart.mute pip install -U flake8
kickstart.mute pip install -U pygments

kickstart.file.append_once ~/.bashrc ""
kickstart.file.append_once ~/.bashrc "# Python - added by kickstart"

kickstart.info "Add pyenv config to bashrc"
# shellcheck disable=SC2016
kickstart.file.append_once ~/.bashrc 'export PYENV_ROOT="$HOME/.pyenv"'
# shellcheck disable=SC2016
kickstart.file.append_once ~/.bashrc 'export PATH="$PYENV_ROOT/bin:$PATH"'
# shellcheck disable=SC2016
kickstart.file.append_once ~/.bashrc 'eval "$(pyenv init -)"'

kickstart.info "Add functions to bashrc"
kickstart.file.append_once ~/.bashrc 'function rmpyc {
    find . -name "*.pyc" -delete;
}'
