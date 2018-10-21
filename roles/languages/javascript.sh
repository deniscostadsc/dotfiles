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
    # the hooks on this repo are not that important and
    # the manupulation on background by ctags was break the build because
    # when chown was running, some files were already deleted.
    rm -rf "$MYHOME"/.nodenv/.git/hooks/*
    rm -rf "$MYHOME"/.nodenv/plugins/node-build/.git/hooks/*
}

kickstart.file.append_file_once files/languages/javascript/bashrc_javascript.sh "$MYHOME/.bashrc"
