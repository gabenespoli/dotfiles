" general {{{1
setlocal tabstop=4                   " number of visual spaces per TAB
setlocal softtabstop=4               " number of spaces in tab when editing
setlocal shiftwidth=4

" folding {{{1
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

" syntax completion {{{1
setlocal omnifunc=syntaxcomplete#Complete
