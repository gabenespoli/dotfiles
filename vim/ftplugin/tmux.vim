
au VimEnter,BufEnter <buffer> syn match Title '^##.*$'

setlocal foldmethod=expr
setlocal foldexpr=GetTmuxFolds(v:lnum)

function! GetTmuxFolds(lnum)
    if getline(a:lnum) =~ '^\s*##'
        return '>1'
    else
        return '='
    endif
endfunction

