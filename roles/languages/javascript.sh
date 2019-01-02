#!/bin/bash

kickstart.context 'Languages/Javascript'

kickstart.info "Install Javascript dependencies"
kickstart.package.install_git

# gupy stack dependencies
kickstart.package.install libpq-dev
kickstart.package.install g++
kickstart.package.install make

kickstart.command_exists nvm || {
    kickstart.git.cloneandpull \
        https://github.com/creationix/nvm.git \
        "$MYHOME/.nvm"

    # the hooks on this repo are not that important and
    # the manupulation on background by ctags was break the build because
    # when chown was running, some files were already deleted.
    rm -rf "$MYHOME"/.nvm/.git/hooks/*

    cd "$MYHOME/.nvm" || exit 1

    git rev-list --tags --max-count=1
    git checkout \
        "$(git describe --abbrev=0 --tags --match "v[0-9]*" 93990ab7da37007c8d9db16415cfb939aa5dd201)"
        #"$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")"
    cd - || exit 1
}

kickstart.file.append_file_once files/languages/javascript/bashrc_javascript.sh "$MYHOME/.bashrc"
