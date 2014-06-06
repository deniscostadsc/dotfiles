" no vi-compatibility
set nocompatible


"
" Installing vundle
"
let is_vundle_installed=1
let vundle_readme=expand('~/.vim/bundle/vundle/autoload/vundle.vim')
if !filereadable(vundle_readme)
    echo "Intalling vundle...\n"
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let is_vundle_installed=0
endif

filetype off
set rtp+=~/.vim/bundle/vundle/


"
" Installing plugins
"
if is_vundle_installed == 0
    call vundle#begin()

    Plugin 'scrooloose/nerdtree'

    :PluginInstall

    call vundle#end()
endif


"
" Indentation settings
"
set expandtab
set shiftwidth=4
set softtabstop=0
set tabstop=4
set smartindent


"
" Visual settings
"
colorscheme zellner
set guifont=Courier\ Medium\ 10
set number


"
" Aliases settings (no stress)
"
cab Q q
cab Q! q!
cab W w
cab W! w!
cab Wa wa
cab Wq wq
cab wQ wq
cab WQ wq
