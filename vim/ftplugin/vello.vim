" Vello: vim plugin to manage multiple lists like Trello

"" general
setlocal cursorbind
autocmd BufEnter <buffer> setlocal cursorline
autocmd BufLeave <buffer> setlocal nocursorline
autocmd BufWrite <buffer> execute "normal! 0"

"" keybindings
" the '0f]l' is to move the cursor off of the checkbox
""" entering insert mode
" nnoremap <buffer> o o[ ] 
" nnoremap <buffer> O O[ ] 
" nnoremap <buffer> I 0f]la
" nnoremap <buffer> <Enter> <Enter>[ ] 

nnoremap <C-t> :call AddToTaskWarrior()<CR>

""" cursor movement
" nnoremap <buffer> h <C-w>h
nnoremap <buffer> j j
nnoremap <buffer> k k
" nnoremap <buffer> l <C-w>l

""" moving lines
nnoremap <buffer> H dd<C-w>hP
nnoremap <buffer> J :move +1<CR>
nnoremap <buffer> K :move -2<CR>
nnoremap <buffer> L dd<C-w>lP

""" task points (1 2 3 5 8)
nnoremap <localleader>1 :call VelloAddTaskPoints(1)<CR>
nnoremap <localleader>2 :call VelloAddTaskPoints(2)<CR>
nnoremap <localleader>3 :call VelloAddTaskPoints(3)<CR>
nnoremap <localleader>4 :call VelloAddTaskPoints(5)<CR>
nnoremap <localleader>5 :call VelloAddTaskPoints(5)<CR>
nnoremap <localleader>6 :call VelloAddTaskPoints(5)<CR>
nnoremap <localleader>7 :call VelloAddTaskPoints(8)<CR>
nnoremap <localleader>8 :call VelloAddTaskPoints(8)<CR>
nnoremap <localleader>9 :call VelloAddTaskPoints(13)<CR>
nnoremap <localleader>0 :call VelloAddTaskPoints(0)<CR>

""" checkboxes
nnoremap <buffer> <localleader>X :s/^x\ //ge<CR>
nnoremap <buffer> <localleader>x 0ix 
" nnoremap <buffer> <localleader><Space> I[ ] <Esc>0
" nnoremap <buffer> <localleader>X :s/^\[.\]/\[\ \]/e<CR>
" nnoremap <buffer> <localleader>x :s/^\[.\]/\[x\]/e<CR>
" nnoremap <buffer> <localleader>m :s/^\[.\]/\[M\]/e<CR>
" nnoremap <buffer> <localleader>t :s/^\[.\]/\[T\]/e<CR>
" nnoremap <buffer> <localleader>w :s/^\[.\]/\[W\]/e<CR>
" nnoremap <buffer> <localleader>r :s/^\[.\]/\[R\]/e<CR>
" nnoremap <buffer> <localleader>f :s/^\[.\]/\[F\]/e<CR>
" nnoremap <buffer> <localleader>s :s/^\[.\]/\[S\]/e<CR>
" nnoremap <buffer> <localleader>u :s/^\[.\]/\[U\]/e<CR>


"" functions
""" syntax matches
function! VelloForceHighlighting(winnum)
    syn match VelloHeading /^#.*/
    syn match VelloTaskPoints /(\d*)$/
    syn match VelloTaskPoints /pts:\d*/
    syn match VelloProject /+\S*/
    syn match VelloContext /+@\S*/
    syn match VelloProject /project:\S*/
    syn match VelloProject /proj:\S*/
    syn match VelloContext /@\S*/
    " syn match VelloDoneCheckbox /^\[x\].*/
    syn match VelloDoneCheckbox /^x\ .*/

    hi VelloHeading ctermfg=15 ctermbg=10
    hi VelloTaskPoints ctermfg=2 ctermbg=8
    hi VelloProject ctermfg=4 ctermbg=0
    hi VelloContext ctermfg=13 ctermbg=8
    hi VelloDoneCheckbox ctermfg=10

    hi NonText ctermfg=8
    execute a:winnum . "wincmd w"
endfunction
autocmd VimEnter * windo call VelloForceHighlighting(1)
nnoremap <localleader>i :windo call VelloForceHighlighting(1)<CR>

""" add task points
function! VelloAddTaskPoints(val)
    " remove previous task points
    execute "s/\ (\\d*)$//ge"
    if a:val > 0
        execute "normal! A (" . a:val . ")"
        execute "normal! 0"
    endif
endfunction

"" add to taskwarrior with vim-slime
" prepend 'task add ', call vim-slime, delete 'task add '
function! AddToTaskWarrior()
    execute "s/+/proj:/ge"
    execute "s/@/+/ge"
    execute "s/(\\(\\d*\\))/pts:\\1/ge"
    execute "normal! Itask add "

    execute "normal \<Plug>SlimeLineSend"

    execute "s/^task\ add\ //ge"
    execute "s/pts:\\(\\d*\\)/(\\1)/ge"
    execute "s/+/@/ge"
    execute "s/proj:/+/ge"
    execute "normal! Ix "
endfunction
