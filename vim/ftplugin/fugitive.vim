nnoremap <buffer> gR :Git reset HEAD^<CR>

" unmap fugitive's gi in favour of the git mapping from vimrc
nunmap <buffer> gi

" Use folding maps to show/hide inline diffs
nmap <buffer> zo >
nmap <buffer> zc <
nmap <buffer> zj )
nmap <buffer> zk (

nmap <buffer> <expr> q
    \ exists('w:fugitive_last_bufnr') ?
    \ ':execute ''b''.w:fugitive_last_bufnr<CR>' : ':q<CR>'

nmap <buffer> o <CR>
