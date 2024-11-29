augroup ftdetect_todo
  autocmd!
  autocmd BufRead,BufNewFile,BufEnter *todo/*.txt set filetype=todo
  autocmd BufRead,BufNewFile,BufEnter *notes/*.txt set filetype=todo
  autocmd BufRead,BufNewFile,BufEnter *todo.txt set filetype=todo
augroup END
