#!/bin/bash

[ "$USER" != root ] && echo "You are not root!" && exit

if ! grep "deadsnakes" /etc/apt/sources.list > /dev/null; then
    echo "" >> /etc/apt/sources.list
    echo "# A few versions of Python" >> /etc/apt/sources.list
    echo "deb http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu $(grep 'DISTRIB_CODENAME' /etc/lsb-release | sed 's/^[^\=]\+=//') main" >> /etc/apt/sources.list
    echo "deb-src http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu $(grep 'DISTRIB_CODENAME' /etc/lsb-release | sed 's/^[^\=]\+=//') main " >> /etc/apt/sources.list
fi

apt-get update

apt-get install -y ack-grep
apt-get install -y git
apt-get install -y gitg
apt-get install -y nodejs
apt-get install -y python-dev
apt-get install -y python-setuptools
apt-get install -y ruby
apt-get install -y rubygems
apt-get install -y terminator
apt-get install -y vim-gnome
apt-get install -y virtualbox

if which easy_install > /dev/null; then
    easy_install pip
fi

if which pip > /dev/null; then
    pip install ipython
    pip install pep8
    pip install virtualenvwrapper
fi

if which gem > /dev/null; then
    gem install mkrf
fi
