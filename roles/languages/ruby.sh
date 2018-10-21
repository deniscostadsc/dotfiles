#!/bin/bash

kickstart.context 'Languages/Ruby'

# shellcheck source=recipes/git.sh
source recipes/git.sh

kickstart.info "Install dependencies"
kickstart.package.install_git
kickstart.package.install gcc
kickstart.package.install make

kickstart.git.cloneandpull https://github.com/rbenv/rbenv.git "$MYHOME/.rbenv"

cd "$MYHOME/.rbenv" || exit 1
src/configure
make -C src
cd - || exit 1

kickstart.file.append_file_once files/languages/ruby/bashrc_ruby.sh "$MYHOME/.bashrc"
