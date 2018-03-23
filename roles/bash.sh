#!/bin/bash

kickstart.context 'Bash'

kickstart.info "Copy rcfiles to home folder"
cp --preserve=mode,ownership files/bash/bashrc ~/.bashrc
cp --preserve=mode,ownership files/bash/bash_profile ~/.bash_profile

kickstart.info "Create ~/.bin folder if does not exist"
kickstart.mute mkdir ~/.bin || true

kickstart.info "Copy bin files to bin folder"
cp --preserve=mode,ownership files/bash/bin/* ~/.bin

echo >> ~/.bashrc
echo "# Bash - added by kickstart" >> ~/.bashrc

kickstart.info "Add aliases to bashrc"
{
echo "alias ll='ls -alhF'"
echo "alias grep='grep --color=auto'"
echo "alias fgrep='fgrep --color=auto'"
echo "alias egrep='egrep --color=auto'"
kickstart.os.is "Ubuntu" && echo "alias ls='ls --color=auto'"
} >> ~/.bashrc

kickstart.info "Add functions to bashrc"
# shellcheck disable=SC2016
echo 'function mkcd {
    mkdir -p $1 && cd $1
}' >> ~/.bashrc
