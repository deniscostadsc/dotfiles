#!/bin/bash

kickstart.context 'Editors'

kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:neovim-ppa/stable

kickstart.package.update

kickstart.package.install wget

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

kickstart.command_exists atom || {
    kickstart.info "Download Atom deb file"
    kickstart.mute wget https://atom.io/download/deb

    kickstart.info "Install Aton from deb"
    kickstart.mute apt install deb
    rm deb
}

kickstart.info "Install Atom plugins"
kickstart.mute apm install --packages-file files/editors/atom/packages.txt
kickstart.mute apm upgrade

kickstart.info "Copy Atom config file"
cp --preserve=mode,ownership files/editors/atom/config.cson ~/.atom/
