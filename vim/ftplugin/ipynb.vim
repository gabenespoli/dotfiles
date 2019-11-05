setlocal foldmethod=expr
setlocal foldexpr=MarkdownFoldIpynb(v:lnum)
setlocal foldtext=getline(v:foldstart+1)
setlocal foldmarker=```python,```

augroup ipynb_syntax_markdown "{{{
  au!
  autocmd BufEnter,BufWritePost *.ipynb execute 'set syntax=markdown'
augroup END "}}}

function! MarkdownFoldIpynb(lnum) "{{{
  let l:line = getline(a:lnum) 
  if (l:line =~# '^```python$') || (a:lnum == 1 && l:line =~# '^---$')
    return '>1'
  " elseif l:line =~# '^```$'
  "   return '<1'
  " elseif l:line =~# '^---$'
  "   return '<1'
  else
    return '='
  endif
endfunction "}}}
