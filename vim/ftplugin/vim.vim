setlocal foldmethod=marker
autocmd VimEnter,BufEnter <buffer> syntax match Title /^\s*".*{{{\d\{0,1\}$/
