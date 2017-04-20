set norelativenumber
set nonumber    " don't show line numbers
set spell       " enable live spell checking
nnoremap <localleader>S :set spell!<CR>
nnoremap <localleader>s 1z=
"au VimEnter * :GitGutterDisable

hi NonText ctermfg=8

" make html tags solarized base colors so they blend into the background
hi htmlString ctermfg=11
hi htmlTagName ctermfg=11

" Critic Markdown Plugin
nnoremap <localleader>a :Critic accept<CR>
nnoremap <localleader>r :Critic reject<CR>
nnoremap <localleader>h :call criticmarkup#InjectHighlighting()<CR>
nnoremap <localleader>c F{df}

" Pandoc Plugin
au VimEnter * :set syntax=pandoc
"au VimEnter * :call CenWinEnable()
function! GabePandocForce()
    hi pandocEmphasis cterm=none ctermfg=7
    hi pandocStrongEmphasis cterm=none ctermfg=15
    hi pandocEmphasisInStrong cterm=none ctermfg=7
    hi pandocStrongInEmphasis cterm=none ctermfg=7
    hi pandocAtxStart ctermfg=7
    hi pandocAtxHeader cterm=bold ctermfg=15
    hi pandocOperator ctermfg=darkgrey
    hi pandocStrong cterm=bold ctermfg=15
    syn match mdTodo /^\s*TODO.*/
    hi link mdTodo Todo
endfunc
au VimEnter * :call GabePandocForce()
nnoremap <localleader>i :call GabePandocForce()<CR>
