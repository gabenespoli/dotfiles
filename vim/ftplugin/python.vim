set textwidth=79
setlocal tabstop=4 softtabstop=4 shiftwidth=4
if executable('yapf') | setlocal formatprg=yapf | endif

if exists('*jedi#goto()')
  nnoremap <buffer> gd :call jedi#goto_assignments()<CR>
  nnoremap <buffer> gD :call jedi#goto()<CR>
endif

" re-enable some python-mode settings disabled in vimrc
setlocal define=^\s*\\(def\\\\|class\\)
setlocal complete+=t

" jupytext
nnoremap <buffer> <localleader>j :!jupytext -o %.ipynb %<CR>

" databricks
nnoremap <buffer> <localleader>ds :execute '!databricks workspace import -ol python ' . 
      \ shellescape(expand('%')) . ' ' . '/Users/gabe.nespoli@sonova.com/' . shellescape(expand('%:t'))<CR>
nnoremap <buffer> <localleader>o zjo<CR># COMMAND ----------<Esc>2ko<CR>
nnoremap <buffer> <localleader>O [zO# COMMAND ----------<CR><CR><CR><Esc>ki
nnoremap <buffer> <localleader>c i# COMMAND ----------<Esc>

if search('^# COMMAND ----------$')
  setlocal foldmethod=expr
endif
setlocal foldexpr=DatabricksFolds(v:lnum)
function! DatabricksFolds(lnum) "{{{
  if getline(a:lnum) =~# '^# COMMAND ----------$'
    return '>1'
  else
    return '='
  endif
endfunction "}}}

augroup highlight_databricks_cells_as_titles
  au!
  autocmd BufEnter,BufWritePost *.py
        \ execute 'syntax match DatabricksCellMarker /^# COMMAND ----------$/'
        \ | hi! link DatabricksCellMarker Title
augroup END
