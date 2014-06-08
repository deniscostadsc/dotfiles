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
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'

if is_vundle_installed == 0
    echo "Installing bundles...\n"
    :PluginInstall
endif

call vundle#end()


"
" Indentation settings
"
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartindent


"
" Visual settings
"
colorscheme slate
set guifont=Ubuntu\ Mono\ 10
set number
syntax on
set colorcolumn=80
highlight ColorColumn guibg=OrangeRed4


"
" General settings
"
set encoding=utf-8
map <tab> <c-w><c-w>  " alternating between windows with tab


"
" NERDTree settings
"
map <leader>n :NERDTreeToggle<cr>


"
" CtrlP settings
"
map <leader>b :CtrlPBuffer<cr>


"
" Ack settings
"
let g:ack_default_options = " -H --nocolor --nogroup --column"


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
