set syntax=muttrc

au VimEnter,BufEnter <buffer> syn match Title '^##.*$'

setlocal foldmethod=expr
setlocal foldexpr=GetMuttFolds(v:lnum)
setlocal foldtext=GetMuttFoldText()

function! GetMuttFolds(lnum)
    if getline(a:lnum) =~ '^\s*##'
        return '>1'
    else
        return '='
    endif
endfunction

function! GetMuttFoldText()
    let line = getline(v:foldstart)
    let line = substitute(line, '^\s*##', '', 'g')
    let line = substitute(line, '^#', '  ', 'g')
    return '+--' . line . ' '
endfunction
