#!/bin/bash

kickstart.context 'Editors/Neovim'

kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:neovim-ppa/stable

kickstart.package.update

kickstart.package.install neovim
kickstart.package.install silversearcher-ag

kickstart.info "Create folders fro nvim"
kickstart.mute mkdir -p ~/.vim/after/ftplugin || true
kickstart.mute mkdir -p ~/.config/nvim || true

kickstart.info "Copy vimrc file"
cp --preserve=mode,ownership files/editors/vimrc ~/.vimrc

kickstart.info "Copy init.vim file"
cp --preserve=mode,ownership files/editors/config/nvim/init.vim ~/.config/nvim

kickstart.info "Copy ftplugin files"
cp --preserve=mode,ownership files/editors/vim/after/ftplugin/* ~/.vim/after/ftplugin/

echo >> ~/.bashrc
echo "# Editors - added by kickstart" >> ~/.bashrc

kickstart.info "Add aliases to bashrc"
echo "alias vim='nvim'" >> ~/.bashrc
