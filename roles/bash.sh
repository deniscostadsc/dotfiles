#!/bin/bash

kickstart.context 'Bash'

source recipes/bash.sh

kickstart.info "Copy rcfiles to home folder"
cp --preserve=mode,ownership files/bash/bashrc ~/.bashrc
cp --preserve=mode,ownership files/bash/bash_profile ~/.bash_profile

kickstart.info "Create ~/.bin folder if does not exist"
kickstart.mute mkdir ~/.bin || true

kickstart.info "Copy bin files to bin folder"
cp --preserve=mode,ownership files/bash/bin/beep.sh ~/.bin/beep
cp --preserve=mode,ownership files/bash/bin/colorize-code.sh ~/.bin/colorize-code
cp --preserve=mode,ownership files/bash/bin/colors.sh ~/.bin/colors
cp --preserve=mode,ownership files/bash/bin/diceware.sh ~/.bin/diceware
cp --preserve=mode,ownership files/bash/bin/screencast.sh ~/.bin/screencast
cp --preserve=mode,ownership files/bash/bin/trim.sh ~/.bin/trim

kickstart.file.append_once ~/.bashrc ""
kickstart.file.append_once ~/.bashrc "# Bash - added by kickstart"

kickstart.info "Add aliases to bashrc"
kickstart.file.append_once ~/.bashrc "alias ll='ls -alhF'"
kickstart.file.append_once ~/.bashrc "alias grep='grep --color=auto'"
kickstart.file.append_once ~/.bashrc "alias fgrep='fgrep --color=auto'"
kickstart.file.append_once ~/.bashrc "alias egrep='egrep --color=auto'"
kickstart.os.is "Ubuntu" && \
    kickstart.file.append_once ~/.bashrc "alias ls='ls --color=auto'"

kickstart.info "Add functions to bashrc"
# shellcheck disable=SC2016
kickstart.file.append_once ~/.bashrc 'function mkcd {
    mkdir -p $1 && cd $1
}'
