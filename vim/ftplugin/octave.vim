" there is probably a more efficient way to do this than using BufEnter,
" but I can't figure out how to override the syntax in jvirtanen/vim-octave
au BufEnter <buffer> syn match matlabCellComment "^%%.*$"
