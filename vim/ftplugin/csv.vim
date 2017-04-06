so ~/.vim/ftplugin/tsv.vim

let b:delimiter = ","

nnoremap <buffer> <localleader>, :call ToggleCsvTsv()<CR>
