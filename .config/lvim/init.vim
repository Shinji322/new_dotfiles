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

set tabstop=4 softtabstop=4
set shiftwidth=4
"set tabstop=2 softtabstop=2
"set shiftwidth=2
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

" enable autocompletion menu after pressing tab
set wildmenu

" Make wildmenu behave like similar to Bash completion
set wildmode=list:longest

" Ensure files are read as I want
autocmd BufRead,BufNewFile *.md set filetype=markdown

" 2 tabs on html
autocmd FileType html set tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType rmd set tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType md set tabstop=2 softtabstop=2 shiftwidth=2

" For <C-e> in terminal, make sure it uses shell script
autocmd BufRead,BufNewFile zsh* set filetype=zsh
