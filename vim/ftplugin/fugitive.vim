nnoremap <buffer> git :Git
nmap <buffer> o gO
nnoremap <buffer> gR :Git reset HEAD^<CR>
nmap <buffer> <C-n> )
nmap <buffer> <C-p> (
nmap <buffer> <C-i> =

" if fugitive was the first buffer, and is still the only buffer,
" q will quit vim, otherwise switch to previous buffer
nnoremap <buffer> <expr> q bufnr()==1 && bufname(2)=='' ? ':quit<CR>' : '<C-^>'
