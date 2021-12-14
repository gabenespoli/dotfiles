" need gs for git status, so use s instead of gs for sort maps
nmap <buffer> ss <Plug>(FlogCycleSort)
nmap <buffer> sd <Plug>(FlogSortDate)
nmap <buffer> sa <Plug>(FlogSortAuthor)
nmap <buffer> st <Plug>(FlogSortTopo)
nmap <buffer> sr <Plug>(FlogToggleReverse)

nmap <buffer> gs gq:Gedit :<CR>

nmap <buffer> git :Floggit

nmap <buffer> o <CR>
nmap <buffer> p <CR><C-w>lzM<C-w>h

nmap <buffer> r<Space> :Floggit rebase<Space>
nmap <buffer> co<Space> :Floggit checkout<Space>

nmap <buffer> . "hy<C-g>:Floggit  <C-R>h<S-Left><Left>

nmap <buffer> cf :<C-U>call flog#run_command('Git commit --fixup=%h', 0, 1)<CR>
nmap <buffer> cp :<C-U>call flog#run_command('Git cherry-pick %h', 0, 1)<CR>
nmap <buffer> gR :<C-U>call flog#run_command('Git reset HEAD^', 0, 1)<CR>
nmap <buffer> ca :Git commit --amend<CR>
nnoremap <buffer> <silent> J :Flogjump HEAD<CR>zz

" disable split while jumping refs
nnoremap <buffer> <silent> ]r :<C-U>call flog#next_ref()<CR>
nnoremap <buffer> <silent> [r :<C-U>call flog#previous_ref()<CR>