" For my sensible vim defaults

set title
set clipboard+=unnamedplus
set guioptions+=a
set number relativenumber
set nocompatible
set expandtab
set encoding=UTF-8
filetype plugin on
syntax on

"set tabstop=4 softtabstop=4
set tabstop=2 softtabstop=2
set shiftwidth=2
set noswapfile
set spelllang = "en"

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

" Ensure files are read as I want
autocmd BufRead,BufNewFile *.md set filetype=markdown
