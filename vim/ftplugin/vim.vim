setlocal foldmethod=marker
autocmd VimEnter,BufEnter <buffer> syntax match Title /^\s*".*{{{\d\{0,1\}$/
let b:Lpatterns = ['^\s*function', '"\+\s*TODO']
let b:Lreformat = ['[^|]*|[^|]*|\s/', '[^|]*|[^|]*|\s"\+\s*\(TODO.*\)$/\1']
