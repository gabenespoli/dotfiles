set number norelativenumber
set laststatus=0
nnoremap <localleader>0 :call todo#RemovePriority()<CR>
nnoremap <localleader><localleader> :sort<CR>
nnoremap <localleader>ss :sort<CR>

"" these lines are changed in .vim/bundle/todo-txt.vim/syntax/todo.vim to omit the leading bol/space. they don't work here for some reason
" syntax  match  TodoProject    '\(^\|\W\)+[^[:blank:]]\+'  contains=NONE
" syntax  match  TodoContext    '\(^\|\W\)@[^[:blank:]]\+'  contains=NONE
" syn match TodoProject /+\S*/
" syn match TodoContext /@\S*/

source $HOME/dotfiles/vim/ftplugin/vello.vim
