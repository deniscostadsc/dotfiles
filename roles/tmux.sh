#!/bin/bash

kickstart.context 'Tmux'

# shellcheck source=recipes/os.sh
source recipes/os.sh
# shellcheck source=recipes/bash.sh
source recipes/bash.sh

kickstart.package.update

kickstart.package.install tmux
! kickstart.os.is "Arch" && kickstart.package.install tmate

kickstart.info "Copy tmux config file"
kickstart.file.copy files/tmux/tmux.conf "$MYHOME/.tmux.conf"

kickstart.file.append_file_once files/tmux/bashrc_tmux.sh "$MYHOME/.bashrc"
