colorscheme desert

set number
set expandtab
set tabstop=4
set smartindent
set shiftwidth=4

set guifont=Courier\ Medium\ 10

nmap <leader>t :CommandT<cr>
nmap <leader>n :NERDTree<cr>
nmap <leader>b :BufExplorer<cr>

nmap <C-t> :tabnew<CR>
nmap <C-left> :tabprevious<CR>
nmap <C-right> :tabnext<CR>

call pathogen#infect()
