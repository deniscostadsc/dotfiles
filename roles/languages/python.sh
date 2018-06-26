#!/bin/bash

kickstart.context 'Languages/Python'

source recipes/bash.sh
source recipes/git.sh
source recipes/python.sh

kickstart.info "Install git"
kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:git-core/ppa
kickstart.package.update
kickstart.package.install git

kickstart.package.install_pyenv

kickstart.info "Install python libs"
kickstart.mute pip install -U ipython
kickstart.mute pip install -U flake8
kickstart.mute pip install -U pygments

kickstart.file.append_file_once files/languages/python/bashrc_python.sh ~/.bashrc
