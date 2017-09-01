
au BufEnter <buffer> syn match CommentHeading '^##.*$'

set foldmethod=expr
set foldexpr=FoldExprDoubleCharSh(v:lnum)
set foldtext=GetFoldTextSh()

function! GetFoldTextSh()
    if &foldmethod == 'expr'
        setlocal foldtext=FoldTextDoubleCharSh()
    elseif &foldmethod == 'marker'
        setlocal foldtext=FoldTextMarker()
    endif
endfunction

function! FoldExprDoubleCharSh(lnum)
    if getline(a:lnum) =~ '^\s*##'
        return '>1'
    else
        return '='
    endif
endfunction

function! FoldTextDoubleCharSh()
    let line = getline(v:foldstart)
    let line = substitute(line, '^\s*##', '', 'g')
    let line = substitute(line, '^#', '  ', 'g')
    return '+--' . line . ' '
endfunction
