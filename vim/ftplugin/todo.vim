setlocal tabstop=4 softtabstop=4 shiftwidth=4

inoremap -- - [ ]
inoremap >> > [ ]

" toggle done
nnoremap <buffer> K :call TotesToggleDone()<CR>
nnoremap <buffer> <leader>d :call TotesToggleDone()<CR>
function TotesToggleDone() abort
  normal! m`
  let l:todo = '- '
  let l:grup = '> '
  let l:open = '\[ \]'
  let l:done = '\[x\]'
  let l:line = getline(line('.'))

  if match(l:line, l:todo.l:open) >= 0
    execute 's/'.l:todo.l:open.'/'.l:todo.l:done.'/'
  elseif match(l:line, l:todo.l:done) >= 0
    execute 's/'.l:todo.l:done.'/'.l:todo.l:open.'/'
  elseif match(l:line, l:grup.l:open) >= 0
    execute 's/'.l:grup.l:open.'/'.l:grup.l:done.'/'
  elseif match(l:line, l:grup.l:done) >= 0
    execute 's/'.l:grup.l:done.'/'.l:grup.l:open.'/'
  endif
  normal! ``
endfunction

" insert dates
inoremap <buffer> ()t <C-R>=strftime("%Y-%m-%d")<CR>
inoremap <buffer> ()tb (<C-R>=strftime("%Y-%m-%d")<CR>)
nnoremap <buffer> <localleader>D A (<C-R>=strftime("%Y-%m-%d")<CR>)<Esc>

" fold markdown headings and sub-tasks
" (any line that starts with whitespace will fold into the task above)
setlocal foldmethod=expr
setlocal foldexpr=TodoFold(v:lnum)
function! TodoFold(lnum)
    let l:line = getline(a:lnum) 
    if l:line =~# '^-'
      return '2'
    elseif l:line =~# '^# '
      return '>1'
    elseif l:line =~# '^## '
      return '>2'
    elseif l:line =~# '^>'
      return '>3'
    elseif l:line =~# '^$'
      return '>3'
    else
      return '='
    endif
endfunction
