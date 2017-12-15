setlocal foldmethod=marker
autocmd VimEnter,BufEnter <buffer> syntax match Title /^\s*".*{{{\d\{0,1\}$/
let b:Lpatterns = ['"\+\s*TODO', '^\s*function']
let b:Lreformat = ['[^|]*|[^|]*|\s"\+\s*\(TODO.*\)$/\1', '[^|]*|[^|]*|\s/']
