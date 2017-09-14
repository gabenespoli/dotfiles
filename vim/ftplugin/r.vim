" nvim-r plugin bindings
" nnoremap <localleader>r

set equalalways
if has('nvim')
    tnoremap <buffer> _ <Space><-<Space>
endif

" comment headings and folding
au BufEnter <buffer> syn match CommentHeading '^##.*$'

set foldmethod=expr
set foldexpr=GetRFolds(v:lnum)
set foldtext=GetRFoldText()

function! GetRFolds(lnum)
    if getline(a:lnum) =~ '^\s*##'
        return '>1'
    else
        return '='
    endif
endfunction

function! GetRFoldText()
    let line = getline(v:foldstart)
    let line = substitute(line, '^\s*##', '', 'g')
    let line = substitute(line, '^#', '  ', 'g')
    return '+--' . line . ' '
endfunction
