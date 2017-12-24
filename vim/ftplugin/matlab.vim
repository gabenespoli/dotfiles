" breakpoints {{{1
" if moving this to a general-use plugin:
" - have a variable to define the command used to set and clear breakpoints
" - have variable to define the program to send the command to the repl

" define the breakpoint sign
execute 'sign define MatlabBreakpoint text=$ linehl= texthl=ErrorMsg'

function! MatlabSetBreakpoint()
  let l:fname = expand("%:p")
  let l:line = line(".")
  execute 'sign place ' . l:line . ' line='.l:line . ' name=MatlabBreakpoint ' . ' file='.l:fname
  execute 'SlimeSend1 dbstop in ' . l:fname . ' at ' . l:line
endfunction

function! MatlabClearBreakpoint()
  let l:fname = expand("%:p")
  let l:line = line(".")
  execute 'sign unplace ' . l:line . ' file='.l:fname
  execute 'SlimeSend1 dbclear in ' . l:fname . ' at ' . l:line
endfunction

nnoremap <buffer> <localleader>b :call MatlabSetBreakpoint()<CR>
nnoremap <buffer> <localleader>c :call MatlabClearBreakpoint()<CR>


" for vim-matlab plugin {{{1
" nnoremap <buffer> <localleader>tt :MatlabLaunchServer<CR>
" nnoremap <buffer><silent> <localleader>w :MatlabCliOpenWorkspace<CR>

" nnoremap <buffer>         <localleader>rn :MatlabRename
" nnoremap <buffer><silent> <localleader>fn :MatlabFixName<CR>
" vnoremap <buffer><silent> <localleader>b <ESC>:MatlabCliRunSelection<CR>
" nnoremap <buffer><silent> <localleader>b <ESC>:MatlabCliRunCell<CR>
" nnoremap <buffer><silent> <localleader>ll :MatlabCliRunLine<CR>
" nnoremap <buffer>         <localleader>pp vip:MatlabCliRunSelection<CR>
" nnoremap <buffer><silent> <localleader>v <ESC>:MatlabCliViewVarUnderCursor<CR>
" vnoremap <buffer><silent> <localleader>V <ESC>:MatlabCliViewSelectedVar<CR>
" nnoremap <buffer><silent> <localleader>h <ESC>:MatlabCliHelp<CR>
" nnoremap <buffer><silent> <localleader>e <ESC>:MatlabCliOpenInMatlabEditor<CR>
" nnoremap <buffer><silent> <localleader>c :MatlabCliCancel<CR>
