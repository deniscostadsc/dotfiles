#!/bin/bash

kickstart.context 'Git'

# shellcheck source=recipes/bash.sh
source recipes/bash.sh
# shellcheck source=recipes/os.sh
source recipes/os.sh
# shellcheck source=recipes/python.sh
source recipes/python.sh

kickstart.info "Install git and git tools"
kickstart.package.install gitg
kickstart.package.install meld
kickstart.package.install tig
kickstart.package.install_git

kickstart.info "Copy git config files"
kickstart.file.mkdir_and_chown "$MYHOME/.config/git/"
kickstart.file.copy files/git/globalignore "$MYHOME/.config/git/ignore"
kickstart.file.copy files/git/commit_message_template "$MYHOME/.config/git/commit_message_template"
kickstart.file.copy files/git/gitconfig "$MYHOME/.gitconfig"

kickstart.info "Copy hook to git template folder"
kickstart.file.mkdir_and_chown "$MYHOME/.git_template/hooks"
rm -rf "$MYHOME"/.git_template/hooks/*
kickstart.file.copy files/git/hooks/* "$MYHOME/.git_template/hooks/"

kickstart.file.append_file_once files/git/bashrc_git.sh "$MYHOME/.bashrc"
