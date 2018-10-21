#!/bin/bash

# shellcheck source=recipes/git.sh
source recipes/git.sh
# shellcheck source=recipes/bash.sh
source recipes/bash.sh

kickstart.package.install_pyenv() {
    kickstart.command_exists pyenv || {
        kickstart.git.cloneandpull \
            https://github.com/pyenv/pyenv.git \
            "$MYHOME/.pyenv"
        kickstart.git.cloneandpull \
            https://github.com/pyenv/pyenv-virtualenv.git \
            "$MYHOME/.pyenv/plugins/pyenv-virtualenv"
    }
}
