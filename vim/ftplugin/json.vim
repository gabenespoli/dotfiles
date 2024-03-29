setlocal tabstop=2 softtabstop=2 shiftwidth=2
if executable('jq') | setlocal formatprg=jq | endif

" quick loclists of 'level headings' based on indentation
nnoremap <localleader>1 :lvimgrep /^\W\W"[^"]*":\W{/j %<CR>:lopen<CR>
nnoremap <localleader>2 :lvimgrep /^\W\{4\}"[^"]*":\W{/j %<CR>:lopen<CR>

if expand('%:t') ==? 'karabiner.json'
  setlocal tabstop=4 softtabstop=4 shiftwidth=4
  setlocal foldmethod=expr
  setlocal foldexpr=KarabinerFolds(v:lnum)
  function! KarabinerFolds(lnum)
    let l:line = getline(a:lnum)
    " if     getline(a:lnum) =~# '\v^[^"]*"description":'
    if l:line =~# '\v^[^"]*"(global|profiles|devices)":'
    " if     getline(a:lnum) =~# '\v^[^"]*"(global|profiles)":'
      return '>1'
    elseif l:line =~# '\v^[^"]*"(description|product_id)":'
      return '>2'
    elseif l:line =~# '\v^[^"]*"(conditions|from|to|to_after_key_up|to_if_alone)":'
      return '>3'
    " elseif getline(a:lnum) =~# '\v^[^"]*"(complex_modifications|devices|fn_function_keys|selected|simple_modifications|virtual_hid_keyboard)":'
    "   return '>2'
    " elseif getline(a:lnum) =~# '\v^[^"]{12}"name":'
    "   return '>2'
    " elseif getline(a:lnum) =~# '\v^[^"]*"(parameters|rules)":'
    "   return '>3'
    " elseif getline(a:lnum) =~# '\v^[^"]*"(description|manipulators)":'
    "   return '>4'
    " elseif getline(a:lnum) =~# '\v^[^"]*"(conditions|from|to|to_after_key_up|to_if_alone)":'
    "   return '>5'
    else
      return '='
    endif
  endfunction
else
  setlocal foldmethod=expr
  setlocal foldexpr=nvim_treesitter#foldexpr()
endif

