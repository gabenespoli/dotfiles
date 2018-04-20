function! NotesToggleX()
  let l:beforeChar = getline('.')[col('.')-2]
  let l:currentChar = getline('.')[col('.')-1]
  let l:afterChar = getline('.')[col('.')]
  if l:beforeChar == '[' && l:afterChar == ']'
    if l:currentChar == 'x'
      normal! r 
    elseif l:currentChar == ' '
      normal! rx
    endif
  else
    normal! x
  endif
endfunction

nnoremap x :call NotesToggleX()<CR>
