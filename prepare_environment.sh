#!/bin/bash

[ "$USER" != root ] && echo "You are not root!" && exit

add-apt-repository -y ppa:webupd8team/sublime-text-3

apt-get update && apt-get -y upgrade

apt-get install -y ack-grep
apt-get install -y chromium-browser
apt-get install -y curl
apt-get install -y gcolor2
apt-get install -y gimp
apt-get install -y git
apt-get install -y gitg
apt-get install -y gummi
apt-get install -y inkscape
apt-get install -y lua5.1
apt-get install -y nodejs
apt-get install -y npm
apt-get install -y openjdk-6-jdk
apt-get install -y python-dev
apt-get install -y python-setuptools
apt-get install -y ruby
apt-get install -y ruby-dev
apt-get install -y rubygems
apt-get install -y siege
apt-get install -y sqlitebrowser
apt-get install -y sublime-text-installer
apt-get install -y terminator
apt-get install -y vagrant
apt-get install -y vim-gnome
apt-get install -y virtualbox

if which easy_install > /dev/null; then
    easy_install pip
fi

if which pip > /dev/null; then
    pip install ipython
    pip install flake8
    pip install virtualenvwrapper
fi

if which gem > /dev/null; then
    gem install mkrf
fi
