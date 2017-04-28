"set nonumber    " don't show line numbers
set spell       " enable live spell checking
nnoremap <localleader>S :set spell!<CR>
nnoremap <localleader>s 1z=
nnoremap <localleader>d :r! echo "\#\# `date '+\%Y-\%m-\%d'`"<CR>o
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
    hi pandocAtxStart ctermfg=7 ctermbg=0
    hi pandocAtxHeader cterm=bold ctermfg=15 ctermbg=0
    hi pandocOperator ctermfg=darkgrey
    hi pandocStrong cterm=bold ctermfg=15
    syn match mdTodo /^\s*TODO.*/
    hi link mdTodo Todo

    hi criticAdd cterm=reverse ctermfg=2 ctermbg=8
    hi criticDel cterm=reverse ctermfg=1 ctermbg=8
    hi criticMeta cterm=reverse ctermfg=6 ctermbg=8
    hi criticHighlighter cterm=reverse ctermfg=3 ctermbg=8
endfunc
au VimEnter * :call GabePandocForce()
nnoremap <localleader>i :call GabePandocForce()<CR>
