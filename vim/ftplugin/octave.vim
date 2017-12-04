
au VimEnter,BufEnter <buffer> syn match Title '^%%.*$'

set tabstop=4                   " number of visual spaces per TAB
set softtabstop=4               " number of spaces in tab when editing
set shiftwidth=4

set foldmethod=expr
set foldexpr=GetOctaveFolds(v:lnum)
set foldtext=GetOctaveFoldText()

function! GetOctaveFolds(lnum)
    if getline(a:lnum) =~ '^\s*\(%%\|function\)'
        return '>1'
    else
        return '='
    endif
endfunction

function! GetOctaveFoldText()
    let line = getline(v:foldstart)
    let line = substitute(line, '^\s*%%', '', 'g')
    let line = substitute(line, '^%', '  ', 'g')
    let line = substitute(line, '^function', ' function', 'g')
    return '+--' . line . ' '
endfunction

let b:Lpatterns = ['^\s*function', '%\+\s*TODO']
let b:Lreformat = ['[^|]*|[^|]*|\s/', '[^|]*|[^|]*|\s%\+\s*\(TODO.*\)$/\1']
