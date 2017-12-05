" nvim-r plugin bindings
" nnoremap <localleader>r

set equalalways
if has('nvim')
  tnoremap _ <Space><-<Space>
endif

" comment headings and folding (like Rstudio)
au VimEnter,BufEnter <buffer> syn match Title '^#.*-\{4,\}$'
au VimEnter,BufEnter <buffer> syn match Title '^#.*=\{4,\}$'
au VimEnter,BufEnter <buffer> syn match Title '^#.*#\{4,\}$'

set foldmethod=expr
set foldexpr=GetRFolds(v:lnum)

function! GetRFolds(lnum)
  if     getline(a:lnum) =~ '^#.*-\{4,\}$'
    return '>1'
  elseif getline(a:lnum) =~ '^#.*=\{4,\}$'
    return '>2'
  elseif getline(a:lnum) =~ '^#.*#\{4,\}$'
    return '>3'
  else
    return '='
  endif
endfunction

" capitalL plugin settings
let b:Lpatterns = ['%\+\s*TODO', '^.*<-\s*function']
let b:Lreformat = ['[^|]*|[^|]*|\s%\+\s*\(TODO.*\)$/\1', '[^|]*|[^|]*|\s/']
