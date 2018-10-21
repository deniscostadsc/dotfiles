#!/bin/bash

kickstart.context 'Languages/Python'

# shellcheck source=recipes/bash.sh
source recipes/bash.sh
# shellcheck source=recipes/git.sh
source recipes/git.sh
# shellcheck source=recipes/python.sh
source recipes/python.sh

kickstart.info "Install Python dependencies"
kickstart.package.install_git

kickstart.package.install_pyenv

kickstart.file.append_file_once \
    files/languages/python/bashrc_python.sh \
    "$MYHOME/.bashrc"
