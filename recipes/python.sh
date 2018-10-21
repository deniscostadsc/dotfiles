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
    # the hooks on this repo are not that important and
    # the manupulation on background by ctags was break the build because
    # when chown was running, some files were already deleted.
    rm -rf "$MYHOME"/.pyenv/.git/hooks/*
    rm -rf "$MYHOME"/.pyenv/plugins/pyenv-virtualenv/.git/hooks/*
}
