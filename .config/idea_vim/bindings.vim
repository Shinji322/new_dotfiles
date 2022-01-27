let mapleader = " "

nnoremap ; :
vnoremap ; :

" Aliases
cnoreabbrev W w
cnoreabbrev Q qall
cnoreabbrev q qall
cnoreabbrev wq wqall


" Plugin Bindings


" WhichKey
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>

" EasyMotion
nmap s <Plug>(easymotion-bd-f)
nmap S <Plug>(easymotion-overwin-f2)

" Vim Surround
nmap <leader>wh  yss =
nmap <leader>whh yss ==
