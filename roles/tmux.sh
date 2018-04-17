#!/bin/bash

kickstart.context 'Tmux'

source recipes/bash.sh

kickstart.package.install tmux
kickstart.package.install tmate

kickstart.info "Copy tmux config file"
cp --preserve=mode,ownership files/tmux/tmux.conf ~/.tmux.conf

kickstart.file.append_once ~/.bashrc ""
kickstart.file.append_once ~/.bashrc "# Tmux - added by kickstart"

kickstart.info "Add aliases to bashrc"
kickstart.file.append_once ~/.bashrc "alias tmux='TERM=screen-256color-bce tmux'"
kickstart.file.append_once ~/.bashrc "alias my-tmux='tmux attach -t denis || tmux new -s denis'"
