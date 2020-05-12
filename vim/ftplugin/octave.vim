setlocal textwidth=75
setlocal tabstop=4 softtabstop=4 shiftwidth=4
setlocal commentstring=%%s
setlocal omnifunc=syntaxcomplete#Complete
setlocal foldmethod=expr
setlocal foldexpr=GetOctaveFolds(v:lnum)
function! GetOctaveFolds(lnum) "{{{
  if getline(a:lnum) =~# '^\s*function'
    return '>1'
  elseif getline(a:lnum) =~#  '^\s*%%'
    return '>1'
  else
    return '='
  endif
endfunction "}}}
