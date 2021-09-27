nnoremap <buffer> = za
nmap <buffer> <expr> q PreviewWindowExists() ? ':pclose<CR>' : '<C-w>q'
nmap <buffer> <expr> o PreviewWindowExists() ? 'p' : 'gO:setlocal previewwindow<CR><C-w>p'

" https://stackoverflow.com/questions/14300101/is-there-a-way-to-know-preview-window-openedexisted-in-vim
function PreviewWindowExists()
  for nr in range(1, winnr('$'))
    if getwinvar(nr, '&pvw') == 1
      return 1
    endif  
  endfor
  return 0
endfunction
