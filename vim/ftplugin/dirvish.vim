" use C-n/p for CtrlP, not dirvish
nmap <buffer> <C-p> q<C-p>
nmap <buffer> <C-n> q<C-n>

" use - as a toggle; use u to go up a dir when in dirvish
nmap <silent> <buffer> - gq
nmap <silent> <buffer> q gq
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

" my shell operations
nnoremap <buffer> cd :cd <C-R>=expand('%')<CR>
nnoremap <buffer> e :edit <C-R>=expand('%')<CR>
nnoremap <buffer> cp :!cp '<C-r><C-l>' '<C-r><C-l>'
nnoremap <buffer> mv :!mv '<C-r><C-l>' '<C-r><C-l>'
nnoremap <buffer> mk :!mkdir '<C-R>=expand('%')<CR>'<Left>

" roginfarrer/vim-dirvish-dovish
let g:dirvish_dovish_map_keys = 0
unmap <buffer> p
nmap <silent><buffer> i <Plug>(dovish_create_file)
nmap <silent><buffer> I <Plug>(dovish_create_directory)
nmap <silent><buffer> D <Plug>(dovish_delete)
nmap <silent><buffer> r <Plug>(dovish_rename)
nmap <silent><buffer> y <Plug>(dovish_yank)
xmap <silent><buffer> y <Plug>(dovish_yank)
nmap <silent><buffer> p <Plug>(dovish_copy)
nmap <silent><buffer> P <Plug>(dovish_move)
