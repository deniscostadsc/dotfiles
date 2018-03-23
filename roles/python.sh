#!/bin/bash

kickstart.context 'Python'

source recipes/git.sh

kickstart.command_exists git || {
    echo "This role depends on Git role"
    exit 1
}

kickstart.git.cloneandpull https://github.com/pyenv/pyenv.git ~/.pyenv
kickstart.git.cloneandpull https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

# shellcheck source=/dev/null
source ~/.bashrc

kickstart.info "Install python libs"
kickstart.mute pip install ipython
kickstart.mute pip install flake8
kickstart.mute pip install pygments
kickstart.mute pip install gitlint

{
echo
echo "# Python - added by kickstart"
} >> ~/.bashrc

kickstart.info "Add pyenv config to bashrc"
{
# shellcheck disable=SC2016
echo 'export PYENV_ROOT="$HOME/.pyenv"'
# shellcheck disable=SC2016
echo 'export PATH="$PYENV_ROOT/bin:$PATH"'
# shellcheck disable=SC2016
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi'
} >> ~/.bashrc

kickstart.info "Add functions to bashrc"
echo 'function rmpyc {
    find . -name "*.pyc" -delete;
}' >> ~/.bashrc
