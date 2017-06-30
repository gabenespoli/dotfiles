" vim plugin for todo.txt files
" some ideas are take from 

"" keybindings
""" priority
" [d]oing, [t]oday, [w]eek, [r]emove, [x] is mark as done and move to bottom
" first try to remove priority, then add
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
nnoremap <localleader>1 :s/\ (\d*)$//ge<CR>A (1)<Esc>
nnoremap <localleader>2 :s/\ (\d*)$//ge<CR>A (2)<Esc>
nnoremap <localleader>3 :s/\ (\d*)$//ge<CR>A (3)<Esc>
nnoremap <localleader>5 :s/\ (\d*)$//ge<CR>A (5)<Esc>
nnoremap <localleader>8 :s/\ (\d*)$//ge<CR>A (8)<Esc>
nnoremap <localleader>9 :s/\ (\d*)$//ge<CR>A (13)<Esc>
nnoremap <localleader>0 :s/\ (\d*)$//ge<CR>

""" misc
nnoremap <buffer> <localleader>ss :sort<CR>

"" functions
function! TodoHighlighting(winnum)
    syn match TodoWeek /^(W)/
    syn match TodoToday /^(T)/
    syn match TodoDoing /^(D)/
    syn match TodoDone /^x\ \d\d\d\d-\d\d-\d\d\ .*/
    syn match TodoProject /+\S*/
    syn match TodoContext /@\S*/
    syn match TodoTaskPoints /(\d*)$/
    syn match TodoTaskPoints /pts:\d*/
    syn match TodoHeading /^#\s.*/
    hi link TodoHeading MarkdownH1
    hi NonText ctermfg=8
    execute a:winnum . "wincmd w"
endfunction
autocmd VimEnter * windo call TodoHighlighting(1)
nnoremap <localleader>i :windo call TodoHighlighting(1)<CR>
