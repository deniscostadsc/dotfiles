#!/bin/bash

kickstart.context 'Bash'

# shellcheck source=recipes/bash.sh
source recipes/bash.sh
# shellcheck source=recipes/os.sh
source recipes/os.sh

kickstart.info "Install find and which for Fedora"
kickstart.os.is "RHEL" && kickstart.package.install which

kickstart.info "Copy rcfiles to home folder"
kickstart.file.copy files/bash/bashrc.sh "$MYHOME/.bashrc"
kickstart.file.copy files/bash/bash_profile.sh "$MYHOME/.bash_profile"

kickstart.file.append_all_bashrc_files

kickstart.info "Create $MYHOME/.bin folder if does not exist"
kickstart.file.mkdir_and_chown "$MYHOME/.bin"

kickstart.info "Copy bin files to bin folder"
kickstart.file.copy files/bash/bin/beep.sh "$MYHOME/.bin/beep"
kickstart.file.copy files/bash/bin/colorize-code.sh "$MYHOME/.bin/colorize-code"
kickstart.file.copy files/bash/bin/colors.sh "$MYHOME/.bin/colors"
kickstart.file.copy files/bash/bin/diceware.sh "$MYHOME/.bin/diceware"
kickstart.file.copy files/bash/bin/screencast.sh "$MYHOME/.bin/screencast"
kickstart.file.copy files/bash/bin/trim.sh "$MYHOME/.bin/trim"
