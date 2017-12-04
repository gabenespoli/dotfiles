nnoremap <silent> <buffer> <C-j> <CR>
nnoremap <silent> <buffer> q :q<CR>

" bookmark mappings
nnoremap gh :OpenBookmark home<CR>
nnoremap gb :OpenBookmark bin<CR>
nnoremap g. :OpenBookmark dotfiles<CR>
nnoremap gl :OpenBookmark local<CR>
nnoremap gv :OpenBookmark private<CR>
nnoremap gr :OpenBookmark projects<CR>
nnoremap gp :OpenBookmark projects<CR>
nnoremap gn :OpenBookmark notes<CR>
nnoremap gx :OpenBookmark dropbox<CR>
nnoremap gk :OpenBookmark desktop<CR>
nnoremap gw :OpenBookmark downloads<CR>

" nnoremap <silent> <buffer> l :call NERDTree_l()<CR>
" nnoremap <silent> <buffer> h :call NERDTree_h()<CR>
" nnoremap <silent> <buffer> o :call NERDTree_o()<CR>

" function! NERDTree_l()
"     let l:syntax = GetSyntaxUnderCursor() 
"     if l:syntax == 'NERDTreeFile' || l:syntax == 'NERDTreeOpenable'
"         " open node or file
"         call nerdtree#ui_glue#invokeKeyMap("o")
"     endif
" endfunction

" function! NERDTree_h()
"     " first check if this line is closable
"     normal! 0
"     call search(g:NERDTreeDirArrowCollapsible, 'c', line("."))
"     let l:syntax = GetSyntaxUnderCursor() 
"     if l:syntax == 'NERDTreeClosable'
"         " close the node
"         call nerdtree#ui_glue#invokeKeyMap("o")
"     elseif l:syntax == 'NERDTreeFile' || l:syntax == 'NERDTreeOpenable'
"         " go to parent
"         call nerdtree#ui_glue#invokeKeyMap("p")
"     elseif l:syntax == 'NERDTreeCWD' || l:syntax == 'NERDTreeUp' || l:syntax == 'NERDTreeHelp'
"         " move up a dir
"         call nerdtree#ui_glue#invokeKeyMap("u")
"     endif
"     normal! 0
" endfunction

" function! NERDTree_o()
"     let l:syntax = GetSyntaxUnderCursor() 
"     if l:syntax == 'NERDTreeFile'
"         " regular functionality
"         call nerdtree#ui_glue#invokeKeyMap("o")
"     elseif l:syntax == 'NERDTreeOpenable' || l:syntax=='NERDTreeClosable'
"         " change tree root to selected dir
"         call nerdtree#ui_glue#invokeKeyMap("C")
"     endif
" endfunction
