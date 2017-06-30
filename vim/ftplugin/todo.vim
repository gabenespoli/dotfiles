"" general
"autocmd BufLeave * execute "write"

"" keybindings
""" defaults (copied from todo-txt.vim/plugin/todo.vim)
noremap <silent><localleader>sc :call todo#HierarchicalSort('@', '', 1)<CR>
noremap <silent><localleader>scp :call todo#HierarchicalSort('@', '+', 1)<CR>
noremap <silent><localleader>sp :call todo#HierarchicalSort('+', '',1)<CR>
noremap <silent><localleader>spc :call todo#HierarchicalSort('+', '@',1)<CR>
nnoremap <script> <silent> <buffer> <LocalLeader>s :call todo#Sort()<CR>
nnoremap <script> <silent> <buffer> <LocalLeader>s@ :sort /.\{-}\ze@/ <CR>
nnoremap <script> <silent> <buffer> <LocalLeader>s+ :sort /.\{-}\ze+/ <CR>
noremap <script> <silent> <buffer> <LocalLeader>j :call todo#PrioritizeIncrease()<CR>
noremap <script> <silent> <buffer> <LocalLeader>k :call todo#PrioritizeDecrease()<CR>
noremap <script> <silent> <buffer> <LocalLeader>a :call todo#PrioritizeAdd('A')<CR>
noremap <script> <silent> <buffer> <LocalLeader>b :call todo#PrioritizeAdd('B')<CR>
noremap <script> <silent> <buffer> <LocalLeader>c :call todo#PrioritizeAdd('C')<CR>
inoremap <script> <silent> <buffer> date<Tab> <C-R>=strftime("%Y-%m-%d")<CR>
inoremap <script> <silent> <buffer> due: due:<C-R>=strftime("%Y-%m-%d")<CR>
inoremap <script> <silent> <buffer> DUE: DUE:<C-R>=strftime("%Y-%m-%d")<CR>
noremap <script> <silent> <buffer> <localleader>d :call todo#PrependDate()<CR>
noremap <script> <silent> <buffer> <localleader>x :call todo#ToggleMarkAsDone('')<CR>
noremap <script> <silent> <buffer> <localleader>C :call todo#ToggleMarkAsDone('Cancelled')<CR>
noremap <script> <silent> <buffer> <localleader>X :call todo#MarkAllAsDone()<CR>
nnoremap <script> <silent> <buffer> <localleader>D :call todo#RemoveCompleted()<CR>
nnoremap <script> <silent> <buffer> <localleader>sd :call todo#SortDue()<CR>


""" priority ([d]oing, [t]oday, [w]eek, [n]ext week)
nnoremap <buffer> <localleader>d :call todo#PrioritizeAdd('D')<CR>
nnoremap <buffer> <localleader>t :call todo#PrioritizeAdd('T')<CR>
nnoremap <buffer> <localleader>w :call todo#PrioritizeAdd('W')<CR>
nnoremap <buffer> <localleader>n :call todo#PrioritizeAdd('N')<CR>
nnoremap <buffer> <localleader>z :call todo#RemovePriority()<CR>
nnoremap <buffer> <localleader><localleader> :call todo#RemovePriority()<CR>:call todo#MarkAsDone('')<CR>ddGp''

""" moving lines
nnoremap <buffer> H dd<C-w>hP
nnoremap <buffer> J :move +1<CR>
nnoremap <buffer> K :move -2<CR>
nnoremap <buffer> L dd<C-w>lP

""" task points (1 2 3 5 8)
nnoremap <buffer> <localleader>1 :call TodoAddTaskPoints(1)<CR>
nnoremap <buffer> <localleader>2 :call TodoAddTaskPoints(2)<CR>
nnoremap <buffer> <localleader>3 :call TodoAddTaskPoints(3)<CR>
nnoremap <buffer> <localleader>4 :call TodoAddTaskPoints(5)<CR>
nnoremap <buffer> <localleader>5 :call TodoAddTaskPoints(5)<CR>
nnoremap <buffer> <localleader>6 :call TodoAddTaskPoints(5)<CR>
nnoremap <buffer> <localleader>7 :call TodoAddTaskPoints(8)<CR>
nnoremap <buffer> <localleader>8 :call TodoAddTaskPoints(8)<CR>
nnoremap <buffer> <localleader>9 :call TodoAddTaskPoints(13)<CR>
nnoremap <buffer> <localleader>0 :call TodoAddTaskPoints(0)<CR>

""" misc
nnoremap <buffer> <localleader>ss :sort<CR>


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
    syn match TodoHeading /^#\s.*/
    hi link TodoHeading MarkdownH1
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

" function! TodoAddToTaskWarrior()
" " prepend 'task add ', call vim-slime, delete 'task add '
"     execute "s/+/proj:/ge"
"     execute "s/@/+/ge"
"     execute "s/(\\(\\d*\\))/pts:\\1/ge"
"     execute "normal! Itask add "
"     execute "normal! A && printf \"\\033c\" && task"

"     execute "normal \<Plug>SlimeLineSend"

"     execute "normal! $d25hx"
"     execute "s/^task\ add\ //ge"
"     execute "s/pts:\\(\\d*\\)/(\\1)/ge"
"     execute "s/+/@/ge"
"     execute "s/proj:/+/ge"
"     execute "normal! Ix "
" endfunction
" nnoremap <C-t> :call TodoAddToTaskWarrior()<CR>

