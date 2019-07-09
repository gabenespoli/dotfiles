set textwidth=79
setlocal tabstop=4 softtabstop=4 shiftwidth=4
" if executable('yapf') | setlocal formatprg=yapf | endif
if exists(':CocAction') | setlocal formatexpr=CocAction('formatSelected')  | endif

if exists('*jedi#goto()')
  nnoremap <buffer> gd :call jedi#goto_assignments()<CR>
  nnoremap <buffer> gD :call jedi#goto()<CR>
endif

" matplotlib
nnoremap <buffer> <localleader>q :SlimeSend1 plt.close()<CR>
nnoremap <buffer> <localleader>Q :SlimeSend1 plt.close('all')<CR>

" neoclide/coc-python
nnoremap <buffer> <localleader>pd :CocCommand python.setInterpreter<CR>:sleep 200m<CR>11<CR><CR>:echo 'conda activate ds2'<CR>
nnoremap <buffer> <localleader>ps :CocCommand python.setInterpreter<CR>:sleep 200m<CR>5<CR><CR>:echo 'conda activate spark2'<CR>

" jupytext
nnoremap <buffer> <localleader>j :!jupytext -o %.ipynb %<CR>

" databricks
nnoremap <buffer> <localleader>ds :call DatabricksSave()<CR>
function! DatabricksSave() "{{{
  let l:cmd = 'databricks workspace import -ol python'
  let l:local_fname = expand('%')
  let l:databricks_fname = '/Users/gabe.nespoli@sonova.com/' .
        \ fnamemodify(trim(system('git rev-parse --show-toplevel')), ':t') . '/' . 
        \ trim(system('git ls-files --full-name ' . expand('%')))
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
  elseif getline(a:lnum) =~# '^# COMMAND ----------$'
    return '>2'
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
