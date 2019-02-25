" unmap C-n/p for CtrlP
silent! unmap <buffer> <C-p>
silent! unmap <buffer> <C-n>

" use - as a toggle; use u to go up a dir when in dirvish
nmap <silent> <buffer> - q
nmap <silent> <buffer> u <Plug>(dirvish_up)
nnoremap U u

" my preferred maps for open, split, vsplit, tab open
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
