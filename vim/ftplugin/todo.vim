" keybindings {{{1
" mark as done
nnoremap <buffer> <localleader>x :s/\m^\(([A-Z])\s\)\{0,1\}/x\ <C-R>=strftime("%Y-%m-%d")<CR>\ /<CR>

" priority
" first try to remove priority, then add
nnoremap <buffer> <localleader>a :s/\m^\(([A-Z])\s\)\{0,1\}/(A)\ /<CR>
nnoremap <buffer> <localleader>b :s/\m^\(([A-Z])\s\)\{0,1\}/(B)\ /<CR>
nnoremap <buffer> <localleader>c :s/\m^\(([A-Z])\s\)\{0,1\}/(C)\ /<CR>
nnoremap <buffer> <localleader>d :s/\m^\(([A-Z])\s\)\{0,1\}/(D)\ /<CR>
" remove priority
nnoremap <buffer> <localleader>z :s/\m^([A-Z])\s//ge<CR>

" misc
nnoremap <buffer> <localleader>s :sort<CR>
nnoremap <buffer> <localleader>i :windo call TodoHighlighting(1)<CR>
nnoremap <buffer> <localleader>X :call todo#RemoveCompleted()<CR>
nnoremap <buffer> <localleader>n :call TodoToggleNext()<CR>

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
