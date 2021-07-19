setlocal tabstop=4 softtabstop=4 shiftwidth=4
setlocal commentstring=--%s
nnoremap <buffer> <F5> :%DB g:db_con<CR>
imap <buffer> <F5> <Esc><F5>
