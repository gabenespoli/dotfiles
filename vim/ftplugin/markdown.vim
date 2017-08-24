"" general
set spell       " enable live spell checking

""" folding
set foldmethod=expr
set foldexpr=GetMarkdownFolds(v:lnum)
set foldtext=GetMarkdownFoldText()

function! GetMarkdownFolds(lnum)
    if getline(a:lnum) =~ '^#'
        return '>1'
    else
        return '='
    endif
endfunction

function! GetMarkdownFoldText()
    let line = getline(v:foldstart)
    let temp = substitute(line, '^#', '', 'g')
    let sub = substitute(temp, '#', '  ', 'g')
    return '+--' . sub . ' '
endfunction

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
    if (getline(a:lnum) =~ '^#') || (a:lnum == 1 && getline(1) =~ '^---$')
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
" au VimEnter,BufEnter <buffer> execute "call CriticVimGrep()"
nnoremap <localleader>q :call CriticQFToggle()<CR>
nnoremap <localleader>Qh :let g:qfpos = 'topleft vertical'<CR>
nnoremap <localleader>Qj :let g:qfpos = ''<CR>
nnoremap <localleader>Qk :let g:qfpos = 'top'<CR>
nnoremap <localleader>Ql :let g:qfpos = 'vertical'<CR>

function! CriticVimGrep()
    execute 'silent vimgrep /{>>\|{==\|{++\|{--\|TODO/j %'
endfunction

function! CriticQFResize()
    if exists('g:qfstatus') && g:qfstatus > 0 && exists('g:qfpos')
        let currentBuffer = bufnr('%')
        execute  g:qfstatus . ' wincmd w'
        execute 'call CriticQFSetSize(g:qfpos)'
        execute currentBuffer . ' wincmd w'
    endif
endfunction

function! CriticQFOpen()
    if !exists('g:qfpos')
        let g:qfpos = 'vertical'
    endif
    execute g:qfpos.' copen'
    execute 'call CriticQFSetSize(g:qfpos)'
endfunction

function! CriticQFSetSize(pos)
    if exists('g:sidepanel_width')
        let width = g:sidepanel_width
    elseif exists('$COLS')
        let width = ($COLS - 100) / 2
    else
        let width = 40
    endif
    if a:pos =~ 'vertical'
        execute 'vertical resize ' . width
    else
        execute 'resize ' . width
    endif
endfunction

function! CriticQFToggle()
    if !exists('g:qfstatus')
        let g:qfstatus = 0
    endif
    if g:qfstatus > 0
        execute 'cclose'
        let g:qfstatus = 0
    else
        execute 'call CriticVimGrep()'
        execute 'call CriticQFOpen()'
        let g:qfstatus = bufnr('%')
        execute 'set modifiable'
        silent! %s/[^{]*\({>>\|{==\|{++\|{--\)\([^}]*}\).*$/\1\2/ge
        execute 'set nomodified'
        normal! gg
    endif
endfunction
