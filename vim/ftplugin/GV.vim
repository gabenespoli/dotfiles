silent! unmap <buffer> <C-p>
silent! unmap <buffer> <C-n>
nmap <buffer> } ]]o
nmap <buffer> { [[o
nnoremap <buffer> co<Space> :Git co<Space>
nnoremap <buffer> cob :Git co -b<Space>
nnoremap <buffer> coo :Git co <C-r>=gv#sha()<CR><CR>
nnoremap <buffer> rii j:Grebase -i <C-r>=gv#sha()<CR><CR>
nnoremap <buffer> rim :Grebase -i master<CR>
nnoremap <buffer> cf :Git commit --fixup <C-r>=gv#sha()<CR><CR>
nnoremap <buffer> gR :Git reset HEAD^<CR>
nmap <buffer> cp .cp<CR>
nnoremap <buffer> R :close<CR>:GV --all<CR>
