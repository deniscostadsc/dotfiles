" no vi-compatibility
set nocompatible

" Leader settings
let mapleader = ","


"
" Installing vundle
"
let is_vundle_installed=1
let vundle_file=expand('~/.vim/bundle/vundle/autoload/vundle.vim')
if !filereadable(vundle_file)
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
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'editorconfig/editorconfig-vim'

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
set tw=79


"
" General settings
"
set encoding=utf-8
set list
map <tab> <c-w><c-w>  " alternating between windows with tab
set listchars=tab:▸\ ,eol:¬,trail:•
map <leader>l :set list!<cr>  " toggle show invisible characters


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
" Editing settings
"
vnoremap < <gv
vnoremap > >gv
vnoremap <Leader>s :sort<CR>
vmap Q gq
nmap Q gqap


"
" NERDTree settings
"
map <leader>n :NERDTreeToggle<cr>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']


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
