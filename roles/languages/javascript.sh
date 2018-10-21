#!/bin/bash

kickstart.context 'Languages/Javascript'

kickstart.info "Install Javascript dependencies"
kickstart.package.install_git

kickstart.command_exists pyenv || {
    kickstart.git.cloneandpull \
        https://github.com/nodenv/nodenv.git \
        "$MYHOME/.nodenv"
    kickstart.git.cloneandpull \
        https://github.com/nodenv/node-build.git \
        "$MYHOME/.nodenv/plugins/node-build"
}

kickstart.file.append_file_once files/languages/javascript/bashrc_javascript.sh "$MYHOME/.bashrc"
