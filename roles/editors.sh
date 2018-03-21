kickstart.context 'Editors'

kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:neovim-ppa/stable

kickstart.package.install neovim
kickstart.package.install silversearcher-ag

kickstart.info "Copy vimrc file"
cp --preserve=mode,ownership files/neovim/vimrc ~/.vimrc

kickstart.mute mkdir -p ~/.vim/after/ftplugin || true

kickstart.info "Copy ftplugin files"
cp --preserve=mode,ownership files/neovim/after/ftplugin/* ~/.vim/after/ftplugin/

kickstart.file.link ~/.vim ~/.config/nvim
kickstart.file.link ~/.vimrc ~/.config/nvim/init.vim

kickstart.command_exists atom || {
    kickstart.info "Download Atom deb file"
    kickstart.mute wget https://atom.io/download/deb

    kickstart.info "Install Aton from deb"
    kickstart.mute dpkg -i deb
    rm deb
}

kickstart.info "Add aliases to bashrc"
echo "alias vim='nvim'" >> ~/.bashrc
