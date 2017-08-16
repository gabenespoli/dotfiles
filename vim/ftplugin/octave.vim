" there is probably a more efficient way to do this than using BufEnter,
" but I can't figure out how to override the syntax in jvirtanen/vim-octave
au BufEnter <buffer> syn match commentHeading "^%%.*$"

"" Folding
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
