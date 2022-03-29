" Markdown/RMarkdown

autocmd FileType rmd map <F5> :!Rscript -e "rmarkdown::render('%')"<CR>
autocmd FileType rmd inoremap ,i ![]()<Left><Left><Left>
autocmd FileType rmd inoremap ,a []()<Left><Left><Left>
autocmd FileType rmd inoremap ,1 #<Space>
autocmd FileType rmd inoremap ,2 ##<Space>
autocmd FileType rmd inoremap ,3 ###<Space>
autocmd FileType rmd inoremap ,4 ####<Space>
autocmd FileType rmd inoremap ,5 #####<Space>
autocmd FileType rmd inoremap ,u *<Space>
autocmd FileType rmd inoremap ,o 1.<Space>
autocmd FileType rmd inoremap ,f +@fig:
autocmd FileType rmd inoremap <C-b> ****<Left><Left>


" Shell
autocmd FileType sh map <leader>b i#!/bin/sh<CR><CR>
autocmd FileType sh inoremap ,f ()<Space>{<CR><Tab><++><CR>}<CR><CR><++><Esc>?()<CR>
autocmd FileType sh inoremap ,i if<Space>[<Space>];<Space>then<CR><++><CR>fi<CR><CR><++><Esc>?];<CR>hi<Space>
autocmd FileType sh inoremap ,ei elif<Space>[<Space>];<Space>then<CR><++><CR><Esc>?];<CR>hi<Space>
autocmd FileType sh inoremap ,sw case<Space>""<Space>in<CR><++>)<Space><++><Space>;;<CR><++><CR>esac<CR><CR><++><Esc>?"<CR>i
autocmd FileType sh inoremap ,ca )<Space><++><Space>;;<CR><++><Esc>?)<CR>i


" Calcurse
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.local/share/calcurse/notes/* set filetype=markdown


" Read rc files as cfg
autocmd BufRead,BufNewFile *rc set filetype=cfg
" Some files may be xyzrc.bak for example
autocmd BufRead,BufNewFile *rc.* set filetype=cfg
