nnoremap <buffer> zo zO
nnoremap <buffer> zO zo
nnoremap <buffer> = za
nmap <buffer> <expr> q PreviewWindowExists() ? ':pclose<CR>' : '<C-w>q'
" nmap <buffer> <expr> o PreviewWindowExists() ? 'p' : 'gO:setlocal previewwindow<CR><C-w>p'

" https://stackoverflow.com/questions/14300101/is-there-a-way-to-know-preview-window-openedexisted-in-vim
function PreviewWindowExists()
  for nr in range(1, winnr('$'))
    if getwinvar(nr, '&pvw') == 1
      return 1
    endif  
  endfor
  return 0
endfunction

" fold at filenames and hunks
function! GitFolds(lnum) "{{{
  if getline(a:lnum) =~# '^diff'
    return '>1'
  elseif getline(a:lnum) =~# '^@@'
    return '>2'
  else
    return '='
  endif
endfunction "}}}

setlocal foldmethod=expr
setlocal foldexpr=GitFolds(v:lnum)
setlocal foldtext=getline(v:foldstart)
