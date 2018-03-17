#!/bin/bash

. .functions.sh

if [ is_linux ]; then
    [ "$USER" != root ] && echo "You are not root!" && exit

    apt update && apt -y upgrade

    # Install OS packages
    apt install -y \
        chromium-browser \
        curl \
        gcolor2 \
        gimp \
        inkscape \
        meld \
        python-dev \
        python-setuptools \
        terminator \
        tree \
        virtualbox

    apt -y autoclean && apt -y autoremove

    # Install development tools with
    [ ! -d ~/projects/ ] && mkdir ~/projects
    [ ! -d ~/projects/pyenv ] && \
        git clone https://github.com/pyenv/pyenv.git ~/projects/pyenv
    [ ! -d ~/projects/pyenv/plugins/ ] && mkdir ~/projects/pyenv/plugins/
    [ ! -d ~/projects/pyenv/plugins/pyenv-virtualenv ] && \
        git clone https://github.com/pyenv/pyenv-virtualenv.git ~/projects/pyenv/plugins/pyenv-virtualenv

    # Install Python libraries
    pip install ipython
    pip install flake8
    pip install pygments
    pip install gitlint

    # Install atom
    wget https://atom.io/download/deb && dpkg -i deb; rm deb 2> /dev/null

else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
