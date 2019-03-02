" general {{{1
setlocal textwidth=0
setlocal wrap spell nonumber norelativenumber
setlocal tabstop=4 softtabstop=4 shiftwidth=4

" folding {{{1
setlocal foldmethod=expr
setlocal foldexpr=GetMarkdownFolds(v:lnum)
function! GetMarkdownFolds(lnum) "{{{
    let l:line = getline(a:lnum) 
    if (l:line =~# '^#') || (a:lnum == 1 && l:line =~# '^---$')
        return '>1'
    else
        return '='
    endif
endfunction "}}}

" move up and down by visual line {{{1
noremap <buffer> <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <buffer> <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <buffer> <silent> <expr> gj (v:count == 0 ? 'j' : 'gj')
noremap <buffer> <silent> <expr> gk (v:count == 0 ? 'k' : 'gk')
inoremap <buffer> <silent> <expr> <C-n> (v:count == 0 && !pumvisible() ? '<C-o>gj' : '<C-n>')
inoremap <buffer> <silent> <expr> <C-p> (v:count == 0 && !pumvisible() ? '<C-o>gk' : '<C-p>')

" add markdown headings {{{1
nnoremap <buffer> <localleader>1 :silent! s/^#\{1,6\}\ //g<CR>I#<Space><Esc>
nnoremap <buffer> <localleader>2 :silent! s/^#\{1,6\}\ //g<CR>I##<Space><Esc>
nnoremap <buffer> <localleader>3 :silent! s/^#\{1,6\}\ //g<CR>I###<Space><Esc>
nnoremap <buffer> <localleader>4 :silent! s/^#\{1,6\}\ //g<CR>I####<Space><Esc>
nnoremap <buffer> <localleader>5 :silent! s/^#\{1,6\}\ //g<CR>I#####<Space><Esc>
nnoremap <buffer> <localleader>6 :silent! s/^#\{1,6\}\ //g<CR>I######<Space><Esc>

" pandoc preview (uses macOS open command) {{{1
nnoremap <buffer> <localleader>pp :!pandoc % -o %.pdf<CR>:!open %.pdf<CR><CR>
nnoremap <buffer> <localleader>ph :!pandoc % -o %.html<CR>:!open %.html<CR><CR>
nnoremap <buffer> <localleader>pd :!pandoc % -o %.docx<CR>:!open %.docx<CR><CR>

" criticmarkup {{{1
" insert a todo item as a comment
nmap <buffer> <localleader>t i{>>TODO: <<}<C-o>3h

" highlight visual selection, insert comment after it
xmap <buffer> <localleader>c <localleader>ehf}a<Space><Esc>v<localleader>ecxi

" delete around or surround critic tags ("undo")
nmap <buffer> <localleader>u F{3xf}2h3x

" search for critic tags
nnoremap <buffer> <localleader>/ /{==\\|{>>\\|{++\\|{--<CR>
nnoremap <buffer> <localleader>? ?{==\\|{>>\\|{++\\|{--<CR>

" force reset highlighting
nnoremap <buffer> <localleader>H :call criticmarkup#InjectHighlighting()<CR>

" sentence highlights {{{1
nnoremap <buffer> ]k :echo search('\.', 'c')<CR>v(
nnoremap <buffer> [k :echo search('\.', 'bc')<CR>v(
nmap <buffer> <localleader>k ]k

vnoremap <buffer> ]k <Esc>):echo search('\.')<CR>v(
vnoremap <buffer> [k <Esc>:echo search('\.', 'b')<CR>v(
vnoremap <buffer> <localleader>k <Esc>

" GoNotes plugin {{{1
nnoremap <buffer> gn :call GoNotes('<C-r><C-a>', 1)<CR>
nnoremap <buffer> gN :call GoNotes('<C-r><C-a>', 0)<CR>

let g:GoNotesQuitKeymap = 'q'

if !exists('g:GoNotesLoaded') || g:GoNotesLoaded == 0
  let g:GoNotesLoaded = 1

  function! GoNotes(word, ...)
    let l:word = a:word

    if l:word[0:1] ==# '[@' || l:word[0:2] ==# '[-@'
      let l:do_word = 1
    else
      let l:do_word = 0
    endif

    if l:do_word
      " parse WORD object to get just the word
      let l:word = substitute(l:word, '[', '', '')
      let l:word = substitute(l:word, ']', '', '')
      let l:word = substitute(l:word, '@', '', '')
      if l:word[0] ==# '-'
        let l:word = l:word[1:]
      endif
      let l:filename = '$HOME/lib/papernotes/' . l:word . '.md'

    else
      let l:filename = expand('%:r') . '_notes' . '.' . expand('%:e')

    endif

    if a:0 > 0 && a:1 == 0
      let l:do_split = 0
    else
      let l:do_split = 1
    endif

    if l:do_split
      if exists('g:MuttonEnabled') && g:MuttonEnabled == 1
        execute 'MuttonToggle'
        let l:MuttonEnabled = 1
      else
        let l:MuttonEnabled = 0
      endif

      execute 'vsplit ' . l:filename

      if exists('g:GoNotesQuitKeymap')
        if l:MuttonEnabled == 1
          execute 'nnoremap <buffer> ' . g:GoNotesQuitKeymap . ' :q<CR>:MuttonToggle<CR>'
        else
          execute 'nnoremap <buffer> ' . g:GoNotesQuitKeymap . ' :q<CR>'
        endif
      endif

    else
      " TODO save the cursor position so we can move it back there on quit
      let l:bufnr = bufnr('%')
      execute 'edit ' . l:filename
      if exists('g:GoNotesQuitKeymap')
        execute 'nnoremap <buffer> ' . g:GoNotesQuitKeymap . ' :buffer ' . l:bufnr . '<CR>'
      endif
    endif

  endfunction

endif

" bib info {{{2
" nnoremap <localleader>b :vnew \| read !bib <C-r><C-w> -w 0 -h 0<CR>:set nomodified<CR>:set syntax=bibtex<CR>gg
nnoremap <localleader>b :call BibShowAbstract("<C-r><C-w>")<CR>:set filetype=bib<CR>

function! BibShowAbstract(citekey)
  if exists('g:MuttonEnabled') && g:MuttonEnabled == 1
    let l:mutton = 1
    MuttonToggle
  else
    let l:mutton = 0
  endif

  vnew
  execute 'read !bib -w 0 -h 0 '.a:citekey
  set nomodified
  set syntax=bibtex
  normal! gg

  if l:mutton == 1
    nnoremap <buffer> q :quit<CR>:MuttonToggle<CR>
  else
    nnoremap <buffer> q :quit<CR>
  endif
  nmap <buffer> <localleader>b q

endfunction

