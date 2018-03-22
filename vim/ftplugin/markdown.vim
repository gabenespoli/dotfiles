" general {{{1
setlocal spell       " enable live spell checking
set tabstop=4        " number of visual spaces per TAB
set softtabstop=4    " number of spaces in tab when editing
set shiftwidth=4

" keybindings {{{1
" general {{{2
nnoremap <buffer> <localleader>S :set spell!<CR>
" nnoremap <buffer> <localleader>s 1z=
nnoremap <buffer> <localleader>gd :Gdiff<CR>:windo set wrap<CR>:call PandocForceHighlighting()<CR>

" move up and down by visual line {{{2
noremap <buffer> <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <buffer> <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <buffer> <silent> <expr> gj (v:count == 0 ? 'j' : 'gj')
noremap <buffer> <silent> <expr> gk (v:count == 0 ? 'k' : 'gk')

" headings {{{2
nnoremap <buffer> <localleader>0 :s/^#*\ *//ge<CR>
nnoremap <buffer> <localleader>1 :s/^#*\ */#\ /ge<CR>
nnoremap <buffer> <localleader>2 :s/^#*\ */##\ /ge<CR>
nnoremap <buffer> <localleader>3 :s/^#*\ */###\ /ge<CR>
nnoremap <buffer> <localleader>4 :s/^#*\ */####\ /ge<CR>
nnoremap <buffer> <localleader>5 :s/^#*\ */#####\ /ge<CR>
nnoremap <buffer> <localleader>6 :s/^#*\ */######\ /ge<CR>

" criticmarkup and cite.py {{{2
" insert tags with tpope/vim-surround plugin
let b:surround_43 = "{++\r++}"
let b:surround_45 = "{--\r--}"
let b:surround_61 = "{==\r==}"
let b:surround_60 = "{>>\r<<}"
let b:surround_62 = "{>>\r<<}"

" remove tags with surround (sort of)
nmap <buffer> <localleader>ds+ ds{ds+ds+
nmap <buffer> <localleader>ds= ds{ds=ds=
nmap <buffer> <localleader>ds- ds{ds-ds-

" insert comments
nnoremap <buffer> <localleader>cc i{>>Gabe Nespoli: <<}<Esc>hhi
nnoremap <buffer> <localleader>ct i{>>TODO: <<}<Esc>hhi

" remove tags (highlights, whole tags, accept/reject)
nnoremap <buffer> <localleader>chd F{xxxf}XXx
nnoremap <buffer> <localleader>cd F{df}
nnoremap <buffer> <localleader>ca :Critic accept<CR>
nnoremap <buffer> <localleader>cr :Critic reject<CR>

" search and highlight
nnoremap <buffer> <localleader>cf /{==\\|{>>\\|{++\\|{--<CR>
nnoremap <buffer> <localleader>cF ?{==\\|{>>\\|{++\\|{--<CR>
nnoremap <buffer> <localleader>cH :call criticmarkup#InjectHighlighting()<CR>

" cite.py (include here because of similar keybindings)
nnoremap <buffer> <localleader>cb :execute "!python $HOME/bin/cite/cite.py -b <C-r><C-w>"<CR>
nnoremap <buffer> <localleader>cN :execute "!python $HOME/bin/cite/cite.py -n <C-r><C-w>"<CR>
nnoremap <buffer> <localleader>cn :vs ~/papernotes/<C-r><C-w>.md<CR>
nnoremap <buffer> <localleader>co :silent execute "!python $HOME/bin/cite/cite.py <C-r><C-w>"<CR><C-l>
nnoremap <buffer> <localleader>cp :python $HOME/bin/cite/cite.py 

" folding {{{1
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
        return ' ▸ YAML '
    else
        let temp = substitute(line, '#\s', ' ▸ ', 'g')
        let sub = substitute(temp, '#', '  ', 'g')
        return sub
    endif
endfunction

" highlights {{{1
" highlight current sentence
nnoremap ]k :echo search('\.', 'c')<CR>v(
nnoremap [k :echo search('\.', 'bc')<CR>v(
nmap <localleader>k ]k

vnoremap ]k <Esc>):echo search('\.')<CR>v(
vnoremap [k <Esc>:echo search('\.', 'b')<CR>v(
vmap n ]k
vmap p [k
vnoremap <localleader>k <Esc>

" note: colors are based on the solarized 16 color palette
hi htmlString ctermfg=11
hi htmlTagName ctermfg=11

" because critic markdown never sticks
autocmd BufEnter * call criticmarkup#InjectHighlighting()

" Pandoc Plugin settings {{{1
au VimEnter * :set syntax=pandoc
au VimEnter,BufEnter * :call PandocForceHighlighting()
nnoremap <buffer> <localleader>i :call PandocForceHighlighting()<CR>

" function to force custom pandoc highlighting
function! PandocForceHighlighting()
    hi pandocEmphasis cterm=none ctermfg=7
    hi pandocStrongEmphasis cterm=none ctermfg=15
    hi pandocEmphasisInStrong cterm=none ctermfg=7
    hi pandocStrongInEmphasis cterm=none ctermfg=7
    " hi pandocAtxStart ctermfg=7 ctermbg=0
    " hi pandocAtxHeader cterm=bold ctermfg=15 ctermbg=0
    hi! link pandocAtxStart Title
    hi! link pandocAtxHeader Title
    hi pandocOperator ctermfg=darkgrey
    hi pandocStrong cterm=bold ctermfg=15
    syn match mdTodo /^\s*TODO.*/
    hi link mdTodo Todo
endfunction

" capitalL location list settings {{{1
let b:Lpatterns = ['/{>>\|{==\|{++\|{--/gj %', '/^\s*TODO/gj %']
let b:Lreformat = ['/[^{]*\({>>\|{==\|{++\|{--\)\([^}]*}\).*$/\1\2/ge', '/[^|]*|[^|]*|\s*\(TODO.*\)$/\1/ge']
