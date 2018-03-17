#!/bin/bash

. .functions.sh

if [ is_linux ]; then
    [ "$USER" != root ] && echo "You are not root!" && exit


    # Install OS packages
    apt install -y \
        chromium-browser \
        curl \
        tree \
        virtualbox


    # Install atom
    wget https://atom.io/download/deb && dpkg -i deb; rm deb 2> /dev/null

else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
