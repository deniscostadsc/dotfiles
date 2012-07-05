#!/bin/bash

function exiting(){
    echo "Finalizing program..."
    echo $1
    exit
}

function installing(){
    app=$1
    dpkg -l $app > /dev/null 2> /dev/null || \
        ( echo "Installing $app" && \
            apt-get install -y $app > /dev/null 2> /dev/null && \
            echo "Installed $app" ) || \
        echo "Error in $app instalation."
}

[ "$USER" != root ] && exiting "You are not root!"

apps='python-pip
terminator
vim-gnome
'

echo "This program will install these applications:"
echo
echo "$apps"

read -p "Do you want to continue? (y/n)"

if [[ $REPLY =~ ^[yY] ]]; then
    for app in $apps; do
        installing $app
    done
fi

