" Vello: vim plugin to manage multiple lists like Trello

"" general
setlocal cursorbind
setlocal norelativenumber
autocmd BufEnter <buffer> setlocal cursorline
autocmd BufLeave <buffer> setlocal nocursorline

"" keybindings
""" cursor movement
nnoremap <buffer> h <C-w>h0
nnoremap <buffer> j j
nnoremap <buffer> k k
nnoremap <buffer> l <C-w>l0

""" moving lines
nnoremap <buffer> H dd<C-w>hP
nnoremap <buffer> J :move +1<CR>
nnoremap <buffer> K :move -2<CR>
nnoremap <buffer> L dd<C-w>lP

""" task points (1 2 3 5 8)
nnoremap <localleader>1 :call VelloAddTaskPoints(1)<CR>
nnoremap <localleader>2 :call VelloAddTaskPoints(2)<CR>
nnoremap <localleader>3 :call VelloAddTaskPoints(3)<CR>
nnoremap <localleader>4 :call VelloAddTaskPoints(5)<CR>
nnoremap <localleader>5 :call VelloAddTaskPoints(5)<CR>
nnoremap <localleader>6 :call VelloAddTaskPoints(5)<CR>
nnoremap <localleader>7 :call VelloAddTaskPoints(8)<CR>
nnoremap <localleader>8 :call VelloAddTaskPoints(8)<CR>
nnoremap <localleader>9 :call VelloAddTaskPoints(13)<CR>
nnoremap <localleader>0 :call VelloAddTaskPoints(0)<CR>

"" highlighting

"" functions
""" syntax matches
function! VelloForceHighlighting(winnum)
    syn match VelloHeading /^#.*/
    syn match VelloTaskPoints /(\d*)/
    hi NonText ctermfg=8
    hi link VelloHeading Title
    hi VelloTaskPoints ctermfg=2 ctermbg=0
    execute a:winnum . "wincmd w"
endfunction
autocmd VimEnter * windo call VelloForceHighlighting(1)
nnoremap <localleader>i :windo call VelloForceHighlighting(1)<CR>

""" add task points
function! VelloAddTaskPoints(val)
    " remove previous task points
    execute "s/\ (\\d*)$//ge"
    if a:val > 0
        execute "normal! A (" . a:val . ")"
        execute "normal! 0"
    endif
endfunction

