" use q map to return to file
silent! nunmap <buffer> qL
silent! nunmap <buffer> qF
silent! nunmap <buffer> qf
silent! nunmap <buffer> qb
silent! nunmap <buffer> q
nnoremap <buffer> q :Rexplore<CR>

" hide files like ranger
nmap <buffer> zh gh
