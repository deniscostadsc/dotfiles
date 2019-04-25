#!/bin/bash

kickstart.context 'Languages/Ruby'

# shellcheck source=recipes/git.sh
source recipes/git.sh

kickstart.info "Install dependencies"
kickstart.package.install_git
kickstart.package.install gcc
kickstart.package.install make

kickstart.git.cloneandpull https://github.com/rbenv/rbenv.git "$MYHOME/.rbenv"
# the hooks on this repo are not that important and
# the manupulation on background by ctags was break the build because
# when chown was running, some files were already deleted.
kickstart.mute rm -rf "$MYHOME"/.rbenv/.git/hooks/*

kickstart.mute cd "$MYHOME/.rbenv" || exit 1
kickstart.mute src/configure
kickstart.mute make -C src
kickstart.mute cd - || exit 1

kickstart.file.append_file_once files/languages/ruby/bashrc_ruby.sh "$MYHOME/.bashrc"
