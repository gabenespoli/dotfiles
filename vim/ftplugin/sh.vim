au VimEnter,BufEnter <buffer> syn match Title '^##.*$'

inoremap {<CR> {<CR>}<Esc>O

setlocal foldmethod=expr
setlocal foldexpr=FoldExprDoubleCharSh(v:lnum)

function! FoldTextDoubleCharSh()
    let line = getline(v:foldstart)
    let line = substitute(line, '^\s*##', '', 'g')
    let line = substitute(line, '^#', '  ', 'g')
    let line = substitute(line, '^#', '  ', 'g')
    return '+--' . line . ' '
endfunction
