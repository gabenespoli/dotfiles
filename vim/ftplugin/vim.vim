
" au BufEnter <buffer> syn match CommentHeading '^"".*$'

setlocal foldmethod=marker
setlocal foldexpr=FoldExprDoubleCharVim(v:lnum)
setlocal foldtext=GetFoldTextVim()

function! GetFoldTextVim()
    if &foldmethod == 'expr'
        setlocal foldtext=FoldTextDoubleCharVim()
    elseif &foldmethod == 'marker'
        setlocal foldtext=FoldTextMarker()
    endif
endfunction

function! FoldTextDoubleCharVim()
    let line = getline(v:foldstart)
    let line = substitute(line, '^\s*""', '', 'g')
    let line = substitute(line, '^"', '  ', 'g')
    return '+--' . line . ' '
endfunction

function! FoldExprDoubleCharVim(lnum)
    if getline(a:lnum) =~ '^\s*""'
        return '>1'
    else
        return '='
    endif
endfunction

let b:Lpatterns = ['^\s*function', '"\+\s*TODO']
let b:Lreformat = ['[^|]*|[^|]*|\s/', '[^|]*|[^|]*|\s"\+\s*\(TODO.*\)$/\1']
