set textwidth=79
setlocal tabstop=4 softtabstop=4 shiftwidth=4

nmap <C-l><CR> <C-l>izzjzz
nmap <C-l><C-j> <C-l><CR>
nmap <C-l><C-k> <C-l>iz

" prabirshrestha/vim-lsp
nmap <buffer> gd <Plug>(lsp-definition)
nmap <buffer> gD <Plug>(lsp-peek-definition)

" matplotlib
nnoremap <buffer> <localleader>q :SlimeSend1 plt.close()<CR>
nnoremap <buffer> <localleader>Q :SlimeSend1 plt.close('all')<CR>

" jupytext
nnoremap <buffer> <localleader>js :!jupytext --update -o %.ipynb %<CR>

" jupyter notebook
nnoremap <buffer> <localleader>a [zO# %%<CR><CR><Up>
nnoremap <buffer> <localleader>b ]zo# %%<CR><CR><Up>
nnoremap <buffer> <localleader>- o# %%<Esc>0

" Databricks:
nnoremap <buffer> <localleader>ds :call DatabricksSave()<CR>
function! DatabricksSave() "{{{
  let l:cmd = 'databricks workspace import -ol python'
  let l:local_fname = expand('%')
  let l:databricks_fname = '/Users/gabe.nespoli@sonova.com/uploads' . expand('%')
  let l:whole_cmd = l:cmd . ' ' . shellescape(l:local_fname) . ' ' . shellescape(l:databricks_fname)
  execute(system(l:whole_cmd))
  echo('Saved to databricks: ' . l:databricks_fname)
endfunction "}}}

" databricks folding
nnoremap <buffer> <localleader>o zjo<CR># COMMAND ----------<Esc>2ko<CR>
nnoremap <buffer> <localleader>O [zO# COMMAND ----------<CR><CR><CR><Esc>ki
nnoremap <buffer> <localleader>c i# COMMAND ----------<Esc>
nnoremap <buffer> <localleader>C o# COMMAND ----------<CR><Esc>

" if search('^# COMMAND ----------$')
"   setlocal foldmethod=expr
" endif
" setlocal foldexpr=DatabricksFolds(v:lnum)
function! DatabricksFolds(lnum) "{{{
  if getline(a:lnum) =~# '^# MAGIC %md #'
    return '>1'
  " elseif getline(a:lnum) =~# '^# COMMAND ----------$'
  "   return '>2'
  else
    return '='
  endif
endfunction "}}}

nnoremap <localleader>Fe :call EnableDatabricksFolding()<CR>
function! EnableDatabricksFolding() "{{{
  setlocal foldmethod=expr
  setlocal foldexpr=DatabricksFolds(v:lnum)
endfunction "}}}

augroup highlight_databricks_cells_as_titles "{{{
  au!
  autocmd BufEnter,BufWritePost *.py
        \ execute 'syntax match DatabricksCellMarker /^# COMMAND ----------$/'
        \ | hi! link DatabricksCellMarker Title
augroup END "}}}
