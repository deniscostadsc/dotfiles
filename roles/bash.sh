#!/bin/bash

kickstart.context 'Bash'

# shellcheck disable=SC1091
source recipes/bash.sh

kickstart.info "Copy rcfiles to home folder"
cp --preserve=mode,ownership files/bash/bashrc.sh $HOME/.bashrc
cp --preserve=mode,ownership files/bash/bash_profile.sh $HOME/.bash_profile

kickstart.file.append_all_bashrc_files

kickstart.info "Create $HOME/.bin folder if does not exist"
kickstart.file.mkdir_and_chown $HOME/.bin

kickstart.info "Copy bin files to bin folder"
cp --preserve=mode,ownership files/bash/bin/beep.sh $HOME/.bin/beep
cp --preserve=mode,ownership files/bash/bin/colorize-code.sh $HOME/.bin/colorize-code
cp --preserve=mode,ownership files/bash/bin/colors.sh $HOME/.bin/colors
cp --preserve=mode,ownership files/bash/bin/diceware.sh $HOME/.bin/diceware
cp --preserve=mode,ownership files/bash/bin/screencast.sh $HOME/.bin/screencast
cp --preserve=mode,ownership files/bash/bin/trim.sh $HOME/.bin/trim
