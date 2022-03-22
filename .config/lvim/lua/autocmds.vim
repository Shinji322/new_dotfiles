" Markdown/RMarkdown

autocmd FileType rmd map <F5> :!Rscript -e "rmarkdown::render('%')"<CR>
autocmd FileType rmd, markdown inoremap ,i ![](<++>){#fig:<++>}<Space><CR><CR><++><Esc>kkF]i
autocmd FileType rmd, markdown inoremap ,a [](<++>)<Space><++><Esc>F]i
autocmd FileType rmd, markdown inoremap ,1 #<Space><CR><CR><++><Esc>2k<S-a>
autocmd FileType rmd, markdown inoremap ,2 ##<Space><CR><CR><++><Esc>2k<S-a>
autocmd FileType rmd, markdown inoremap ,3 ###<Space><CR><CR><++><Esc>2k<S-a>
autocmd FileType rmd, markdown inoremap ,4 ####<Space><CR><CR><++><Esc>2k<S-a>
autocmd FileType rmd, markdown inoremap ,5 #####<Space><CR><CR><++><Esc>2k<S-a>
autocmd FileType rmd, markdown inoremap ,u +<Space><CR><++><Esc>1k<S-a>
autocmd FileType rmd, markdown inoremap ,o 1.<Space><CR><++><Esc>1k<S-a>
autocmd FileType rmd, markdown inoremap ,f +@fig:


" Shell
autocmd FileType sh map <leader>b i#!/bin/sh<CR><CR>
autocmd FileType sh inoremap ,f ()<Space>{<CR><Tab><++><CR>}<CR><CR><++><Esc>?()<CR>
autocmd FileType sh inoremap ,i if<Space>[<Space>];<Space>then<CR><++><CR>fi<CR><CR><++><Esc>?];<CR>hi<Space>
autocmd FileType sh inoremap ,ei elif<Space>[<Space>];<Space>then<CR><++><CR><Esc>?];<CR>hi<Space>
autocmd FileType sh inoremap ,sw case<Space>""<Space>in<CR><++>)<Space><++><Space>;;<CR><++><CR>esac<CR><CR><++><Esc>?"<CR>i
autocmd FileType sh inoremap ,ca )<Space><++><Space>;;<CR><++><Esc>?)<CR>i
