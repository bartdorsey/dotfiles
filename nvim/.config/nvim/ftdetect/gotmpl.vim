" autocmd BufNewFile,BufRead *.html if search('{{.\+}}', 'nw') | setlocal filetype=gotmpl | endif
