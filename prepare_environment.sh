#!/bin/bash

function exiting(){
    echo "Finalizing program..."
    echo $1
    exit
}

function is_installed(){
    app=$1
    dpkg -l $app > /dev/null 2> /dev/null && return 0
    which $app > /dev/null && return 0
    return 1
}

function install(){
    app=$1
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

echo "This program will install these systems applications:"
echo
echo "$apps"

read -p "Do you want to continue? (y/n) "

if [[ $REPLY =~ ^[yY] ]]; then
    for app in $apps; do
        if is_installed $app; then
            echo "$app already installed."
        else
            install $app
        fi
    done
fi
