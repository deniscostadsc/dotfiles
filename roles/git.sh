#!/bin/bash

kickstart.context 'Git'

# shellcheck source=recipes/bash.sh
source recipes/bash.sh
# shellcheck source=recipes/python.sh
source recipes/python.sh

kickstart.info "Install git and git tools"
kickstart.package.install_git
kickstart.package.install gitg
kickstart.package.install meld

kickstart.package.install_pyenv
#export PYENV_ROOT="$MYHOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

kickstart.info "Copy git config files"
kickstart.file.mkdir_and_chown "$MYHOME/.config/git/"
cp --preserve=mode,ownership files/git/globalignore "$MYHOME/.config/git/ignore"
cp --preserve=mode,ownership files/git/commit_message_template "$MYHOME/.config/git/commit_message_template"
cp --preserve=mode,ownership files/git/gitconfig "$MYHOME/.gitconfig"

kickstart.info "Copy hook to git template folder"
kickstart.file.mkdir_and_chown "$MYHOME/.git_template/hooks"
rm -rf "$MYHOME"/.git_template/hooks/*
cp --preserve=mode,ownership files/git/hooks/* "$MYHOME/.git_template/hooks/"

kickstart.file.append_file_once files/git/bashrc_git.sh "$MYHOME/.bashrc"
