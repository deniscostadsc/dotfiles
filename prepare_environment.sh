#!/bin/bash

[ "$USER" != root ] && echo "You are not root!" && exit

apt-add-repository -y ppa:webupd8team/sublime-text-2

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
apt-get install -y siege
apt-get install -y sqlitebrowser
apt-get install -y sublime-text
apt-get install -y terminator
apt-get install -y vim-gnome
apt-get install -y virtualbox

easy_install pip

pip install ipython
pip install flake8
pip install virtualenvwrapper
