nnoremap <buffer> git :Git
nnoremap <buffer> <silent> rim :<C-U>Grebase -i --autosquash master<CR>
nnoremap <buffer> <silent> ri<Space> :Grebase -i --autosquash<Space>
nmap <buffer> o <CR>
nnoremap <buffer> gR :Git reset HEAD^<CR>

" if fugitive was the first buffer, and is still the only buffer,
" q will quit vim, otherwise switch to previous buffer
nnoremap <buffer> <expr> q bufnr()==1 && bufname(2)=='' ? ':quit<CR>' : '<C-^>'
