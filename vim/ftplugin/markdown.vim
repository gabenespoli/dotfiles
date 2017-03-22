set nonumber
set spell
nnoremap <localleader>s 1z=

" make html tags solarized base colors so they blend into the background
hi htmlString ctermfg=11
hi htmlTagName ctermfg=11

" Critic Markdown Plugin
nnoremap <localleader>a :Critic accept<CR>
nnoremap <localleader>r :Critic reject<CR>
nnoremap <localleader>h :call criticmarkup#InjectHighlighting()<CR>
nnoremap <localleader>c F{df}

" CenWin Plugin
"nnoremap <localleader>l :call CenWinOutlineToggle()<CR>
"nnoremap <localleader>q :call CenWinTodoToggle()<CR>

" Pandoc Plugin
au VimEnter * :set syntax=pandoc
" force some pandoc highlighting cause it always screws up
" (especially italics (emphasis); why is this always cterm=reverse?!)
"au VimEnter * hi pandocEmphasis cterm=none ctermfg=7
"au VimEnter * hi pandocStrongEmphasis cterm=none ctermfg=15
"au VimEnter * hi pandocStrongInEmphasis cterm=none ctermfg=15
"au VimEnter * hi pandocEmphasisInStrong cterm=none ctermfg=7

"nnoremap <localleader>i :<CR>:syn match mdTodo /^TODO.*/<CR>:hi link mdTodo Todo<CR>
":hi clear markdownItalic<CR>:hi markdownItalic ctermfg=7<CR>

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

" GitGutter Plugin
"au VimEnter * :GitGutterDisable
