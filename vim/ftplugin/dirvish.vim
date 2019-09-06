" use C-n/p for CtrlP, not dirvish
nmap <buffer> <C-p> q<C-p>
nmap <buffer> <C-n> q<C-n>

" use - as a toggle; use u to go up a dir when in dirvish
nmap <silent> <buffer> - gq
nmap <silent> <buffer> q gq
nmap <silent> <buffer> u <Plug>(dirvish_up)
nnoremap U u

" use = to first close dirvish, then use = (buffergator toggle)
nmap <silent> <buffer> = -=

" my preferred maps for open, split, vsplit, tab open
" TODO: make o an expr map to use gx if extention is pdf, docx, etc.
nmap <silent> <buffer> o :call dirvish#open('edit', 0)<CR>
nmap <silent> <buffer> O :call dirvish#open('split', 1)<CR>
nmap <silent> <buffer> s :call dirvish#open('split', 1)<CR>q<C-w>p
nmap <silent> <buffer> v :call dirvish#open('vsplit', 1)<CR>q<C-w>p
nmap <silent> <buffer> t :call dirvish#open('tabedit', 0)<CR>
xmap <silent> <buffer> t :call dirvish#open('tabedit', 0)<CR>

" show/hide dofiles like ranger
nnoremap <silent> <buffer> zh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<CR>:setl cole=3<CR>

" open with mac system
if has('mac')
  nnoremap <silent> <buffer> gx :execute "!open " . shellescape("<C-r><C-l>")<CR><CR>
endif

" basic shell operations
nnoremap <buffer> cd :cd %
nnoremap <buffer> cp :!cp '<C-r><C-l>' '<C-r><C-l>'
nnoremap <buffer> mv :!mv '<C-r><C-l>' '<C-r><C-l>'
nnoremap <buffer> rm :!rm '<C-r><C-l>'
nmap <buffer> dt :!trash '<C-r><C-l>'<CR><CR>R
nnoremap <buffer> e :edit %
nnoremap <buffer> mk :!mkdir '%'<Left>
nmap <buffer> <Del> dt
nmap <buffer> dD rm

" copy file path to copy from
" TODO: make this work for visual selections
if !exists('g:dirvish_yank') | let g:dirvish_yank = '' | endif
nmap <buffer> Y :echo "g:dirvish_yank = '" . g:dirvish_yank . "'"<CR>
nmap <buffer> <silent> yy :let g:dirvish_yank = '<C-r><C-l>'<CR>Y

" paste yanked file into current dir
" (careful this doesn't check for overwriting files)
" reclaim p mapping from dirvish, use P instead for preview
silent! unmap <buffer> p
nnoremap <nowait> <buffer> <silent> P :<C-U>.call dirvish#open("p", 1)<CR>
" nmap <buffer><silent> pp :execute("!cp '" . g:dirvish_yank . "' '" . expand('%') . fnamemodify(g:dirvish_yank, ':t') . "'")<CR><CR>R
nnoremap <buffer> <silent> pp :call DirvishPasteFile(g:dirvish_yank)<CR>

if !exists('g:loaded_dirvish_paste') || g:loaded_dirvish_paste == 0
  let g:loaded_dirvish_paste = 1
  function! DirvishPasteFile(fname)
    if &filetype != 'dirvish'
      echo 'Not in a dirvish buffer.'
      return
    endif
    if empty(a:fname)
      echo 'No file copied.'
      return
    endif
    if search(a:fname)
      echo 'File already exists.'
      return
    endif
    let l:paste_fname = expand('%') . fnamemodify(g:dirvish_yank, ':t')
    silent execute("!cp '" . g:dirvish_yank . "' '" . l:paste_fname . "'")
    silent echom 'File pasted from ' . g:dirvish_yank . ' to ' . l:paste_fname
    execute("Dirvish %")
  endfunction
endif
