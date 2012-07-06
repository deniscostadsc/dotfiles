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
    grep $app <<< $(pip freeze 2> /dev/null) > /dev/null 2>&1 && return 0
    return 1
}

function __install(){
    app=$2
    case $1 in
        r|ruby)
            ( gem install $app && return 0 ) || return 1
        ;;
        p|python)
            ( pip install $app && return 0 ) || return 1
        ;;
        s|system)
            ( apt-get install -y $app && return 0 ) || return 1
        ;;
    esac
}

function _install(){
    app=$2
    typeapp=$1
    ( echo -e "Installing $app\n\n" && \
         __install $typeapp $app && \
        echo -e "\n\nInstalled $app" ) || \
    echo "Error in $app instalation."
}

function install(){
    typeapp=$1
    apps=$2
    echo "This program will install these $typeapp applications:"
    echo
    echo "$apps"

    read -p "Do you want to continue? (y/n) "

    if [[ $REPLY =~ ^[yY] ]]; then
        for app in $apps; do
            if is_installed $app; then
                echo "$app already installed."
            else
                _install $typeapp $app
            fi
        done
    fi
}

[ "$USER" != root ] && exiting "You are not root!"

apps='ack
ack-grep
git
python-pip
ruby
rubygems
terminator
vim-gnome
virtualbox
'
typeapp="system"

install "$typeapp" "$apps"

apps='virtualenvwrapper
ipython'
typeapp='python'

install "$typeapp" "$apps"

