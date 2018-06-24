au VimEnter,BufEnter <buffer> syn match Title '^##.*$'

inoremap {<CR> {<CR>}<Esc>O

setlocal foldmethod=expr
setlocal foldexpr=FoldExprDoubleCharSh(v:lnum)
setlocal foldtext=GetFoldTextSh()

function! GetFoldTextSh()
    if &foldmethod == 'expr'
        setlocal foldtext=FoldTextDoubleCharSh()
    elseif &foldmethod == 'marker'
        setlocal foldtext=FoldTextMarker()
    endif
endfunction

function! FoldTextDoubleCharSh()
    let line = getline(v:foldstart)
    let line = substitute(line, '^\s*##', '', 'g')
    let line = substitute(line, '^#', '  ', 'g')
    let line = substitute(line, '^#', '  ', 'g')
    return '+--' . line . ' '
endfunction

function! FoldExprDoubleCharSh(lnum)
    let l:line = getline(a:lnum)
    if l:line =~ '^\s*##'
        return '>1'
    elseif l:line =~ '^\s*###\s'
        return '>2'
    elseif l:line =~ '^\s*####\s'
        return '>3'
    else
        return '='
    endif
endfunction
