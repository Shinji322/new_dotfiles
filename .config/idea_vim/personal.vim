set title
set clipboard+=unnamedplus
set guioptions+=a
set number relativenumber
set nocompatible
set expandtab
set encoding=UTF-8
filetype plugin on
syntax on

set tabstop=4 softtabstop=4
set shiftwidth=4
set noswapfile
set undodir=~/.cache/vim/undodir
set undofile
set timeoutlen=300

" search related things
set hlsearch
set incsearch
set ignorecase
set smartcase

" autocenter document
autocmd InsertEnter * norm zz

" Fix indenting visual block
vmap < <gv
vmap > >gv

" Other
set mouse=a
