#!/bin/bash

kickstart.context 'Languages/Python'

# shellcheck source=recipes/bash.sh
source recipes/bash.sh
# shellcheck source=recipes/git.sh
source recipes/git.sh
# shellcheck source=recipes/python.sh
source recipes/python.sh

kickstart.info "Install dependencies"
kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:git-core/ppa
kickstart.package.update
kickstart.package.install git

kickstart.package.install_pyenv
export PYENV_ROOT="$MYHOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

kickstart.info "Install python libs"
#kickstart.mute pip install -U ipython
#kickstart.mute pip install -U flake8
#kickstart.mute pip install -U pygments

kickstart.file.append_file_once files/languages/python/bashrc_python.sh "$MYHOME/.bashrc"
