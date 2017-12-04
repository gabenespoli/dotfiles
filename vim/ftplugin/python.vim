
set tabstop=4                   " number of visual spaces per TAB
set softtabstop=4               " number of spaces in tab when editing
set shiftwidth=4

au VimEnter,BufEnter <buffer> syn match Title '^##.*$'
