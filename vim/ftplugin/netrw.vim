" remove conflicting defaults
nunmap <buffer> c
nunmap <buffer> qL
nunmap <buffer> qF
nunmap <buffer> qf
nunmap <buffer> qb
nunmap <buffer> q

" custom mappings
nmap <buffer> <C-j> <CR>
nmap <buffer> o <CR>
nmap <buffer> u -
nmap <buffer> zh gh

" if only netrw, quit, else switch back
nnoremap <buffer> <expr> q len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))==1 ? ':quit<CR>' : '<C-^>'
