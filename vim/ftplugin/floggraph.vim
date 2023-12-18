" nmap <buffer> <expr> i exists(":Twiggy") == 2 ? ':Twiggy<CR>' : ':echo Twiggy not installed<CR>'

" nmap <buffer> gS q:Gedit :<CR>

" " need gs for git status, so use s instead of gs for sort maps
" nmap <buffer> ss <Plug>(FlogCycleSort)
" nmap <buffer> sd <Plug>(FlogSortDate)
" nmap <buffer> sa <Plug>(FlogSortAuthor)
" nmap <buffer> st <Plug>(FlogSortTopo)
" nmap <buffer> sr <Plug>(FlogToggleReverse)

nmap <buffer> o <CR>
nmap <buffer> p <CR><C-w>lzMggzj<C-w>h

nmap <buffer> r<Space> :Floggit rebase<Space>

nmap <buffer> <leader>. <Plug>(FlogStartCommand)
nnoremap <buffer> . :<C-U>Floggit<Space><Space><C-R>=flog#Format('%H')<CR><S-Left><Left>

nmap <buffer> cf :<C-U>call flog#run_command('Git commit --fixup=%h', 0, 1)<CR>
nmap <buffer> cp :<C-U>call flog#run_command('Git cherry-pick %h', 0, 1)<CR>
nmap <buffer> gR :<C-U>call flog#run_command('Git reset HEAD^', 0, 1)<CR>
nmap <buffer> ca :Floggit commit --amend<CR>
nmap <buffer> <silent> J u:Flogjump HEAD<CR>zz
" nmap <buffer> czz :Floggit stash push<CR>
" nmap <buffer> czp :Floggit stash pop<CR>
