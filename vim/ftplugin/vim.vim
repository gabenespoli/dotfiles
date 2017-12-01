autocmd VimEnter,BufEnter <buffer> syntax match Title /^\s*"".*$/

set tabstop=2                   " number of visual spaces per TAB
set softtabstop=2               " number of spaces in tab when editing
set shiftwidth=2

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
    let line = substitute(line, '^"', '  ', 'g')
    return '+--' . line . ' '
endfunction

function! FoldExprDoubleCharVim(lnum)
    let l:line = getline(a:lnum)
    if l:line =~ '^\s*""\s'
        return '>1'
    elseif l:line =~ '^\s*"""\s'
        return '>2'
    elseif l:line =~ '^\s*""""\s'
        return '>3'
    else
        return '='
    endif
endfunction

let b:Lpatterns = ['^\s*function', '"\+\s*TODO']
let b:Lreformat = ['[^|]*|[^|]*|\s/', '[^|]*|[^|]*|\s"\+\s*\(TODO.*\)$/\1']
