augroup ftdetect_octave
  autocmd!
  autocmd BufRead,BufNewFile *.octaverc,octaverc set filetype=octave
  autocmd BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END
