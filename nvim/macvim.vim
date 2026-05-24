" Author: Gabe Nespoli
" File: vimrc (MacVim / vim)
" This sources the shared config and adds vim-specific plugins/settings.

" Install vim-plug if needed
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Shared plugins (same as in nvim lazy spec)
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dotenv'
Plug 'machakann/vim-sandwich'
Plug 'github/copilot.vim'
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'justinmk/vim-dirvish'
Plug 'brianhuster/dirvish-git.nvim'
Plug 'Vimjas/vim-python-pep8-indent', {'for': ['python']}
Plug 'kalekundert/vim-coiled-snake', {'for': ['python']}
Plug 'gabenespoli/vim-pythonsense', {'for': ['python']}
Plug 'psf/black', {'for': ['python']}
Plug 'fisadev/vim-isort', {'for': ['python']}
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'
Plug 'gabenespoli/vim-mutton'
Plug 'gabenespoli/vim-tabsms'
Plug 'gabenespoli/vim-jupycent'

" Vim-only plugins
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

" Source shared settings
source ~/dotfiles/nvim/shared.vim

" Vim-specific settings
set number

" Meta key mappings for vim on mac
if has('mac')
  execute "set <M-h>=\eh"
  execute "set <M-j>=\ej"
  execute "set <M-k>=\ek"
  execute "set <M-l>=\el"
  execute "set <M-s>=\es"
  execute "set <M-t>=\et"
endif

" Tmux navigator (or window nav without tmux)
if has('gui') || !exists('$TMUX')
  map <D-h> <C-w>h
  map <D-j> <C-w>j
  map <D-k> <C-w>k
  map <D-l> <C-w>l
else
  nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
  nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
  nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
  nnoremap <silent> <M-l> :TmuxNavigateRight<CR>
  inoremap <silent> <M-h> <Esc>:TmuxNavigateLeft<CR>
  inoremap <silent> <M-j> <Esc>:TmuxNavigateDown<CR>
  inoremap <silent> <M-k> <Esc>:TmuxNavigateUp<CR>
  inoremap <silent> <M-l> <Esc>:TmuxNavigateRight<CR>
  vnoremap <silent> <M-h> <Esc>:TmuxNavigateLeft<CR>
  vnoremap <silent> <M-j> <Esc>:TmuxNavigateDown<CR>
  vnoremap <silent> <M-k> <Esc>:TmuxNavigateUp<CR>
  vnoremap <silent> <M-l> <Esc>:TmuxNavigateRight<CR>
endif

" FZF keymaps (vim-only, nvim uses fzf-lua)
nmap <C-p>        :GFiles<CR>
nmap <C-k><C-b>   :Buffers<CR>
nmap <C-k><C-g>   :Rg<CR>
nmap <C-k><C-f>   :Files<CR>
nmap <C-k><C-l>   :Commits<CR>
nmap <C-k><C-o>   :History<CR>
nmap <C-k><C-s>   :GFiles?<CR>

" echo syntax under cursor (vim doesn't have :Inspect)
nnoremap <expr> zS ':echo synIDattr(synID(line("."),col("."),1),"name")<CR>'

" Gitsigns preview (no diagnostics in vim)
nnoremap = :Gitsigns preview_hunk<CR>

" Statusline (simpler, no devicons)
set statusline=
set statusline+=%#PmenuSel#%h%w%*
set statusline+=%#PmenuSel#%w%*
set statusline+=%#WarningMsg#%m%*
set statusline+=%#ErrorMsg#%r%*
set statusline+=%#StatusGit#%{GitStatusline()}%*%{GitStatuslineEnd()}
set statusline+=\ %#StatusFilename#%f%*\ %<
set statusline+=%=
set statusline+=\ \ %{&filetype}
set statusline+=\ \ %P
set statusline+=\ \ %l%L:%c
set statusline+=\ 

function! GitStatusline() abort
  let l:branch = FugitiveHead(12)
  if l:branch == '' | return '' | endif
  return '  ' . l:branch . ' '
endfunction

function! GitStatuslineEnd() abort
  let l:branch = FugitiveHead(12)
  if l:branch == '' | return '' | endif
  return ''
endfunction
