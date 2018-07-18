#!/bin/bash

kickstart.context 'Tmux'

source recipes/bash.sh

kickstart.package.update

kickstart.package.install tmux
kickstart.package.install tmate

kickstart.info "Copy tmux config file"
cp --preserve=mode,ownership files/tmux/tmux.conf $HOME/.tmux.conf

kickstart.file.append_file_once files/tmux/bashrc_tmux.sh $HOME/.bashrc
