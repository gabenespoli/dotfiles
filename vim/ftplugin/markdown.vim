"set nonumber
"au VimEnter * :GitGutterDisable
"nnoremap <leader>t :ilist /#\ <CR>:
nnoremap <leader>t :call ToggleCenteredWindow()<CR>:TOC<CR>:set nowrap<CR>
hi htmlString ctermfg=11
hi htmlTagName ctermfg=11
