set number norelativenumber
set laststatus=0
nnoremap <localleader>0 :call todo#RemovePriority()<CR>
nnoremap <localleader><localleader> :sort<CR>
nnoremap <localleader>ss :sort<CR>

source $HOME/dotfiles/vim/ftplugin/vello.vim
