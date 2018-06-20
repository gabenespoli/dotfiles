" general {{{1
set tabstop=4                   " number of visual spaces per TAB
set softtabstop=4               " number of spaces in tab when editing
set shiftwidth=4

" folding {{{1
set foldmethod=expr
set foldexpr=GetOctaveFolds(v:lnum)
set foldtext=GetOctaveFoldText()

function! GetOctaveFolds(lnum)
  if getline(a:lnum) =~ '^\s*function'
    return '>1'
  elseif getline(a:lnum) =~  '^\s*%%'
    return '>1'
  else
    return '='
  endif
endfunction

function! GetOctaveFoldText()
  let line = getline(v:foldstart)
  let line = substitute(line, '^\s*%%', ' ▸ %%', 'g')
  let line = substitute(line, '^function', '▸ function', 'g')
  return line . ' '
endfunction

let b:Lpatterns = ['/%\+\s*TODO/gj *', '/^\s*function/gj %']
let b:Lreformat = ['', '/[^|]*|[^|]*|\s//ge']
" let b:Lreformat = ['/[^|]*|[^|]*|\s%\+\s*\(TODO.*\)$/\1/ge', '/[^|]*|[^|]*|\s//ge']
