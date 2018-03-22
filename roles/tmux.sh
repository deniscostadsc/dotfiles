#!/bin/bash

kickstart.context 'Tmux'

kickstart.package.install tmux
kickstart.package.install tmate

kickstart.info "Copy tmux config file"
cp --preserve=mode,ownership files/tmux/tmux.conf ~/.tmux.conf

echo >> ~/.bashrc
echo "# Tmux - added by kickstart" >> ~/.bashrc

kickstart.info "Add aliases to bashrc"
echo "alias tmux='TERM=screen-256color-bce tmux'" >> ~/.bashrc
echo "alias my-tmux='tmux attach -t denis || tmux new -s denis'" >> ~/.bashrc
