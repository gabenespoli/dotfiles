
au VimEnter,BufEnter <buffer> syn match Title '^##.*$'

set foldmethod=expr
set foldexpr=GetTmuxFolds(v:lnum)
set foldtext=GetTmuxFoldText()

function! GetTmuxFolds(lnum)
    if getline(a:lnum) =~ '^\s*##'
        return '>1'
    else
        return '='
    endif
endfunction

function! GetTmuxFoldText()
    let line = getline(v:foldstart)
    let line = substitute(line, '^\s*##', '', 'g')
    let line = substitute(line, '^#', '  ', 'g')
    return '+--' . line . ' '
endfunction
