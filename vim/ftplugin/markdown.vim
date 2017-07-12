"" general
set spell       " enable live spell checking

"" keybindings
""" general
nnoremap zz zz
nnoremap <localleader>S :set spell!<CR>
nnoremap <localleader>s 1z=
nnoremap <localleader>d :r! echo "\#\# `date '+\%Y-\%m-\%d'`"<CR>o
nnoremap gd :Gdiff<CR>:windo set wrap<CR>

""" move up and down by visual line
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

""" headings
nnoremap <localleader>0 :s/^#*\ *//ge<CR>
nnoremap <localleader>1 :s/^#*\ */#\ /ge<CR>
nnoremap <localleader>2 :s/^#*\ */##\ /ge<CR>
nnoremap <localleader>3 :s/^#*\ */###\ /ge<CR>
nnoremap <localleader>4 :s/^#*\ */####\ /ge<CR>
nnoremap <localleader>5 :s/^#*\ */#####\ /ge<CR>
nnoremap <localleader>6 :s/^#*\ */######\ /ge<CR>

""" pandoc highlighting issues
nnoremap <localleader>i :call PandocForceHighlighting()<CR>
nnoremap <localleader>e :call FauxCenwinOpen()<CR>:call PandocForceHighlighting()<CR>
nnoremap <localleader>E :call FauxCenwinClose()<CR>:call PandocForceHighlighting()<CR>

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
au VimEnter * :call PandocForceHighlighting()

