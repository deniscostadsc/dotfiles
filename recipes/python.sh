#!/bin/bash

kickstart.package.install_pyenv() {
    kickstart.command_exists pyenv || {
        kickstart.git.cloneandpull https://github.com/pyenv/pyenv.git ~/.pyenv
        kickstart.git.cloneandpull https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
        # shellcheck disable=SC2016
        kickstart.file.append_once ~/.bashrc 'export PYENV_ROOT="$HOME/.pyenv"'
        # shellcheck disable=SC2016
        kickstart.file.append_once ~/.bashrc 'export PATH="$PYENV_ROOT/bin:$PATH"'
        # shellcheck disable=SC2016
        kickstart.file.append_once ~/.bashrc 'eval "$(pyenv init -)"'

        # shellcheck disable=SC1090
        source ~/.bashrc
    }
}
