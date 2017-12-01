" nvim-r plugin bindings
" nnoremap <localleader>r

set tabstop=2                   " number of visual spaces per TAB
set softtabstop=2               " number of spaces in tab when editing
set shiftwidth=2

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
