#!/bin/bash

source recipes/git.sh
source recipes/bash.sh

kickstart.package.install_pyenv() {
    kickstart.command_exists pyenv || {
        kickstart.git.cloneandpull https://github.com/pyenv/pyenv.git $MYHOME/.pyenv
        kickstart.git.cloneandpull https://github.com/pyenv/pyenv-virtualenv.git $MYHOME/.pyenv/plugins/pyenv-virtualenv

        # shellcheck disable=SC2016
        kickstart.file.append_once $MYHOME/.bashrc 'export PYENV_ROOT="$HOME/.pyenv"'
        # shellcheck disable=SC2016
        kickstart.file.append_once $MYHOME/.bashrc 'export PATH="$PYENV_ROOT/bin:$PATH"'
        # shellcheck disable=SC2016
        kickstart.file.append_once $MYHOME/.bashrc 'eval "$(pyenv init -)"'
    }
}
