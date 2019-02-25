setlocal tabstop=4 softtabstop=4 shiftwidth=4

if expand('%:t') ==? 'karabiner.json'
  setlocal foldmethod=expr
  setlocal foldexpr=KarabinerFolds(v:lnum)
  function! KarabinerFolds(lnum)
    if     getline(a:lnum) =~# '\v^[^"]*"description":'
      return '>1'
    elseif getline(a:lnum) =~# '\v^[^"]*"(conditions|from|to|to_after_key_up|to_if_alone)":'
      return '>2'
    else
      return '='
    endif
  endfunction
else
  setlocal foldmethod=syntax
endif

