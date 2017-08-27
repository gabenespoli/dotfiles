
au BufEnter <buffer> syn match CommentHeading '^"".*$'

set foldmethod=expr
set foldexpr=GetVimFolds(v:lnum)
set foldtext=GetVimFoldText()

function! GetVimFolds(lnum)
    if getline(a:lnum) =~ '^\s*""'
        return '>1'
    else
        return '='
    endif
endfunction

function! GetVimFoldText()
    let line = getline(v:foldstart)
    let line = substitute(line, '^\s*""', '', 'g')
    let line = substitute(line, '^"', '  ', 'g')
    return '+--' . line . ' '
endfunction

let b:Lpatterns = ['^\s*function', '"\s*TODO']
let b:Lreformat = ['[^|]*|[^|]*|\s/', '']
