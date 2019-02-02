" vim plugin for my own version of todos
" based heavily on todo.txt
" some ideas are taken directly from the todo-txt.vim plugin

" keybindings {{{1
" change char type {{{2
nnoremap <buffer> <localleader>- 0r-
" nnoremap <buffer> <localleader>x 0rx
nnoremap <buffer> <localleader>* 0r*
nnoremap <buffer> <localleader>! 0r!
nnoremap <buffer> <localleader>> 0r>
nnoremap <buffer> <localleader>x :s/^([A-Z])\s//ge<CR>Ix<Esc>"=strftime(" %Y-%m-%d ")<CR>pddGp''

" priority {{{2
" [d]oing, [t]oday, [w]eek, [r]emove, [x] is mark as done and move to bottom
" first try to remove priority, then add
nnoremap <buffer> <localleader>a :s/^([A-Z])\s//ge<CR>I(A) <Esc>
nnoremap <buffer> <localleader>b :s/^([A-Z])\s//ge<CR>I(B) <Esc>
nnoremap <buffer> <localleader>c :s/^([A-Z])\s//ge<CR>I(C) <Esc>
nnoremap <buffer> <localleader>d :s/^([A-Z])\s//ge<CR>I(D) <Esc>

nnoremap <buffer> <localleader>m :s/^([A-Z])\s//ge<CR>I(M) <Esc>
nnoremap <buffer> <localleader>t :s/^([A-Z])\s//ge<CR>I(T) <Esc>
nnoremap <buffer> <localleader>w :s/^([A-Z])\s//ge<CR>I(W) <Esc>
nnoremap <buffer> <localleader>r :s/^([A-Z])\s//ge<CR>I(R) <Esc>
nnoremap <buffer> <localleader>f :s/^([A-Z])\s//ge<CR>I(F) <Esc>
nnoremap <buffer> <localleader>s :s/^([A-Z])\s//ge<CR>I(S) <Esc>
nnoremap <buffer> <localleader>u :s/^([A-Z])\s//ge<CR>I(U) <Esc>

nnoremap <buffer> <localleader>z :s/^([A-Z])\s//ge<CR>

" points (1 2 3 5 8) {{{2
nnoremap <buffer> <localleader>1 :s/\ pts:\d*//ge<CR>A pts:1<Esc>
nnoremap <buffer> <localleader>2 :s/\ pts:\d*//ge<CR>A pts:2<Esc>
nnoremap <buffer> <localleader>3 :s/\ pts:\d*//ge<CR>A pts:3<Esc>
nnoremap <buffer> <localleader>5 :s/\ pts:\d*//ge<CR>A pts:5<Esc>
nnoremap <buffer> <localleader>8 :s/\ pts:\d*//ge<CR>A pts:8<Esc>
nnoremap <buffer> <localleader>9 :s/\ pts:\d*//ge<CR>A pts:13<Esc>
nnoremap <buffer> <localleader>0 :s/\ pts:\d*//ge<CR>

" misc {{{2
nnoremap <buffer> <localleader>S :sort<CR>
nnoremap <buffer> <localleader>i :windo call TodoHighlighting(1)<CR>
nnoremap <buffer> <localleader>X :call todo#RemoveCompleted()<CR>
nnoremap <buffer> <localleader>n :call TodoToggleNext()<CR>
" nnoremap <buffer> x :call TodoToggleX()<CR>

" folding {{{1
setlocal foldmethod=expr
setlocal foldexpr=GetTodoFolds(v:lnum)

function! GetTodoFolds(lnum)
  if getline(a:lnum) =~# '^#'
    return '>1'
  elseif getline(a:lnum) =~# '^\/\/'
    return '>1'
  elseif getline(a:lnum) =~# '^.*:$'
    return '>1'
  else
    return '='
  endif
endfunction

" functions {{{1

" from todo-txt.vim
" these functions are taken from https://github.com/freitass/todo.txt-vim
function! todo#RemoveCompleted()
    " Check if we can write to done.txt before proceeding.
    let l:target_dir = expand('%:p:h')
    if exists('g:TodoTxtForceDoneName')
        let l:done=g:TodoTxtForceDoneName
    else
        let l:done=substitute(substitute(expand('%:t'),'todo','done',''),'Todo','Done','')
    endif
    let l:done_file = l:target_dir.'/'.l:done
    echo 'Writing to '.l:done_file
    if !filewritable(l:done_file) && !filewritable(l:target_dir)
        echoerr "Can't write to file '".l:done_file."'"
        return
    endif

    let l:completed = []
    :g/^x /call add(l:completed, getline(line(".")))|d
    call s:AppendToFile(l:done_file, l:completed)
endfunction

function! s:AppendToFile(file, lines)
    let l:lines = []

    " Place existing tasks in done.txt at the beggining of the list.
    if filereadable(a:file)
        call extend(l:lines, readfile(a:file))
    endif

    " Append new completed tasks to the list.
    call extend(l:lines, a:lines)

    " Write to file.
    call writefile(l:lines, a:file)
endfunction

function! TodoToggleX()
  let l:beforeChar = getline('.')[col('.')-2]
  let l:currentChar = getline('.')[col('.')-1]
  let l:afterChar = getline('.')[col('.')]
  if l:beforeChar ==# '[' && l:afterChar ==# ']'
    if l:currentChar ==? 'x'
      normal! r 
    elseif l:currentChar ==# ' '
      normal! rx
    endif
  else
    normal! x
  endif
endfunction

function! TodoToggleNext()
  execute 'normal! 0'
  if search('!next', 'cn') == line('.') 
    execute 's/ !next//ge'
  else
    execute 's/$/ !next/ge'
  endif
  execute 'write'
endfunction

" capitalL plugin settings {{{1
let g:Lposition = 'left'
let b:Lsyntax = 'todo'
let b:Lpatterns = ['/!next/gj %', '/!waiting/gj %']
let b:Lreformat = ['/[^|]*|[^|]*|\s/', '/[^|]*|[^|]*|\s/']

