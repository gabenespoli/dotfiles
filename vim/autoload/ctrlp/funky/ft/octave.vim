" Language: Octave/Matlab (octave/matlab)
" Author: Gabe Nespoli (copied from Takahiro Yoshihara)
" License: The MIT License (same as ctrlp-funky)

function! ctrlp#funky#ft#octave#filters()
  let filters = [
        \ { 'pattern': '\m\C^[\t ]*function',
        \   'formatter': ['\m\C^[\t ]\+', '', ''] }
  \ ]
  return filters
endfunction
