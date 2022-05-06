" Markdown/RMarkdown

autocmd FileType rmd map <F5> :!Rscript -e "rmarkdown::render('%')"<CR>
autocmd FileType rmd inoremap ,i ![]()<Left><Left><Left>
autocmd FileType rmd inoremap ,a []()<Left><Left><Left>
autocmd FileType rmd inoremap ,1 ***REMOVED***<Space>
autocmd FileType rmd inoremap ,2 ***REMOVED******REMOVED***<Space>
autocmd FileType rmd inoremap ,3 ***REMOVED******REMOVED******REMOVED***<Space>
autocmd FileType rmd inoremap ,4 ***REMOVED******REMOVED******REMOVED******REMOVED***<Space>
autocmd FileType rmd inoremap ,5 ***REMOVED******REMOVED******REMOVED******REMOVED******REMOVED***<Space>
autocmd FileType rmd inoremap ,u *<Space>
autocmd FileType rmd inoremap ,o 1.<Space>
autocmd FileType rmd inoremap ,f +@fig:
autocmd FileType rmd inoremap <C-b> ****<Left><Left>

autocmd FileType markdown map <F5> :!pandoc -f markdown -t html '%' > "$(extensionless '%').html"<CR>

" Shell
" autocmd FileType sh map <leader>b i***REMOVED***!/bin/sh<CR><CR>
" autocmd FileType sh inoremap ,f ()<Space>{<CR><Tab><++><CR>}<CR><CR><++><Esc>?()<CR>
" autocmd FileType sh inoremap ,i if<Space>[<Space>];<Space>then<CR><++><CR>fi<CR><CR><++><Esc>?];<CR>hi<Space>
" autocmd FileType sh inoremap ,ei elif<Space>[<Space>];<Space>then<CR><++><CR><Esc>?];<CR>hi<Space>
" autocmd FileType sh inoremap ,sw case<Space>""<Space>in<CR><++>)<Space><++><Space>;;<CR><++><CR>esac<CR><CR><++><Esc>?"<CR>i
" autocmd FileType sh inoremap ,ca )<Space><++><Space>;;<CR><++><Esc>?)<CR>i

" Html
autocmd FileType html map <F5> :!pandoc -f html -t markdown '%' > "$(extensionless '%').md"<CR>


" Calcurse
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.local/share/calcurse/notes/* set filetype=markdown


" Read rc files as cfg
autocmd BufRead,BufNewFile *rc set filetype=cfg
" Some files may be xyzrc.bak for example
autocmd BufRead,BufNewFile *rc.* set filetype=cfg
" Except these ones
autocmd BufRead,BufNewFile sxhkdrc* set filetype=sh
autocmd BufWrite sxhkdrc* :!pkill sxhkd && notify-send "sxhkd config reloaded" && sxhkd &!
autocmd BufRead,BufNewFile lfrc* set filetype=sh
autocmd BufRead,BufNewFile *zshrc* set filetype=sh
autocmd BufRead,BufNewFile *xinitrc* set filetype=sh


" Autocompile
autocmd FileType cpp map <F5> :!make clean && make && ./build/* 2>&1<CR>
autocmd FileType c map <F5> :!make<CR>


" Ensure files are read as I want
autocmd BufRead,BufNewFile *.md set filetype=markdown

" 2 tabs on html
autocmd FileType html set tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType rmd set tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType md set tabstop=2 softtabstop=2 shiftwidth=2

" For <C-e> in terminal, make sure it uses shell script
autocmd BufRead,BufNewFile zsh* set filetype=sh

" Conf files don't work sometimes?
autocmd BufRead,BufNewFile *.conf set filetype=conf
