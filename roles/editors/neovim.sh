#!/bin/bash

kickstart.context 'Editors/Neovim'

source recipes/bash.sh

kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:neovim-ppa/stable

kickstart.package.update

kickstart.package.install neovim
kickstart.package.install silversearcher-ag

kickstart.info "Create folders fro nvim"
kickstart.file.mkdir_and_chown $HOME/.vim/after/ftplugin
kickstart.file.mkdir_and_chown $HOME/.config/nvim

kickstart.info "Copy vimrc file"
cp --preserve=mode,ownership files/editors/neovim/vimrc $HOME/.vimrc

kickstart.info "Copy init.vim file"
cp --preserve=mode,ownership files/editors/neovim/config/nvim/init.vim $HOME/.config/nvim

kickstart.info "Copy ftplugin files"
cp --preserve=mode,ownership files/editors/neovim/vim/after/ftplugin/* $HOME/.vim/after/ftplugin/

kickstart.file.append_file_once files/editors/neovim/bashrc_neovim.sh $HOME/.bashrc
