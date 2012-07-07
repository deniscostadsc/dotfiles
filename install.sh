#!/bin/bash

cd "$(dirname "$0")"

function install() {
    rsync \
        --exclude ".git/" \
        --exclude ".gitignore" \
        --exclude "install.sh" \
        --exclude "README.md" \
        --exclude "prepare_environment.sh" \
        --exclude "*.swp" \
        --exclude "*~" \
        -av . ~

    # Compile C extension for Command-T
    if [ -d ~/.vim/bundle/command-t/ruby/command-t -a ! -f ~/.vim/bundle/command-t/ruby/command-t/ext.so ]; then
        cd ~/.vim/bundle/command-t/ruby/command-t
        ruby extconf.rb
        make
    fi
}

if [[ $1 =~ ^-f|--force$ ]]; then
    install
else
    read -p "Running this file, you'll override some config files. Do you want to continue? (y/n) "
    
    if [[ $REPLY =~ ^[yY] ]]; then
    	install	
    fi
fi
