set textwidth=88
setlocal tabstop=4 softtabstop=4 shiftwidth=4

" matplotlib
nnoremap <buffer> <localleader>q :SlimeSend1 plt.close()<CR>
nnoremap <buffer> <localleader>Q :SlimeSend1 plt.close('all')<CR>

" ipython magic commands
function SlimeSendTimeit()
  let text = substitute(getline('.'), '^[^=]*=\ \?', '', '')
  execute 'SlimeSend1 %timeit ' . text
endfunction
nnoremap <buffer> <C-l><C-t> :call SlimeSendTimeit()<CR>

" strip type def in function signature
function SlimeSendArg()
  let text = substitute(getline('.'), ':[^=]*', ' ', '')
  let text = substitute(text, ',$', '', '')
  execute 'SlimeSend1 ' . text
endfunction
nnoremap <buffer> <C-l><C-g> :call SlimeSendArg()<CR>j

" jupytext
nnoremap <buffer> <localleader>js :!jupytext --update -o %.ipynb %<CR>

" jupyter notebook
nnoremap <buffer> <localleader>a [zO# %%<CR><CR><Up>
nnoremap <buffer> <localleader>b ]zo# %%<CR><CR><Up>
nnoremap <buffer> <localleader>- o# %%<Esc>0

nnoremap <buffer> <localleader>r :JupycentReadIpynb<CR>

" Databricks:
nnoremap <buffer> <localleader>o zjo<CR># COMMAND ----------<Esc>2ko<CR>
nnoremap <buffer> <localleader>O [zO# COMMAND ----------<CR><CR><CR><Esc>ki
nnoremap <buffer> <localleader>c i# COMMAND ----------<Esc>
nnoremap <buffer> <localleader>C o# COMMAND ----------<CR><Esc>

augroup highlight_databricks_cells_as_titles
  autocmd!
  autocmd BufEnter,BufWritePost *.py
        \ execute 'syntax match DatabricksCellMarker /^# COMMAND ----------$/'
        \ | hi! link DatabricksCellMarker Title
augroup END

function! DatabricksFoldsCells(lnum)
  if getline(a:lnum) =~# '^# COMMAND ----------$'
    return '>1'
  else
    return '='
  endif
endfunction

function! EnableDatabricksFoldingCells()
  setlocal foldmethod=expr
  setlocal foldexpr=DatabricksFoldsCells(v:lnum)
  setlocal foldtext=getline(v:foldstart+2)
endfunction

nnoremap coFc :call EnableDatabricksFoldingCells()<CR>

function! DatabricksFoldsMarkdown(lnum)
  if getline(a:lnum) =~# '^# MAGIC %md # '
    return '>1'
  elseif getline(a:lnum) =~# '^# MAGIC %md ## '
    return '>2'
  elseif getline(a:lnum) =~# '^# MAGIC %md ### '
    return '>3'
  elseif getline(a:lnum) =~# '^# MAGIC %md #### '
    return '>4'
  elseif getline(a:lnum) =~# '^# MAGIC %md ##### '
    return '>5'
  elseif getline(a:lnum) =~# '^# MAGIC %md ###### '
    return '>6'
  else
    return '='
  endif
endfunction

function! EnableDatabricksFoldingMarkdown()
  setlocal foldmethod=expr
  setlocal foldexpr=DatabricksFoldsMarkdown(v:lnum)
  setlocal foldtext=getline(v:foldstart)
  nnoremap <buffer> zf :lvimgrep '^# MAGIC %md #' %<CR>:botright lopen<CR>
endfunction

nnoremap coFm :call EnableDatabricksFoldingMarkdown()<CR>

if getline(1) == '# Databricks notebook source'
  call EnableDatabricksFoldingMarkdown()
endif
