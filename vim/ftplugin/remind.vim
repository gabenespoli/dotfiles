" keybindings
nnoremap <buffer> <localleader>r :SlimeSend1 printf "\033c" && rem -cc+2 -w120<CR>
nnoremap <buffer> <leader>s :w<CR>:SlimeSend1 printf "\033c" && rem -cc+2 -w120<CR>

" highlighting
au VimEnter,BufEnter <buffer> syn match Title '^#.*-\{4,\}$'

" folding
set foldmethod=expr
set foldexpr=GetRemindFolds(v:lnum)
function! GetRemindFolds(lnum)
  if getline(a:lnum) =~ '^#.*-\{4,\}$'
    return '>1'
  else
    return '='
  endif
endfunction

" headings (copied from ftplugin/r.vim 2018-01-17)
function! AddRstudioHeadings(level)
  " remove existing headings if there are any
  silent! execute "s/[-=#]\\{4,\\}$//g"
  " get number of heading characters to add
  let l:maxWidth = 79
  execute "normal! $"
  let l:currentWidth = col(".")
  let l:numberToInsert = l:maxWidth - l:currentWidth
  " get new heading level character
  if     a:level == 1
    let l:headingCharacter = "-"
  elseif a:level == 2
    let l:headingCharacter = "="
  elseif a:level == 3
    let l:headingCharacter = "#"
  elseif a:level == 0
    return
  else
    echo "Heading level must be 0, 1, 2, or 3"
  endif
  " add new heading characters
  execute "normal! $" . l:numberToInsert . "a" . l:headingCharacter
endfunction
nnoremap <buffer> <localleader>0 :call AddRstudioHeadings(0)<CR>
nnoremap <buffer> <localleader>1 :call AddRstudioHeadings(1)<CR>
