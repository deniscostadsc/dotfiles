#!/bin/bash

kickstart.context 'Bash'

# shellcheck disable=SC1091
source recipes/bash.sh

kickstart.info "Copy rcfiles to home folder"
cp --preserve=mode,ownership files/bash/bashrc.sh "$MYHOME/.bashrc"
cp --preserve=mode,ownership files/bash/bash_profile.sh "$MYHOME/.bash_profile"

kickstart.file.append_all_bashrc_files

kickstart.info "Create $MYHOME/.bin folder if does not exist"
kickstart.file.mkdir_and_chown "$MYHOME/.bin"

kickstart.info "Copy bin files to bin folder"
cp --preserve=mode,ownership files/bash/bin/beep.sh "$MYHOME/.bin/beep"
cp --preserve=mode,ownership files/bash/bin/colorize-code.sh "$MYHOME/.bin/colorize-code"
cp --preserve=mode,ownership files/bash/bin/colors.sh "$MYHOME/.bin/colors"
cp --preserve=mode,ownership files/bash/bin/diceware.sh "$MYHOME/.bin/diceware"
cp --preserve=mode,ownership files/bash/bin/screencast.sh "$MYHOME/.bin/screencast"
cp --preserve=mode,ownership files/bash/bin/trim.sh "$MYHOME/.bin/trim"
