" less-frustrating exit from netrw
silent! nunmap <buffer> qL
silent! nunmap <buffer> qF
silent! nunmap <buffer> qf
silent! nunmap <buffer> qb
silent! nunmap <buffer> q
nnoremap <buffer> q :Rexplore<CR>
nnoremap <buffer> <C-^> :Rexplore<CR>
nnoremap <buffer> Q :q<CR>

" ranger-like zh for hidden files
nmap <buffer> zh gh
