silent! unmap <buffer> <C-p>
silent! unmap <buffer> <C-n>
nmap <buffer> } ]]o
nmap <buffer> { [[o

" git command maps
nnoremap <buffer> co<Space> :Git checkout<Space>
nnoremap <buffer> cb :Git branch<Space>
nnoremap <buffer> ri<Space> :Grebase -i --autosquash<Space>

nnoremap <buffer> coo :Git checkout <C-r>=gv#sha()<CR><CR>
nnoremap <buffer> cf :Git commit --fixup <C-r>=gv#sha()<CR><CR>
nnoremap <buffer> cp :Git cherry-pick <C-r>=gv#sha()<CR><CR>
nnoremap <buffer> gR :Git reset HEAD^<CR>
nnoremap <buffer> rii j:Grebase -i --autosquash <C-r>=gv#sha()<CR><CR>
nnoremap <buffer> rim :Grebase -i --autosquash master<CR>

" refresh maps
nnoremap <buffer> R :close<CR>:GV --all<CR>
nnoremap <buffer> <C-r> :close<CR>:GV<CR>
nnoremap <buffer> gL :close<CR>:GV --all<CR>
nnoremap <buffer> gl :close<CR>:GV <CR>
