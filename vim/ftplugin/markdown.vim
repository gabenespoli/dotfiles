"" general
set spell       " enable live spell checking

"" keybindings
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap zz zz

nnoremap <localleader>S :set spell!<CR>
nnoremap <localleader>s 1z=
nnoremap <localleader>d :r! echo "\#\# `date '+\%Y-\%m-\%d'`"<CR>o
nnoremap gd :Gdiff<CR>:windo set wrap<CR>

nnoremap <localleader>0 :s/^#*\ *//ge<CR>
nnoremap <localleader>1 :s/^#*\ */#\ /ge<CR>
nnoremap <localleader>2 :s/^#*\ */##\ /ge<CR>
nnoremap <localleader>3 :s/^#*\ */###\ /ge<CR>
nnoremap <localleader>4 :s/^#*\ */####\ /ge<CR>
nnoremap <localleader>5 :s/^#*\ */#####\ /ge<CR>
nnoremap <localleader>6 :s/^#*\ */######\ /ge<CR>


"" highlights
hi NonText ctermfg=8
" make html tags solarized base colors so they blend into the background
hi htmlString ctermfg=11
hi htmlTagName ctermfg=11

" Critic Markdown Plugin
" nnoremap <localleader>a :Critic accept<CR>
" nnoremap <localleader>r :Critic reject<CR>
" nnoremap <localleader>h :call criticmarkup#InjectHighlighting()<CR>
" nnoremap <localleader>c F{df}
nnoremap <localleader>k /{==\\|{>>\\|{++\\|{--<CR>
nnoremap <localleader>K ?{==\\|{>>\\|{++\\|{--<CR>

"" Pandoc Plugin
au VimEnter * :set syntax=pandoc
let g:pandoc#modules#enabled = ["command","completion","keyboard"]
let g:pandoc#keyboard#enabled_submodules = ["sections"]
let g:pandoc#biblio#sources = "g"
let g:pandoc#biblio#bibs = ["~/dotfiles/pandoc/library.bib"]
let g:pandoc#completion#bib#mode = "citeproc"
let g:pandoc#command#autoexec_on_writes = 0
let g:pandoc#command#autoexec_command = "Pandoc docx --reference-docx=~/dotfiles/pandoc/apa.docx"

"" Pandoc Syntax
let g:pandoc#syntax#conceal#use = 0
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
endfunc
au VimEnter * :call PandocForceHighlighting()
nnoremap <localleader>i :call PandocForceHighlighting()<CR>

