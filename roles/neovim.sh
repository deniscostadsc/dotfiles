kickstart.context 'Neovim'

kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:neovim-ppa/stable

kickstart.package.install neovim
kickstart.package.install silversearcher-ag

cp files/neovim/vimrc ~/.vimrc

kickstart.mute mkdir -p ~/.vim/after/ftplugin || true

cp files/neovim/after/ftplugin/* ~/.vim/after/ftplugin/

kickstart.file.link ~/.vim ~/.config/nvim
kickstart.file.link ~/.vimrc ~/.config/nvim/init.vim

# TODO
alias vim='nvim'
