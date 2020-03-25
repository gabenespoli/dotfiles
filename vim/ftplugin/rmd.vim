setlocal foldmethod=expr
setlocal foldexpr=MarkdownFoldRmd(v:lnum)
setlocal foldtext=getline(v:foldstart+1)
setlocal foldmarker=```{r},```

" augroup ipynb_syntax_markdown "{{{
"   au!
"   autocmd BufEnter,BufWritePost *.ipynb execute 'set syntax=markdown'
" augroup END "}}}

function! MarkdownFoldRmd(lnum) "{{{
  let l:line = getline(a:lnum) 
  if (l:line =~# '^```{r}$') || (a:lnum == 1 && l:line =~# '^---$')
    return '>1'
  " elseif l:line =~# '^```$'
  "   return '<1'
  " elseif l:line =~# '^---$'
  "   return '<1'
  else
    return '='
  endif
endfunction "}}}

