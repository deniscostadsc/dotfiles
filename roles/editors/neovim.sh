#!/bin/bash

kickstart.context 'Editors/Neovim'

source recipes/bash.sh

kickstart.os.is "Ubuntu" && {
    kickstart.package.install software-properties-common
    kickstart.apt.ppa ppa:neovim-ppa/stable
}

kickstart.package.update

kickstart.package.install neovim
! kickstart.os.is "Arch" && kickstart.package.install silversearcher-ag

kickstart.info "Create folders fro nvim"
kickstart.file.mkdir_and_chown "$MYHOME/.vim/after/ftplugin"
kickstart.file.mkdir_and_chown "$MYHOME/.config/nvim"

kickstart.info "Copy vimrc file"
cp --preserve=mode,ownership files/editors/neovim/vimrc "$MYHOME/.vimrc"

kickstart.info "Copy init.vim file"
cp --preserve=mode,ownership files/editors/neovim/config/nvim/init.vim "$MYHOME/.config/nvim"

kickstart.info "Copy ftplugin files"
cp --preserve=mode,ownership files/editors/neovim/vim/after/ftplugin/* "$MYHOME/.vim/after/ftplugin/"

kickstart.file.append_file_once files/editors/neovim/bashrc_neovim.sh "$MYHOME/.bashrc"
