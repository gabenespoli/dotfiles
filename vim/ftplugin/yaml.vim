setlocal foldmethod=expr
setlocal foldexpr=YAMLFold(v:lnum)
setlocal foldtext=YAMLFoldText()

function! YAMLFold(lnum) "{{{
  let l:line = getline(a:lnum)
  let l:indent = indent(a:lnum)

  if l:line =~# '^\\s*$' || l:line =~# '^\\s*#'
    return '-1'
  elseif l:indent == 0 && l:line =~# ':$'
    return '>1'
  elseif l:indent == 2 && l:line =~# ':$'
    return '>2'
  elseif l:indent == 4 && l:line =~# ':$'
    return '>3'
  elseif l:indent == 6 && l:line =~# ':$'
    return '>4'
  elseif l:indent == 8 && l:line =~# ':$'
    return '>5'
  elseif l:indent == 10 && l:line =~# ':$'
    return '>6'
  else
    return '='
  endif
endfunction "}}}

function! YAMLFoldText() "{{{
  let l:line = getline(v:foldstart)
  let l:lines = v:foldend - v:foldstart + 1
  return l:line . ' (' . l:lines . ')'
endfunction "}}}
