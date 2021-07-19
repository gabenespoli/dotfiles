setlocal tabstop=4 softtabstop=4 shiftwidth=4

" keybindings {{{1
" mark as done
nnoremap <buffer> <localleader>x :s/\m^\(([A-Z])\s\)\{0,1\}/x\ <C-R>=strftime("%Y-%m-%d")<CR>\ /<CR>
inoremap <buffer> t() <C-R>=strftime("%Y-%m-%d")<CR>
inoremap <buffer> tb() (<C-R>=strftime("%Y-%m-%d")<CR>)
nnoremap <buffer> <localleader>D A (<C-R>=strftime("%Y-%m-%d")<CR>)<Esc>

" priority
" first try to remove priority, then add
nnoremap <buffer> <localleader>a :s/\m^\(([A-Z])\s\)\{0,1\}/(A)\ /<CR>
nnoremap <buffer> <localleader>b :s/\m^\(([A-Z])\s\)\{0,1\}/(B)\ /<CR>
nnoremap <buffer> <localleader>c :s/\m^\(([A-Z])\s\)\{0,1\}/(C)\ /<CR>
nnoremap <buffer> <localleader>d :s/\m^\(([A-Z])\s\)\{0,1\}/(D)\ /<CR>
nnoremap <buffer> <localleader>m :s/\m^\(([A-Z])\s\)\{0,1\}/(M)\ /<CR>
nnoremap <buffer> <localleader>t :s/\m^\(([A-Z])\s\)\{0,1\}/(T)\ /<CR>
nnoremap <buffer> <localleader>w :s/\m^\(([A-Z])\s\)\{0,1\}/(W)\ /<CR>
nnoremap <buffer> <localleader>r :s/\m^\(([A-Z])\s\)\{0,1\}/(R)\ /<CR>
nnoremap <buffer> <localleader>f :s/\m^\(([A-Z])\s\)\{0,1\}/(F)\ /<CR>
" remove priority
nnoremap <buffer> <localleader>z :s/\m^([A-Z])\s//ge<CR>

" misc
nnoremap <buffer> <localleader>s :sort<CR>
nnoremap <buffer> <localleader>i :windo call TodoHighlighting(1)<CR>
nnoremap <buffer> <localleader>X :call todo#RemoveCompleted()<CR>
nnoremap <buffer> <localleader>n :call TodoToggleNext()<CR>

if has('mac')
  nnoremap <buffer> gx :call GoToJira()<CR>
  function! GoToJira()
    let l:jira_key = ''

    for l:word in split(getline('.'), '\[\|\]')
      if match(l:word, '\u\+-\d\+') > -1
        let l:jira_key = l:word
        break
      endif
    endfor

    if l:jira_key == ''
      echo "No JIRA key found on this line"
    else
      let l:url = 'https://jira.sonova.com/browse/' . l:jira_key
      execute 'silent !open ' . shellescape(l:url)
    endif

  endfunction
endif

" folding {{{1
" any line that starts with whitespace will fold into the task above
setlocal foldmethod=expr
setlocal foldexpr=TodoFold(v:lnum)
function! TodoFold(lnum) "{{{
    let l:line = getline(a:lnum) 
    if l:line =~# '^\S'
      return '>1'
    else
      return '='
    endif
endfunction "}}}

" functions {{{1
" https://github.com/freitass/todo.txt-vim

function! todo#RemoveCompleted()  "{{{
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
endfunction  "}}}

function! s:AppendToFile(file, lines)  "{{{
    let l:lines = []

    " Place existing tasks in done.txt at the beggining of the list.
    if filereadable(a:file)
        call extend(l:lines, readfile(a:file))
    endif

    " Append new completed tasks to the list.
    call extend(l:lines, a:lines)

    " Write to file.
    call writefile(l:lines, a:file)
endfunction  "}}}

function! TodoToggleX()  "{{{
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
endfunction  "}}}

function! TodoToggleNext()  "{{{
  execute 'normal! 0'
  if search('!next', 'cn') == line('.') 
    execute 's/ !next//ge'
  else
    execute 's/$/ !next/ge'
  endif
  execute 'write'
endfunction  "}}}
