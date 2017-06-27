"" general
set number norelativenumber
" setlocal cursorbind
set laststatus=0
autocmd BufLeave * execute "write"
autocmd BufEnter * execute "edit"

"" keybindings
nnoremap <localleader>z :call todo#RemovePriority()<CR>
nnoremap <localleader><localleader> :call todo#RemovePriority()<CR>:call todo#MarkAsDone('')<CR>ddGp''
nnoremap <localleader>ss :sort<CR>
nnoremap <C-t> :call TodoAddToTaskWarrior()<CR>

""" moving lines
nnoremap <buffer> H dd<C-w>hP
nnoremap <buffer> J :move +1<CR>
nnoremap <buffer> K :move -2<CR>
nnoremap <buffer> L dd<C-w>lP

""" task points (1 2 3 5 8)
nnoremap <localleader>1 :call TodoAddTaskPoints(1)<CR>
nnoremap <localleader>2 :call TodoAddTaskPoints(2)<CR>
nnoremap <localleader>3 :call TodoAddTaskPoints(3)<CR>
nnoremap <localleader>4 :call TodoAddTaskPoints(5)<CR>
nnoremap <localleader>5 :call TodoAddTaskPoints(5)<CR>
nnoremap <localleader>6 :call TodoAddTaskPoints(5)<CR>
nnoremap <localleader>7 :call TodoAddTaskPoints(8)<CR>
nnoremap <localleader>8 :call TodoAddTaskPoints(8)<CR>
nnoremap <localleader>9 :call TodoAddTaskPoints(13)<CR>
nnoremap <localleader>0 :call TodoAddTaskPoints(0)<CR>

"" syntax highlighting
""" these lines are changed in .vim/bundle/todo-txt.vim/syntax/todo.vim to omit the leading bol/space. they don't work here for some reason
" syntax  match  TodoProject    '\(^\|\W\)+[^[:blank:]]\+'  contains=NONE
" syntax  match  TodoContext    '\(^\|\W\)@[^[:blank:]]\+'  contains=NONE
" syn match TodoProject /+\S*/
" syn match TodoContext /@\S*/
hi NonText ctermfg=8

"" functions
function! TodoHighlighting(winnum)
    syn match TodoTaskPoints /(\d*)$/
    syn match TodoTaskPoints /pts:\d*/
    execute a:winnum . "wincmd w"
endfunction
autocmd VimEnter * windo call TodoHighlighting(1)
nnoremap <localleader>i :windo call TodoHighlighting(1)<CR>

function! TodoAddTaskPoints(val)
    " remove previous task points
    execute "s/\ (\\d*)$//ge"
    if a:val > 0
        execute "normal! A (" . a:val . ")"
        execute "normal! 0"
    endif
endfunction

function! TodoAddToTaskWarrior()
" prepend 'task add ', call vim-slime, delete 'task add '
    execute "s/+/proj:/ge"
    execute "s/@/+/ge"
    execute "s/(\\(\\d*\\))/pts:\\1/ge"
    execute "normal! Itask add "
    execute "normal! A && printf \"\\033c\" && task"

    execute "normal \<Plug>SlimeLineSend"

    execute "normal! $d25hx"
    execute "s/^task\ add\ //ge"
    execute "s/pts:\\(\\d*\\)/(\\1)/ge"
    execute "s/+/@/ge"
    execute "s/proj:/+/ge"
    execute "normal! Ix "
endfunction

