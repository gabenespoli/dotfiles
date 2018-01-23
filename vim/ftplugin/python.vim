set tabstop=4 softtabstop=4 shiftwidth=4
set foldmethod=expr
foldexpr=GetPythonFolds(v:lnum)
function! GetPythonFolds(lnum)
    if getline(a:lnum) =~ '^\s*\(class\|def\|#!\)'
        return '>1'
    else
        return '='
    endif
endfunction
