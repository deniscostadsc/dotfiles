#!/bin/bash

function exiting(){
    echo "Finalizing program..."
    echo $1
    exit
}

[ "$USER" != root ] && exiting "You are not root!"

apt-get install -y ack-grep; echo -e '\n\n'
apt-get install -y git; echo -e '\n\n'
apt-get install -y python-pip; echo -e '\n\n'
apt-get install -y ruby; echo -e '\n\n'
apt-get install -y terminator; echo -e '\n\n'
apt-get install -y vim-gnome; echo -e '\n\n'
apt-get install -y virtualbox; echo -e '\n\n'

if which pip > /dev/null; then
    pip install virtualenvwrapper
    pip install ipython
fi

