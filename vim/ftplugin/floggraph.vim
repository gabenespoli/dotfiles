" need gs for git status, so use gS instead
nmap <buffer> gS <Plug>(FlogVSplitStaged)

nmap ) <Plug>(FlogVNextCommitRight)
nmap ( <Plug>(FlogVPrevCommitRight)

nmap <buffer> o <CR>
nmap <buffer> p <CR><C-w>lzMggzj<C-w>h

nmap <buffer> r<Space> :Floggit rebase<Space>

nmap <buffer> <leader>. <Plug>(FlogStartCommand)
nnoremap <buffer> . :<C-U>Floggit<Space><Space><C-R>=flog#Format('%H')<CR><S-Left><Left>

nmap <buffer> cf :<C-U>call flog#Exec('Git commit --fixup=%h')<CR>
" nmap <buffer> cp :<C-U>call flog#Exec('Git cherry-pick %h')<CR>
nmap <buffer> gR :<C-U>call flog#Exec('Git reset HEAD^')<CR>
nmap <buffer> ca :Floggit commit --amend<CR>
nmap <buffer> <silent> J u:Flogjump HEAD<CR>zz
" nmap <buffer> czz :Floggit stash push<CR>
" nmap <buffer> czp :Floggit stash pop<CR>
