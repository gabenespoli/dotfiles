" breakpoints {{{1
" if moving this to a general-use plugin:
" - have a variable to define the command used to set and clear breakpoints
" - have variable to define the program to send the command to the repl

" define the breakpoint sign
execute 'sign define MatlabBreakpoint text=$> linehl= texthl=ErrorMsg'

function! MatlabSetBreakpoint()
  let l:bufnr = bufnr("%")
  let l:fname = expand("%:t")
  let l:line = line(".")
  execute 'sign place ' . l:line . ' line='.l:line . ' name=MatlabBreakpoint ' . ' buffer=' . l:bufnr
  execute 'SlimeSend1 dbstop in ' . l:fname . ' at ' . l:line
endfunction

function! MatlabClearBreakpoint()
  " clear all breakpoints in file
  " this is easier than dealing with line numbers changing during editing
  let l:bufnr = bufnr("%")
  let l:fname = expand("%:t")
  execute 'sign unplace * buffer=' . l:bufnr
  execute 'SlimeSend1 dbclear in ' . l:fname
endfunction

nnoremap <buffer> <localleader>b :call MatlabSetBreakpoint()<CR>
nnoremap <buffer> <localleader>c :call MatlabClearBreakpoint()<CR>

nnoremap <buffer> <localleader>o :execute 'SlimeSend1 dbstep'<CR>
nnoremap <buffer> <localleader>i :execute 'SlimeSend1 dbstep in'<CR>
nnoremap <buffer> <localleader>t :execute 'SlimeSend1 dbstep out'<CR>
nnoremap <buffer> <localleader>q :execute 'SlimeSend1 dbquit'<CR>
nnoremap <buffer> <localleader>g :execute 'SlimeSend1 dbcont'<CR>
