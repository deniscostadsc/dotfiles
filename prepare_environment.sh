#!/bin/bash

. .functions.sh

if [ is_linux ]; then
    [ "$USER" != root ] && echo "You are not root!" && exit

    sudo add-apt-repository ppa:git-core/ppa

    apt update && apt -y upgrade

    apt-get install -y \
        ack-grep \
        chromium-browser \
        curl \
        gcolor2 \
        gimp \
        git \
        gitg \
        inkscape \
        meld \
        python-dev \
        python-setuptools \
        sqlitebrowser \
        terminator \
        tree \
        virtualbox

    easy_install pip

    pip install ipython
    pip install flake8
    pip install virtualenvwrapper
    pip install pygments
    pip install gitlint

    wget https://atom.io/download/deb && dpkg -i deb && rm deb

    apt-get -y autoclean && apt-get -y autoremove
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
