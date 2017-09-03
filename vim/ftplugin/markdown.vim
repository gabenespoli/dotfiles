"" general {{{1
set spell       " enable live spell checking

"" keybindings {{{1
""" general {{{2
nnoremap <buffer> zz zz
nnoremap <buffer> <localleader>S :set spell!<CR>
nnoremap <buffer> <localleader>s 1z=
nnoremap <buffer> <leader>gd :Gdiff<CR>:windo set wrap<CR>:call PandocForceHighlighting()<CR>

""" move up and down by visual line {{{2
noremap <buffer> <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <buffer> <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <buffer> <silent> <expr> gj (v:count == 0 ? 'j' : 'gj')
noremap <buffer> <silent> <expr> gk (v:count == 0 ? 'k' : 'gk')

""" headings {{{2
nnoremap <buffer> <localleader>0 :s/^#*\ *//ge<CR>
nnoremap <buffer> <localleader>1 :s/^#*\ */#\ /ge<CR>
nnoremap <buffer> <localleader>2 :s/^#*\ */##\ /ge<CR>
nnoremap <buffer> <localleader>3 :s/^#*\ */###\ /ge<CR>
nnoremap <buffer> <localleader>4 :s/^#*\ */####\ /ge<CR>
nnoremap <buffer> <localleader>5 :s/^#*\ */#####\ /ge<CR>
nnoremap <buffer> <localleader>6 :s/^#*\ */######\ /ge<CR>

""" folding {{{2
set foldmethod=expr
set foldexpr=GetMarkdownFolds(v:lnum)
set foldtext=GetMarkdownFoldText()
let g:tagbar_foldlevel = 2

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

""" pandoc highlighting issues {{{2
nnoremap <buffer> <localleader>i :call PandocForceHighlighting()<CR>

"" highlights {{{1
" note: colors are based on the solarized 16 color palette
hi NonText ctermfg=8
hi htmlString ctermfg=11
hi htmlTagName ctermfg=11

"" Pandoc Plugin settings {{{1
au VimEnter * :set syntax=pandoc
let g:pandoc#modules#enabled = ["command","bibliographies","completion","keyboard"]
let g:pandoc#keyboard#enabled_submodules = ["sections"]
let g:pandoc#biblio#sources = "g"
let g:pandoc#biblio#bibs = ["/Users/gmac/dotfiles/pandoc/library.bib", "/home/efgh/dotfiles/pandoc/library.bib"]
let g:pandoc#command#autoexec_on_writes = 0
let g:pandoc#command#autoexec_command = "Pandoc docx --reference-docx=~/dotfiles/pandoc/apa.docx"
let g:pandoc#syntax#conceal#use = 0

"" function to force custom pandoc highlighting {{{1
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

"" capitalL location list settings {{{1
let b:Lpatterns = ['{>>\|{==\|{++\|{--', '^\s*TODO']
let b:Lreformat = ['[^{]*\({>>\|{==\|{++\|{--\)\([^}]*}\).*$/\1\2', '[^|]*|[^|]*|\s*\(TODO.*\)$/\1']
