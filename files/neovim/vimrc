"
" no vi-compatibility
"
set nocompatible

"
" Leader settings
"
let mapleader = ","


"
" Installing vundle
"
let is_vundle_installed=1
let vundle_file=expand('~/.vim/bundle/vundle/autoload/vundle.vim')
if !filereadable(vundle_file)
    echo "Intalling vundle...\n"
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle --depth=1
    let is_vundle_installed=0
endif

filetype off
set rtp+=~/.vim/bundle/vundle/


"
" Installing plugins
"
call vundle#begin()

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dracula/vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'gmarik/vundle'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'


if is_vundle_installed == 0
    echo "Installing bundles...\n"
    :PluginInstall
endif

call vundle#end()
filetype plugin on


"
" Indentation settings
"
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartindent


"
" General settings
"
filetype plugin on
set encoding=utf-8
map <tab> <c-w><c-w>  " alternating between windows with tab
set list
set listchars=tab:▸\ ,eol:¬,trail:•,extends:❱,precedes:❰,nbsp:░
map <leader>l :set list!<cr>  " toggle show invisible characters
set showbreak=↪\ 
set nobackup
set nowritebackup
set noswapfile
set clipboard=unnamed
set laststatus=2

"
" Visual settings
"
color dracula
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
vnoremap // y/<C-R>"<CR> " search for selected word


"
" NERDTree settings
"
map <leader>n :NERDTreeToggle<cr>
au Filetype nerdtree setlocal nolist


"
" CtrlP settings
"
map <leader>b :CtrlPBuffer<cr>


"
" Ack settings
"
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
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
