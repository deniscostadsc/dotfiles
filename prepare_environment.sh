#!/bin/bash

function exiting(){
    echo "Finalizing program..."
    echo $1
    exit
}

[ "$USER" != root ] && exiting "You are not root!"

apt-get install -y ack-grep
apt-get install -y git
apt-get install -y python-pip
apt-get install -y python-dev
apt-get install -y ruby
apt-get install -y rubygems
apt-get install -y terminator
apt-get install -y vim-gnome
apt-get install -y virtualbox

if which pip > /dev/null; then
    pip install virtualenvwrapper
    pip install ipython
fi

if which gem > /dev/null; then
    gem install mkrf
fi
