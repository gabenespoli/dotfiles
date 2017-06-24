
"" general
setlocal norelativenumber
au BufEnter 

"" keybindings
""" cursor movement
nnoremap <buffer> h :setlocal nocursorline<CR><C-w>h0:setlocal cursorline<CR>
nnoremap <buffer> l :setlocal nocursorline<CR><C-w>l0:setlocal cursorline<CR>

""" moving cards around TODO
nnoremap <buffer> H dd<C-w>hp
nnoremap <buffer> L dd<C-w>lp
nnoremap <buffer> J ddp
nnoremap <buffer> K 

""" task points (1 2 3 5 8)
nnoremap <localleader>1 :call AddTaskPoints(1)<CR>
nnoremap <localleader>2 :call AddTaskPoints(2)<CR>
nnoremap <localleader>3 :call AddTaskPoints(3)<CR>
nnoremap <localleader>4 :call AddTaskPoints(5)<CR>
nnoremap <localleader>5 :call AddTaskPoints(5)<CR>
nnoremap <localleader>6 :call AddTaskPoints(5)<CR>
nnoremap <localleader>7 :call AddTaskPoints(8)<CR>
nnoremap <localleader>8 :call AddTaskPoints(8)<CR>
nnoremap <localleader>9 :call AddTaskPoints(13)<CR>
nnoremap <localleader>0 :call AddTaskPoints(0)<CR>

"" colors
hi NonText ctermfg=8
match MarkdownH1 /^#.*/

"" functions
""" add task points
function! AddTaskPoints(val)
    " remove previous task points
    execute "s/\ (\\d*)$//ge"
    if a:val > 0
        execute "normal! A (" . a:val . ")"
        execute "normal! 0"
    endif
endfunction

"TODO function to move between lists keeping the same line number

"" syntax
execute "syntax match TaskPoints /(\\d)$/"
highlight TaskPoints ctermfg=2 ctermbg=0
