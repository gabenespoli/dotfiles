" unmap C-n/p for CtrlP
silent! unmap <buffer> <C-p>
silent! unmap <buffer> <C-n>

" use - as a toggle; use u to go up a dir when in dirvish
nmap <silent> <buffer> - q
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
" TODO: yy sets a global or buffer var with path to copy from
" TODO: pp (can't used by dirvish) uses that var to perform the paste in the current directory
" TODO: make this work for visual selections
nnoremap <buffer> cd :cd %
nnoremap <buffer> cp :!cp '<C-r><C-l>' '<C-r><C-l>'
nnoremap <buffer> mv :!mv '<C-r><C-l>' '<C-r><C-l>'
nnoremap <buffer> rm :!rm '<C-r><C-l>'
nmap <buffer> dt :!trash '<C-r><C-l>'<CR><CR>R
nnoremap <buffer> e :edit %/
nmap <buffer> <Del> dt
nmap <buffer> dD rm
