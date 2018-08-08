augroup vimtitles
  au!
  autocmd VimEnter,BufEnter,BufWritePost <buffer> syntax match Title /^\s*".*{{{\d\{0,1\}$/
augroup END

setlocal foldmethod=marker
