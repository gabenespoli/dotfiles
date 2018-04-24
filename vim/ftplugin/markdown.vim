" general {{{1
setlocal spell       " enable live spell checking
set tabstop=4        " number of visual spaces per TAB
set softtabstop=4    " number of spaces in tab when editing
set shiftwidth=4
set nonumber norelativenumber

" keybindings {{{1
" general {{{2
nnoremap <buffer> <localleader>S :set spell!<CR>
nnoremap <buffer> gd :Gdiff<CR>:windo set wrap<CR>
inoremap <buffer> <S-CR> <CR>-<space>
inoremap <buffer> <S-C-j> <CR>-<space>

" move up and down by visual line
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
nnoremap <buffer> <localleader>t i{>>TODO: <<}<Esc>hhi
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
nnoremap <buffer> <localleader>co :silent execute "!python $HOME/bin/cite/cite.py <C-r><C-w>"<CR><C-l>
nnoremap <buffer> <localleader>cp :python $HOME/bin/cite/cite.py 

nnoremap <buffer> gn :call GoNotes('<C-r><C-a>', 1)<CR>
nnoremap <buffer> gN :call GoNotes('<C-r><C-a>', 0)<CR>

let g:GoNotesQuitKeymap = "q"

if !exists("g:GoNotesLoaded") || g:GoNotesLoaded == 0
  let g:GoNotesLoaded = 1

  function! GoNotes(word, ...)
    let l:word = a:word

    if l:word[0:1] == "[@" || l:word[0:2] == "[-@"
      let l:do_word = 1
    else
      let l:do_word = 0
    endif

    if l:do_word
      " parse WORD object to get just the word
      let l:word = substitute(l:word, "[", "", "")
      let l:word = substitute(l:word, "]", "", "")
      let l:word = substitute(l:word, "@", "", "")
      if l:word[0] == "-"
        let l:word = l:word[1:]
      endif
      let l:filename = "$HOME/lib/papernotes/" . l:word . ".md"

    else
      let l:filename = expand("%:r") . "_notes" . "." . expand("%:e")

    endif

    if a:0 > 0 && a:1 == 0
      let l:do_split = 0
    else
      let l:do_split = 1
    endif

    if l:do_split
      if exists('g:MuttonEnabled') && g:MuttonEnabled == 1
        execute "MuttonToggle"
        let l:MuttonEnabled = 1
      else
        let l:MuttonEnabled = 0
      endif

      execute "vsplit " . l:filename

      if exists("g:GoNotesQuitKeymap")
        if l:MuttonEnabled == 1
          execute "nnoremap <buffer> " . g:GoNotesQuitKeymap . " :q<CR>:MuttonToggle<CR>"
        else
          execute "nnoremap <buffer> " . g:GoNotesQuitKeymap . " :q<CR>"
        endif
      endif

    else
      " TODO save the cursor position so we can move it back there on quit
      let l:bufnr = bufnr("%")
      execute "edit " . l:filename
      if exists("g:GoNotesQuitKeymap")
        execute "nnoremap <buffer> " . g:GoNotesQuitKeymap . " :buffer " . l:bufnr . "<CR>"
      endif
    endif

  endfunction

endif

" folding {{{1
set foldmethod=expr
set foldexpr=GetMarkdownFolds(v:lnum)
" set foldtext=GetMarkdownSimpleFoldText()
let g:tagbar_foldlevel = 2
let b:foldtextwidth = -4

function! GetMarkdownFolds(lnum)
    let line = getline(a:lnum) 
    " if line =~ '^###'
        " return '>3'
    " elseif line =~ '^##'
        " return '>2'
    if (line =~ '^#') || (a:lnum == 1 && line =~ '^---$')
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
        return sub . ' '
    endif
endfunction

" highlights {{{1
" highlight current sentence
nnoremap <buffer> ]k :echo search('\.', 'c')<CR>v(
nnoremap <buffer> [k :echo search('\.', 'bc')<CR>v(
nmap <buffer> <localleader>k ]k

vnoremap <buffer> ]k <Esc>):echo search('\.')<CR>v(
vnoremap <buffer> [k <Esc>:echo search('\.', 'b')<CR>v(
vmap <buffer> n ]k
vmap <buffer> p [k
vnoremap <buffer> <localleader>k <Esc>

" vim-pandoc plugin {{{1
" because vim-pandoc-syntax is loaded after the colorscheme
au VimEnter,BufEnter * :execute "colorscheme ".g:colors_name

" gabenespoli/capitalL plugin {{{1
let b:Lpatterns = ['/{>>\|{==\|{++\|{--/gj %', '/^\s*TODO/gj %']
let b:Lreformat = ['/[^{]*\({>>\|{==\|{++\|{--\)\([^}]*}\).*$/\1\2/ge', '/[^|]*|[^|]*|\s*\(TODO.*\)$/\1/ge']
