#!/bin/bash

kickstart.context 'Editors/Neovim'

# shellcheck source=recipes/os.sh
source recipes/os.sh

#shellcheck source=recipes/bash.sh
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
kickstart.file.copy files/editors/neovim/vimrc "$MYHOME/.vimrc"

kickstart.info "Copy init.vim file"
kickstart.file.copy files/editors/neovim/config/nvim/init.vim "$MYHOME/.config/nvim"

kickstart.info "Copy ftplugin files"
kickstart.file.copy files/editors/neovim/vim/after/ftplugin/* "$MYHOME/.vim/after/ftplugin/"

kickstart.file.append_file_once files/editors/neovim/bashrc_neovim.sh "$MYHOME/.bashrc"
