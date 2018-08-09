" remove conflicting defaults
nunmap <buffer> c
nunmap <buffer> qL
nunmap <buffer> qF
nunmap <buffer> qf
nunmap <buffer> qb
nunmap <buffer> q

" delete netrw buffer after closing
setlocal bufhidden=wipe

" u for up a dir
" nnoremap <buffer> u -

" - for toggle on/off
" doesn't really work because entering a new dir opens a new buffer
nnoremap <buffer> - <C-^>

" s/v/o for split/vertsplit/open, revert caller window to alt file
nmap <buffer> s o<C-w>p<C-^><C-w>p
nmap <buffer> v v<C-w>p<C-^><C-w>p
nmap <buffer> V v<C-w>p<C-^>
nmap <buffer> o <CR>

" ranger-like zh for hidden files
nmap <buffer> zh gh
