#!/bin/bash

kickstart.context 'Bash'

source recipes/bash.sh

kickstart.info "Copy rcfiles to home folder"
cp --preserve=mode,ownership files/bash/bashrc.sh ~/.bashrc
cp --preserve=mode,ownership files/bash/bash_profile.sh ~/.bash_profile

kickstart.file.append_all_bashrc_files

kickstart.info "Create ~/.bin folder if does not exist"
kickstart.mute mkdir ~/.bin || true

kickstart.info "Copy bin files to bin folder"
cp --preserve=mode,ownership files/bash/bin/beep.sh ~/.bin/beep
cp --preserve=mode,ownership files/bash/bin/colorize-code.sh ~/.bin/colorize-code
cp --preserve=mode,ownership files/bash/bin/colors.sh ~/.bin/colors
cp --preserve=mode,ownership files/bash/bin/diceware.sh ~/.bin/diceware
cp --preserve=mode,ownership files/bash/bin/screencast.sh ~/.bin/screencast
cp --preserve=mode,ownership files/bash/bin/trim.sh ~/.bin/trim
