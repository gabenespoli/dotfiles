"" general
set spell       " enable live spell checking

"" keybindings
""" general
nnoremap <buffer> zz zz
nnoremap <buffer> <localleader>S :set spell!<CR>
nnoremap <buffer> <localleader>s 1z=
nnoremap <buffer> <leader>gd :Gdiff<CR>:windo set wrap<CR>:call PandocForceHighlighting()<CR>

""" move up and down by visual line
noremap <buffer> <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <buffer> <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <buffer> <silent> <expr> gj (v:count == 0 ? 'j' : 'gj')
noremap <buffer> <silent> <expr> gk (v:count == 0 ? 'k' : 'gk')

""" headings
nnoremap <buffer> <localleader>0 :s/^#*\ *//ge<CR>
nnoremap <buffer> <localleader>1 :s/^#*\ */#\ /ge<CR>
nnoremap <buffer> <localleader>2 :s/^#*\ */##\ /ge<CR>
nnoremap <buffer> <localleader>3 :s/^#*\ */###\ /ge<CR>
nnoremap <buffer> <localleader>4 :s/^#*\ */####\ /ge<CR>
nnoremap <buffer> <localleader>5 :s/^#*\ */#####\ /ge<CR>
nnoremap <buffer> <localleader>6 :s/^#*\ */######\ /ge<CR>

""" folding
set foldmethod=expr
set foldexpr=GetMarkdownFolds(v:lnum)
set foldtext=GetMarkdownFoldText()

function! GetMarkdownFolds(lnum)
    let current = getline(a:lnum) 
    " if current =~ '^###'
        " return '>3'
    " elseif current =~ '^##'
        " return '>2'
    if (current =~ '^#') || (a:lnum == 1 && current =~ '^---$')
        return '>1'
    else
        return '='
    endif
endfunction

function! GetMarkdownFoldText()
    let line = getline(v:foldstart)
    if line == '---'
        return '+-- YAML '
    else
        let temp = substitute(line, '^#', '', 'g')
        let sub = substitute(temp, '#', '  ', 'g')
        return '+--' . sub . ' '
    endif
endfunction

""" pandoc highlighting issues
nnoremap <buffer> <localleader>i :call PandocForceHighlighting()<CR>

"" highlights
" note: colors are based on the solarized 16 color palette
hi NonText ctermfg=8
hi htmlString ctermfg=11
hi htmlTagName ctermfg=11

"" Pandoc Plugin settings
au VimEnter * :set syntax=pandoc
let g:pandoc#modules#enabled = ["command","completion","keyboard"]
let g:pandoc#keyboard#enabled_submodules = ["sections"]
let g:pandoc#biblio#sources = "g"
let g:pandoc#biblio#bibs = ["~/dotfiles/pandoc/library.bib"]
let g:pandoc#completion#bib#mode = "citeproc"
let g:pandoc#command#autoexec_on_writes = 0
let g:pandoc#command#autoexec_command = "Pandoc docx --reference-docx=~/dotfiles/pandoc/apa.docx"
let g:pandoc#syntax#conceal#use = 0

"" function to force custom pandoc highlighting
function! PandocForceHighlighting()
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
endfunction
au VimEnter,BufEnter * :call PandocForceHighlighting()

"" quickfix list with critic comments and todos
" au VimEnter,BufEnter <buffer> execute "call Lvimgrep()"
nnoremap <leader>l :call Ltoggle()<CR>
nnoremap <localleader>lh :let g:Lpos = 'topleft vertical'<CR>
nnoremap <localleader>lj :let g:Lpos = ''<CR>
nnoremap <localleader>lk :let g:Lpos = 'top'<CR>
nnoremap <localleader>ll :let g:Lpos = 'vertical'<CR>

function! Lvimgrep()
    execute 'silent lvimgrep /{>>\|{==\|{++\|{--\|TODO/j %'
endfunction

function! Lopen()
    if !exists('g:Lpos')
        let g:Lpos = 'vertical'
    endif
    let currentWindow = bufwinnr('%')
    execute 'call Lvimgrep()'
    execute g:Lpos.' lopen'
    execute 'set modifiable'
    silent! %s/[^{]*\({>>\|{==\|{++\|{--\)\([^}]*}\).*$/\1\2/ge
    execute 'set nomodified'
    execute 'call L_ResizeCurrentWindow(g:Lpos)'
    normal! gg
    let g:Lbufnr = bufnr('%')
    execute currentWindow . ' wincmd w'
endfunction

function! Lclose()
    execute 'lclose'
    let g:Lbufnr = 0
    if exists('g:sidepanel_isopen') && g:sidepanel_isopen == 1
        execute 'SidePanelWidth ' . g:sidewidth
        execute 'wincmd w'
    endif
endfunction

function! Ltoggle()
    if !exists('g:Lbufnr')
        let g:Lbufnr = 0
    endif
    if g:Lbufnr > 0
        execute 'call Lclose()'
    else
        execute 'call Lopen()'
    endif
endfunction

function! Lresize()
    " switch to loclist, then call L_ResizeCurrentWindow, switch back
    if exists('g:Lbufnr') && g:Lbufnr > 0 && exists('g:Lpos')
        let currentWindow = bufwinnr('%')
        execute  bufwinnr(g:Lbufnr) . ' wincmd w'
        execute 'call L_ResizeCurrentWindow(g:Lpos)'
        execute currentWindow . ' wincmd w'
    endif
endfunction

function! L_ResizeCurrentWindow(pos)
    if a:pos =~ 'vertical'
        if exists('g:sidewidth')
            let width = g:sidewidth
        elseif exists('$COLS')
            let width = ($COLS - 100) / 2
        elseif exists('g:sidepanel_width')
            let width = g:sidepanel_width
        else
            let width = 40
        endif
        execute 'vertical resize ' . width

    else
        if exists('g:sideheight')
            let height = g:sideheight
        else
            let height = 8
        endif
        execute 'resize ' . height

    endif
endfunction
