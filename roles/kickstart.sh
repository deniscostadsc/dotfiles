#!/bin/bash

kickstart.context 'Kickstart'

# shellcheck source=recipes/bash.sh
source recipes/bash.sh
# shellcheck source=recipes/git.sh
source recipes/git.sh

kickstart.info "Install git"
kickstart.package.install_git

kickstart.git.cloneandpull https://github.com/bltavares/kickstart.git "$MYHOME/.kickstart"

kickstart.file.append_file_once files/kickstart/bashrc_kickstart.sh "$MYHOME/.bashrc"
