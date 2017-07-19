setlocal textwidth=0 wrapmargin=0 wrap linebreak 
hi StatusLine ctermfg=8
hi StatusLineNC ctermfg=8
setlocal statusline=%*%#WarningMsg#%m%r%*
set norelativenumber nonumber
set spell
set laststatus=2 showtabline=0
nnoremap <buffer> <leader>x <Esc>o<CR>-- <CR>Gabriel A. Nespoli, B.Sc., M.A.<CR>Ph.D. Candidate<CR>Ryerson University<CR>Toronto, ON, Canada<Esc>
nnoremap <buffer> q :wq<CR>
"setlocal nocp 
"exe "/^$"
"exe "normal! gg}O\<Esc>o"
exe "normal! gg"
