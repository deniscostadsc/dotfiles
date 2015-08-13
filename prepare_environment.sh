#!/bin/bash

[ "$USER" != root ] && echo "You are not root!" && exit

sudo add-apt-repository ppa:git-core/ppa

apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade

apt-get install -y ack-grep
apt-get install -y chromium-browser
apt-get install -y curl
apt-get install -y gcolor2
apt-get install -y gimp
apt-get install -y git
apt-get install -y gitg
apt-get install -y gummi
apt-get install -y inkscape
apt-get install -y meld
apt-get install -y openjdk-7-jdk
apt-get install -y python-dev
apt-get install -y python-setuptools
apt-get install -y ruby2.0
apt-get install -y sqlitebrowser
apt-get install -y terminator
apt-get install -y tree
apt-get install -y vim-gnome
apt-get install -y virtualbox

easy_install pip

pip install ipython
pip install flake8
pip install virtualenvwrapper

wget https://atom.io/download/deb
dpkg -i deb
rm deb

apt-get -y autoclean && apt-get -y autoremove
