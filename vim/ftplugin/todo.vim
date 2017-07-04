" vim plugin for todo.txt files
" some ideas are take from 

"" keybindings
""" priority
" [d]oing, [t]oday, [w]eek, [r]emove, [x] is mark as done and move to bottom
" first try to remove priority, then add
nnoremap <localleader>a :s/^([A-Z])\s//ge<CR>I(A) <Esc>
nnoremap <localleader>b :s/^([A-Z])\s//ge<CR>I(B) <Esc>
nnoremap <localleader>c :s/^([A-Z])\s//ge<CR>I(C) <Esc>
nnoremap <localleader>d :s/^([A-Z])\s//ge<CR>I(D) <Esc>
nnoremap <localleader>t :s/^([A-Z])\s//ge<CR>I(T) <Esc>
nnoremap <localleader>w :s/^([A-Z])\s//ge<CR>I(W) <Esc>
nnoremap <localleader>r :s/^([A-Z])\s//ge<CR>
nnoremap <localleader>x :s/^([A-Z])\s//ge<CR>Ix<Esc>"=strftime(" %Y-%m-%d ")<CR>pddGp''

""" moving lines
nnoremap <buffer> H dd<C-w>hP
nnoremap <buffer> J :move +1<CR>
nnoremap <buffer> K :move -2<CR>
nnoremap <buffer> L dd<C-w>lP

""" task points (1 2 3 5 8)
nnoremap <localleader>1 :s/\ pts:\d*//ge<CR>A pts:1<Esc>
nnoremap <localleader>2 :s/\ pts:\d*//ge<CR>A pts:2<Esc>
nnoremap <localleader>3 :s/\ pts:\d*//ge<CR>A pts:3<Esc>
nnoremap <localleader>5 :s/\ pts:\d*//ge<CR>A pts:5<Esc>
nnoremap <localleader>8 :s/\ pts:\d*//ge<CR>A pts:8<Esc>
nnoremap <localleader>9 :s/\ pts:\d*//ge<CR>A pts:13<Esc>
nnoremap <localleader>0 :s/\ pts:\d*//ge<CR>

""" misc
nnoremap <buffer> <localleader>ss :sort<CR>
nnoremap <localleader>i :windo call TodoHighlighting(1)<CR>
nnoremap <localleader>X :call todo#RemoveCompleted()<CR>

"" functions
function! TodoHighlighting(winnum)
    syn match TodoPriorityA /^(A).*/ contains=TodoProject,TodoContext,TodoTag
    syn match TodoPriorityB /^(B).*/ contains=TodoProject,TodoContext,TodoTag
    syn match TodoPriorityC /^(C).*/ contains=TodoProject,TodoContext,TodoTag
    syn match TodoDone /^x\ \d\d\d\d-\d\d-\d\d\ .*/
    syn match TodoProject /+\S*/
    syn match TodoContext /@\S*/
    syn match TodoTag /\S*:\S*/
    hi NonText ctermfg=8
    execute a:winnum . "wincmd w"
endfunction
autocmd VimEnter * windo call TodoHighlighting(1)

"" from todo-txt.vim
" these function are taken from https://github.com/freitass/todo.txt-vim
function! todo#RemoveCompleted()
    " Check if we can write to done.txt before proceeding.
    let l:target_dir = expand('%:p:h')
    if exists("g:TodoTxtForceDoneName")
        let l:done=g:TodoTxtForceDoneName
    else
        let l:done=substitute(substitute(expand('%:t'),'todo','done',''),'Todo','Done','')
    endif
    let l:done_file = l:target_dir.'/'.l:done
    echo "Writing to ".l:done_file
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

