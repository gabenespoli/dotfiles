setlocal noexpandtab
setlocal tabstop=20
setlocal softtabstop=20
setlocal shiftwidth=20
setlocal nowrap
let b:delimiter = "\t"
nnoremap <buffer> <localleader>, :call ToggleCsvTsv()<CR>
