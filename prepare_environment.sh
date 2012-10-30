#!/bin/bash

[ "$USER" != root ] && echo "You are not root!" && exit

apt-add-repository -y ppa:fkrull/deadsnakes
apt-add-repository -y ppa:webupd8team/sublime-text-2

apt-get update && apt-get -y upgrade

# Databases
apt-get install -y postgresql-9.1 postgresql-client-9.1 postgresql-server-dev-9.1
apt-get install -y pgadmin3
apt-get install -y mysql-server mysql-client
apt-get install -y emma

apt-get install -y ack-grep
apt-get install -y chromium-browser
apt-get install -y curl
apt-get install -y gcolor2
apt-get install -y gimp
apt-get install -y git
apt-get install -y gitg
apt-get install -y inkscape
apt-get install -y lua5.1
apt-get install -y nodejs
apt-get install -y npm
apt-get install -y python-dev
apt-get install -y python-setuptools
apt-get install -y ruby
apt-get install -y rubygems
apt-get install -y siege
apt-get install -y sublime-text
apt-get install -y terminator
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
    gem install heroku
fi

