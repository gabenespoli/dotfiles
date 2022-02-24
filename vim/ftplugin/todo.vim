setlocal tabstop=4 softtabstop=4 shiftwidth=4

" toggle done
nnoremap <buffer> <C-x> :call TotesToggleDone()<CR>
function TotesToggleDone() abort
  normal! m`
  let l:todo = '- \[ \]'
  let l:done = '- \[x\]'
  let l:line = getline(line('.'))
  if match(l:line, l:todo) >= 0
    execute 's/'.l:todo.'/'.l:done.'/'
  elseif match(l:line, l:done) >= 0
    execute 's/'.l:done.'/'.l:todo.'/'
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
    if l:line =~# '^#'
      return '>1'
    elseif l:line =~# '^\S'
      return '>2'
    else
      return '='
    endif
endfunction
