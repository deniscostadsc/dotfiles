kickstart.context 'Neovim'

kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:neovim-ppa/stable

kickstart.package.install neovim
kickstart.package.install silversearcher-ag

rm -rf ~/.vimrc
cp files/neovim/vimrc ~/.vimrc

kickstart.mute mkdir ~/.vim || true
kickstart.file.link ~/.vim ~/.config/nvim
kickstart.file.link ~/.vimrc ~/.config/nvim/init.vim

alias vim='nvim' # TODO
