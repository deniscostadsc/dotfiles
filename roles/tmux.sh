#!/bin/bash

kickstart.context 'Tmux'

# shellcheck disable=SC1091
source recipes/bash.sh

kickstart.package.update

kickstart.package.install tmux
kickstart.package.install tmate

kickstart.info "Copy tmux config file"
cp --preserve=mode,ownership files/tmux/tmux.conf "$MYHOME/.tmux.conf"

kickstart.file.append_file_once files/tmux/bashrc_tmux.sh "$MYHOME/.bashrc"
