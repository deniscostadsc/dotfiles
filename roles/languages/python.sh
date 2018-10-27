#!/bin/bash

kickstart.context 'Languages/Python'

# shellcheck source=recipes/bash.sh
source recipes/bash.sh
# shellcheck source=recipes/git.sh
source recipes/git.sh
# shellcheck source=recipes/python.sh
source recipes/python.sh

kickstart.info "Install dependencies"
kickstart.package.install libbz2-dev
kickstart.package.install libreadline-dev
kickstart.package.install libsqlite3-dev
kickstart.package.install libssl-dev
kickstart.package.install zlib1g-dev
kickstart.package.install_git

kickstart.info "Install Pydev"
kickstart.package.install_pyenv

kickstart.info "Copy Python config to bashrc"
kickstart.file.append_file_once \
    files/languages/python/bashrc_python.sh \
    "$MYHOME/.bashrc"

kickstart.info "Install Pip"
kickstart.package.install python-pip

kickstart.info "Install Global Python libraries"
kickstart.mute pip install flake8
