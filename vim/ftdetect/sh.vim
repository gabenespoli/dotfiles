augroup ftdetect_sh
  autocmd!
  autocmd BufRead,BufNewFile */bash* set filetype=sh
  autocmd BufRead,BufNewFile */.bash* set filetype=sh
augroup END

