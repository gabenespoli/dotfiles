augroup ftdetect_r
  autocmd!
  autocmd BufRead,BufNewFile *.r set filetype=r
  autocmd BufRead,BufNewFile *.R set filetype=r
  autocmd BufRead,BufNewFile .Rprofile set filetype=r
  autocmd BufRead,BufNewFile Rprofile set filetype=r
augroup END
