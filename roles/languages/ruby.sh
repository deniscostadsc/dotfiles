#!/bin/bash

kickstart.context 'Languages/Ruby'

source recipes/git.sh

kickstart.command_exists git || {
    echo "This role depends on Git role"
    exit 1
}

kickstart.git.cloneandpull https://github.com/rbenv/rbenv.git $MYHOME/.rbenv

cd $MYHOME/.rbenv || exit 1
src/configure
make -C src
cd - || exit 1

kickstart.file.append_file_once files/languages/ruby/bashrc_ruby.sh $MYHOME/.bashrc
