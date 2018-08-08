" Language: Octave/Matlab (octave/matlab)
" Author: Gabe Nespoli (copied from Takahiro Yoshihara)
" License: The MIT License (same as ctrlp-funky)

function! ctrlp#funky#ft#bib#filters()
  let filters = [
        \ { 'pattern': '\m\C^@article{\S\+',
        \   'formatter': ['\m\C^@article{', '', ''] }
  \ ]
  return filters
endfunction
