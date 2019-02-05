set textwidth=79
setlocal tabstop=4 softtabstop=4 shiftwidth=4

if exists('*jedi#goto()')
  nnoremap <buffer> gd :call jedi#goto_assignments()<CR>
  nnoremap <buffer> gD :call jedi#goto()<CR>
endif
