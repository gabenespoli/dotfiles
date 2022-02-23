nnoremap <buffer> git :Git
nmap <buffer> <C-n> <lt>)>
nmap <buffer> <C-p> <lt>(>
nnoremap <buffer> gR :Git reset HEAD^<CR>

" if fugitive was the first buffer, and is still the only buffer,
" q will quit vim, otherwise switch to previous buffer
nnoremap <buffer> <expr> q bufnr()==1 && bufname(2)=='' ? ':quit<CR>' : '<C-^>'
