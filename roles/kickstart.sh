#!/bin/bash

kickstart.context 'Kickstart'

source recipes/git.sh

kickstart.command_exists git || {
    echo "This role depends on Git role"
    exit 1
}

kickstart.git.cloneandpull https://github.com/bltavares/kickstart.git ~/.kickstart

echo >> ~/.bashrc
echo "# Kickstart - added by kickstart" >> ~/.bashrc

kickstart.info "Add code complete to bash"
# shellcheck disable=SC2016
echo 'eval "$(kickstart autocomplete)"' >> ~/.bashrc

kickstart.info "Create kickstart bin link"
kickstart.file.link ~/.kickstart/bin/kickstart ~/.bin/kickstart
