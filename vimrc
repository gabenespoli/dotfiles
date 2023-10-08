" Author: Gabe Nespoli
" Email: gabenespoli@gmail.com
" File: init.vim/vimrc
set encoding=utf-8
scriptencoding utf-8

" Plugins  {{{1
" Install vim-plugged if it isn't already
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Editing  {{{2
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dotenv'
Plug 'machakann/vim-sandwich'
Plug 'sjl/gundo.vim'

" Git & Files  {{{2
Plug 'tpope/vim-fugitive', {'tag': 'v3.7'}
Plug 'airblade/vim-gitgutter'
Plug 'rbong/vim-flog'
Plug 'justinmk/vim-dirvish'
Plug 'roginfarrer/vim-dirvish-dovish'
" Plug 'mrossinek/vim-dirgutter'
Plug '~/local/vim-dirgutter'

" Python  {{{2
Plug 'Vimjas/vim-python-pep8-indent', {'for': ['python']}
Plug 'kalekundert/vim-coiled-snake', {'for': ['python']}
Plug 'gabenespoli/vim-pythonsense', {'for': ['python'], 'branch': 'dev'}
Plug 'psf/black', {'for': ['python']}
Plug 'fisadev/vim-isort', {'for': ['python']}
Plug 'MathSquared/vim-python-sql'

Plug 'hashivim/vim-terraform'

" Tmux  {{{2
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'

" My Plugins  {{{2
Plug 'gabenespoli/vim-mutton'
Plug 'gabenespoli/vim-tabsms'
Plug 'gabenespoli/vim-jupycent'

" Lua Plugins  {{{2
if has('nvim')
  Plug 'ibhagwan/fzf-lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'nanotee/sqls.nvim'
else
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
endif

call plug#end()

" General  {{{1
if has('mac') | set fileformats=unix,dos | endif
set updatetime=300
if has('nvim')
  set undofile
  set undodir=~/.config/nvim/undo/
  set backupdir=~/.config/nvim/backup/
  set directory=~/.config/nvim/swap/
endif
if has('macunix')
  let g:python3_host_prog = expand('~').'/miniconda3/envs/neovim3/bin/python'
  let g:python_host_prog = expand('~').'/miniconda3/envs/neovim2/bin/python'
else
  let g:python3_host_prog = expand('~').'/.pyenv/neovim3/bin/python'
endif
set hidden laststatus=2
set number
set nomodeline
set cursorline
set splitright splitbelow
set nowrap linebreak breakindent whichwrap+=h,l
set expandtab tabstop=2 softtabstop=2 shiftwidth=2
set showmatch ignorecase smartcase nohlsearch
set formatoptions-=t
set foldlevel=99
set foldmethod=marker
set foldtext=getline(v:foldstart)
let g:vimsyn_folding='af'
set wildignorecase
set completeopt=menuone
set shortmess+=c
set diffopt+=context:3
set suffixesadd+=.m,.r,.R,.py
set clipboard=unnamed
set mouse=n
set guioptions=g
set guicursor=n-v-sm:block-blinkon0,i-ci-c:ver25-blinkon0,r-cr-o:hor20-blinkon0
set guifont=DankMono\ Nerd\ Font\ Mono:h15,DankMono:h15,IBMPlexMono:h15,Menlo:h15,Consolas:h15,Courier:h15

" Colors
set background=dark
if has('nvim') | set termguicolors | endif
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
let g:snooker_diff_high_contrast = 1
colorscheme snooker

" Some autocommands
augroup general
  autocmd!

  " open help in a vertial split
  autocmd FileType help wincmd L

  " open qf window after qf search
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow

  " line return (https://hg.stevelosh.com/dotfiles/file/tip/vim/vimrc)
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif

  " set cursor shape to beam on exit (https://github.com/alacritty/alacritty/issues/2839)
  autocmd VimLeave * set guicursor=a:ver25-blinkon0

augroup END

" Status Line  {{{1
set statusline=
set statusline+=%#PmenuSel#%h%w%*
set statusline+=%#PmenuSel#%w%*
" set statusline+=%#Modified#%m%*
set statusline+=%#DiffText#%m%*
set statusline+=%#DiffDelete#%r%*
set statusline+=%#StatusGit#%{GitStatusline()}%*%{GitStatuslineEnd()}
set statusline+=\ %#StatusFilename#%{Devicon()}%f%*\ %<
set statusline+=%#StatusPywhere#%{PywhereStatusline()}%*%{PywhereStatuslineEnd()}
set statusline+=%=
" set statusline+=%{db_ui#statusline()}
set statusline+=\ \ %{GetFiletype()}
set statusline+=\ \ %P
set statusline+=\ \ %l%L:%c
set statusline+=\ 

function! GetFiletype() abort
  return &filetype
endfunction

function! GitStatusline() abort
  let l:branch = FugitiveHead(12)
  if l:branch == ''
    return ''
  else
    return '   ' . l:branch . ' '
  endif
endfunction

function! GitStatuslineEnd() abort
  let l:branch = FugitiveHead(12)
  if l:branch == ''
    return ''
  else
    return ''
  endif
endfunction

function! Devicon() abort
  if !has('nvim')
    return ''
  endif
  if stridx(expand('%:p'), '.git') != -1
    return ' '
  else
    let l:icon = execute('lua print(require("nvim-web-devicons").get_icon('
          \ . '"' . expand('%:t') . '", "' . expand('%:e') . '"))')
    if l:icon[1:3] == ''
      return ''
    else
      return l:icon[1:3] . ' '
    endif
  endif
endfunction

function! PywhereStatusline() abort
  if &filetype != 'python'
    return ''
  endif
  let l:loc = pythonsense#get_python_location()
  if l:loc == ''
    return ''
  else
    return ' ' . substitute(l:loc, '(def:)', ' ', '') . ' '
  endif
endfunction

function! PywhereStatuslineEnd() abort
  if &filetype != 'python'
    return ''
  endif
  let l:loc = pythonsense#get_python_location()
  if l:loc == ''
    return ''
  else
    return ''
  endif
endfunction

" Keybindings  {{{1
set notimeout ttimeout
let maplocalleader = "\<Space>"
nnoremap <Space><Esc> <nop>
inoremap jk <Esc>
nmap <C-j> <CR>
nnoremap <C-w><CR> <C-w>j
nnoremap Y y$
nnoremap ! :!
nnoremap <silent> <M-s> :silent w<CR>
inoremap <silent> <M-s> <C-o>:silent w<CR>

" adjust command line up/down
cnoremap <expr> <C-p> pumvisible() ? "\<C-p>" : "\<up>"
cnoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<down>"

" q to quit, C-q for macros, q macro: <C-q>q to record, Q to replay
nnoremap q <C-w>q
nnoremap <C-q> q
nnoremap Q @q

" select last paste selection
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" popup menu: esc to exit, enter to select
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" resize windows
nnoremap + <C-w>+
nnoremap _ <C-w>>

" open current file in new tab (uses the x mark)
nnoremap <C-w><C-t> mx:tabnew %<CR>`x

" open file/tag under cursor in vertical split
nnoremap <C-w><C-f> <C-w><C-v>gf
nnoremap <C-w><C-]> <C-w><C-v><C-]>zt

" echo syntax under cursor
nnoremap <silent> <leader>zS :echo synIDattr(synID(line("."),col("."),1),"name")<CR>

" change pwd to that of current file or git repo
nnoremap <expr> cd exists(":Gcd") == 2 ? ':Gcd<CR>:pwd<CR>' : ':cd %:p:h<CR>:pwd<CR>'

" fix spelling with first suggestion
nnoremap <leader>s 1z=

" zz but 3/4 ish instead of half
nnoremap z<Space> zz25<C-e>
vnoremap z<Space> zz25<C-e>

" open with mac system
if has('mac')
  nnoremap <silent> <buffer> gx :execute "!open " . shellescape("<C-r><C-l>")<CR><CR>
endif

" search for conflict markers
nnoremap <silent> cx /^<<<<<<< .*$\\|^=======\\|^\|\|\|\|\|\|\|\\|^>>>>>>> .*$<CR>:set hlsearch<CR>

" open a note with this Monday's date
nnoremap <C-k><C-n> :e ~/notes/<C-R>=system('date -d last-monday +%Y')<CR><BS>/<C-R>=system('date -d last-monday +%Y%m%d')<CR><BS>.txt<CR>

" quickfix & location list {{{2
" add last search to location list
nnoremap z/ :lvimgrep // %<CR>:botright lopen<CR>

" toggle with leader q/l
nnoremap <silent> <expr> <leader>q
      \ empty(filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')) ?
      \ ':botright copen<CR>' : ':cclose<CR>'
nnoremap <silent> <expr> <leader>l
      \ empty(filter(getwininfo(), 'v:val.quickfix && v:val.loclist')) ?
      \ ':botright lopen<CR>' : ':lclose<CR>'

" map down and up to c/lnext and c/lprevious
" lnext/lprevious if location list is open, else cnext/cprevious
nnoremap <silent> <expr> <down>
      \ empty(filter(getwininfo(), 'v:val.loclist')) ?
      \ ':cnext<CR>' : ':lnext<CR>'
nnoremap <silent> <expr> <up>
      \ empty(filter(getwininfo(), 'v:val.loclist')) ?
      \ ':cprevious<CR>' : ':lprevious<CR>'

" vim diff view mappings
nnoremap <C-k>D :windo diffthis<CR>zR
nnoremap <expr> <Left><Left> &diff ? ':diffput<CR>' : '<Left><Left>'
nnoremap <expr> <Right><Right> &diff ? ':diffput<CR>' : '<Right><Right>'
nnoremap <expr> <Left><Right> &diff ? ':diffget<CR>' : '<Left><Right>'
nnoremap <expr> <Right><Left> &diff ? ':diffget<CR>' : '<Right><Left>'
vnoremap <expr> <Left><Left> &diff ? ':diffput<CR>' : '<Left><Left>'
vnoremap <expr> <Right><Right> &diff ? ':diffput<CR>' : '<Right><Right>'
vnoremap <expr> <Left><Right> &diff ? ':diffget<CR>' : '<Left><Right>'
vnoremap <expr> <Right><Left> &diff ? ':diffget<CR>' : '<Right><Left>'

" option mappings (co)  {{{2
nnoremap coc :set cursorline!<CR>
nnoremap cof :set foldcolumn=<C-R>=&foldcolumn ? 0 : 2<CR><CR>
nnoremap coh :set hlsearch!<CR>
nnoremap con :set number!<CR>
nnoremap cor :set relativenumber!<CR>
nnoremap cos :set spell!<CR>
nnoremap <expr> cot
      \ &softtabstop==2 ?
      \ ':set tabstop=4 softtabstop=4 shiftwidth=4<CR>:echo 4<CR>' :
      \ ':set tabstop=2 softtabstop=2 shiftwidth=2<CR>:echo 2<CR>'
nnoremap cou :set cursorcolumn!<CR>
nnoremap cow :set colorcolumn=<C-R>=&colorcolumn ? 0 : &textwidth<CR><CR>
nnoremap coS :set laststatus=<C-R>=&laststatus ? 0 : 2<CR><CR>
nnoremap coT :set showtabline=<C-R>=&showtabline==2 ? 1 : 2<CR><CR>
nnoremap coW :set wrap!<CR>
nnoremap coX set winfixwidth!<CR>

" move lines up and down (modified from tpope/vim-unimpaired)  {{{2
function! s:ExecMove(cmd) abort
  normal! m`
  silent! exe a:cmd
  norm! ``
endfunction

function! s:Move(cmd, count, map) abort
  call s:ExecMove('move'.a:cmd.a:count)
  silent! call repeat#set("\<Plug>unimpairedMove".a:map, a:count)
endfunction

function! s:MoveSelectionUp(count) abort
  call s:ExecMove("'<,'>move'<--".a:count)
  silent! call repeat#set("\<Plug>unimpairedMoveSelectionUp", a:count)
endfunction

function! s:MoveSelectionDown(count) abort
  call s:ExecMove("'<,'>move'>+".a:count)
  silent! call repeat#set("\<Plug>unimpairedMoveSelectionDown", a:count)
endfunction

nnoremap <silent> [e :<C-U>call <SID>Move('--',v:count1,'Up')<CR>
nnoremap <silent> ]e :<C-U>call <SID>Move('+',v:count1,'Down')<CR>
xnoremap <silent> [e :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
xnoremap <silent> ]e :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>

" visual star (asterisk) search  {{{2
" https://github.com/bronson/vim-visual-star-search/blob/master/plugin/visual-star-search.vim
function! VisualStarSearchSet(cmdtype,...)
  let temp = @"
  normal! gvy
  if !a:0 || a:1 != 'raw'
    let @" = escape(@", a:cmdtype.'\*')
  endif
  let @/ = substitute(@", '\n', '\\n', 'g')
  let @/ = substitute(@/, '\[', '\\[', 'g')
  let @/ = substitute(@/, '\~', '\\~', 'g')
  let @/ = substitute(@/, '\.', '\\.', 'g')
  let @" = temp
endfunction
xnoremap * :<C-u>call VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>

" use tab for omni completion  {{{2
function! TabOmniCompletion()
  let col = col('.') - 1
  if pumvisible()
    return "\<C-n>"
  elseif !col || getline('.')[col - 1]  =~ '\s'
    " if cursor is at bol or in front of whitespace
    return "\<Tab>"
  else
    return "\<C-x>\<C-o>"
  endif
endfunction
inoremap <Tab> <C-r>=TabOmniCompletion()<CR>

" Plugin Settings  {{{1
" tpope/vim-markdown (built-in)  {{{2
let g:markdown_fenced_languages = ['bash=sh', 'matlab', 'python', 'vim', 'r']
let g:markdown_folding = 1

" machakann/vim-sandwich  {{{2
runtime macros/sandwich/keymap/surround.vim
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%' ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" sjl/gundo.vim  {{{2
nnoremap <C-k><C-u> :GundoToggle<CR>

" tpope/vim-fugitive  {{{2
nnoremap gs :Gedit :<CR>
nnoremap gZ :Gdiffsplit<CR>zR
nnoremap gC :Git commit<CR>
nnoremap gB :Git blame<CR>
nnoremap <C-k>G :Ggrep!<Space>
nnoremap co<Space> :Git checkout<Space>

" airblade/gitgutter  {{{2
nmap ga <Plug>(GitGutterStageHunk)
xmap ga :GitGutterStageHunk<CR>
nmap ghu <Plug>(GitGutterUndoHunk)
nnoremap <C-_> :let g:gitgutter_preview_win_floating = 1<CR>:GitGutterPreviewHunk<CR>
nnoremap g= :let g:gitgutter_preview_win_floating = 0<CR>:GitGutterPreviewHunk<CR>:wincmd p<CR>0
nnoremap <silent> cog :GitGutterToggle<CR>:echo g:gitgutter_enabled<CR>
nnoremap <silent> coG :GitGutterLineHighlightsToggle<CR>:echo g:gitgutter_highlight_lines<CR>
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_modified_removed = '~'
let g:gitgutter_preview_win_floating = 0
let g:gitgutter_close_preview_on_escape = 1

nnoremap coz :call GitGutterFoldToggle()<CR>
function! GitGutterFoldToggle()
  if gitgutter#utility#getbufvar(bufnr(''), 'folded')
    GitGutterFold
    let l:buffoldexpr = gitgutter#utility#getbufvar(bufnr(''), 'foldexpr')
    if l:buffoldexpr != 0
      let &foldexpr = l:buffoldexpr
    endif
  else
    call gitgutter#utility#setbufvar(bufnr(''), 'foldexpr', &foldexpr)
    GitGutterFold
  endif
endfunction

" map combining nvim lsp diagnostics with gitgutter preview
if has('nvim')
lua << EOF
function _G.has_line_diagnostic(bufnr, line_nr)
  local line_diagnostics = vim.diagnostic.get(bufnr, {lnum=line_nr})
  return not vim.tbl_isempty(line_diagnostics)
end
EOF
nnoremap <expr> =
      \ v:lua.has_line_diagnostic(bufnr('%'), line('.') - 1) ?
      \ ':lua vim.diagnostic.open_float()<CR>' :
      \ ':let g:gitgutter_preview_win_floating = 1<CR>:GitGutterPreviewHunk<CR>'

else
nnoremap = :let g:gitgutter_preview_win_floating = 1<CR>:GitGutterPreviewHunk<CR>
endif

" rbong/vim_flog  {{{2
let g:flog_default_opts = {'date': 'short'}
nmap gl :Flog<CR>

" justinmk/vim-dirvish  {{{2
let g:dirvish_mode = ':sort ,^.*[\/],'
if has('mac')
  let g:loaded_netrwPlugin = 1
  nnoremap gx :execute '!open ' . shellescape(expand('<cfile>'), 1)<CR><CR>
endif

" jeetsukumaran/vim-pythonsense  {{{2
let g:is_pythonsense_suppress_object_keymaps = 1
augroup pythonsense
  autocmd!
  autocmd FileType python vmap <buffer> aC <Plug>(PythonsenseOuterClassTextObject)
  autocmd FileType python omap <buffer> aC <Plug>(PythonsenseOuterClassTextObject)
  autocmd FileType python sunmap <buffer> aC
  autocmd FileType python vmap <buffer> iC <Plug>(PythonsenseInnerClassTextObject)
  autocmd FileType python omap <buffer> iC <Plug>(PythonsenseInnerClassTextObject)
  autocmd FileType python sunmap <buffer> iC
  autocmd FileType python vmap <buffer> am <Plug>(PythonsenseOuterFunctionTextObject)
  autocmd FileType python omap <buffer> am <Plug>(PythonsenseOuterFunctionTextObject)
  autocmd FileType python sunmap <buffer> am
  autocmd FileType python vmap <buffer> im <Plug>(PythonsenseInnerFunctionTextObject)
  autocmd FileType python omap <buffer> im <Plug>(PythonsenseInnerFunctionTextObject)
  autocmd FileType python sunmap <buffer> im
  autocmd FileType python omap <buffer> ad <Plug>(PythonsenseOuterDocStringTextObject)
  autocmd FileType python vmap <buffer> ad <Plug>(PythonsenseOuterDocStringTextObject)
  autocmd FileType python sunmap <buffer> ad
  autocmd FileType python omap <buffer> id <Plug>(PythonsenseInnerDocStringTextObject)
  autocmd FileType python vmap <buffer> id <Plug>(PythonsenseInnerDocStringTextObject)
  autocmd FileType python sunmap <buffer> id
augroup END

" psf/black and fisadev/vim-isort  {{{2
let g:vim_isort_map = ''
augroup pythonformat
  autocmd!
  autocmd FileType python nmap <buffer> gqq :Isort<CR>:Black<CR>
augroup END

" christoomey/vim-tmux-navigator  {{{2
let g:tmux_navigator_no_mappings = 1
if !has('nvim')
  if has('mac')
    execute "set <M-h>=\eh"
    execute "set <M-j>=\ej"
    execute "set <M-k>=\ek"
    execute "set <M-l>=\el"
    execute "set <M-s>=\es"
    execute "set <M-t>=\et"
  else
    execute 'set <M-h>=h'
    execute 'set <M-j>=j'
    execute 'set <M-k>=k'
    execute 'set <M-l>=l'
    execute 'set <M-s>=s'
    execute 'set <M-t>=t'
  endif
endif

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
  if has('nvim')
    tnoremap <silent> <M-h> <C-\><C-N>:TmuxNavigateLeft<CR>
    tnoremap <silent> <M-j> <C-\><C-N>:TmuxNavigateDown<CR>
    tnoremap <silent> <M-k> <C-\><C-N>:TmuxNavigateUp<CR>
    tnoremap <silent> <M-l> <C-\><C-N>:TmuxNavigateRight<CR>
  endif
endif

" jpalardy/vim-slime  {{{2
let g:slime_no_mappings = 1
xmap <C-l>      <Plug>SlimeRegionSend
nmap <C-l>      <Plug>SlimeMotionSend
nmap <C-l><C-l> <Plug>SlimeLineSend
nmap <C-l><CR>  <C-l>ip}j
nmap <C-l><C-j> <C-l><CR>
nmap <C-l><C-]> <C-l><CR>
nmap <C-l><C-k> <C-l>ip
nmap <C-l><C-n> }j
let g:slime_target = 'tmux'
let g:slime_dont_ask_default = 1
if exists('$TMUX')
  let g:slime_default_config = {'socket_name': split($TMUX, ',')[0], 'target_pane': ':.2'}
endif
nnoremap g<C-l> <C-l>

" gabenespoli/vim-mutton  {{{2
let g:mutton_min_center_width = 94
let g:mutton_min_side_width = 25

" Plug 'gabenespoli/vim-tabsms'  {{{2
highlight! link TabMod DiffText
highlight! link TabModSel TabMod

" Lua Plugins  {{{1
if has('nvim')
lua << EOF

-- ibhagwan/fzf-lua  {{{2
local actions = require('fzf-lua.actions')
require 'fzf-lua'.setup{
  actions = {
    files = {
      -- instead of the default action 'actions.file_edit_or_qf'
      -- it's important to define all other actions here as this
      -- table does not get merged with the global defaults
      ["default"]       = actions.file_edit,
      ["ctrl-s"]        = actions.file_split,
      ["ctrl-v"]        = actions.file_vsplit,
      ["ctrl-t"]        = actions.file_tabedit,
      ["ctrl-q"]        = actions.file_sel_to_qf,
    },
  },
  fzf_colors = {
    ['fg']          = { 'fg', 'CursorLine' },
    ['bg']          = { 'bg', 'Normal' },
    ['hl']          = { 'fg', 'Todo' },
    ['fg+']         = { 'fg', 'Normal' },
    ['bg+']         = { 'bg', 'CursorLine' },
    ['hl+']         = { 'fg', 'Todo' },
    ['info']        = { 'fg', 'Comment' },
    ['prompt']      = { 'fg', 'Identifier' },
    ['pointer']     = { 'fg', 'PmenuSel' },
    ['marker']      = { 'fg', 'Keyword' },
    ['spinner']     = { 'fg', 'Label' },
    ['header']      = { 'fg', 'Comment' },
    ['gutter']      = { 'bg', 'Normal' },
  },
}

-- kyazdani42/nvim-web-devicons  {{{2
require('nvim-web-devicons').setup{}

-- neovim/nvim-lspconfig  {{{2
require('vim.lsp.protocol').CompletionItemKind = {
  ' Text', -- Text 
  ' Method', -- Method 
  ' Function', -- Function
  ' Constructor', -- Constructor
  ' Field', -- Field ﰠ
  ' Variable', -- Variable
  'פּ Class', -- Class ﴯפּ
  'ﰮ Interface', -- Interface ﰮ
  ' Module', -- Module
  ' Property', -- Property
  ' Unit', -- Unit
  ' Value', -- Value
  ' Enum', -- Enum
  ' Keyword', -- Keyword 
  '﬌ Snippet', -- Snippet ﬌
  ' Color', -- Color
  ' File', -- File 
  ' Reference', -- Reference 
  ' Folder', -- Folder 
  ' EnumMember', -- EnumMember
  ' Constant', -- Constant
  ' Struct', -- Struct 
  ' Event', -- Event
  ' Operator', -- Operator
  ' TypeParameter', -- TypeParameter
}

-- Setup lsp diagnostics  {{{2
vim.diagnostic.config(
  {
    underline=false,
    virtual_text=false,
    severity_sort=true,
    float={border="rounded"},
  }
)

-- diagnostic signs and highlight groups
local signs = { Error = '', Warn = '', Hint = '', Info = '' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  local hln = hl .. 'Nr'
  vim.fn.sign_define(hl, { text = '', texthl = hl, numhl = hln })
end

-- Setup language servers  {{{2
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {border="rounded"})
  vim.lsp.handlers['textDocument/signature_help'] = vim.lsp.with(vim.lsp.handlers.signature_help, {border="rounded"})
end

require('lspconfig').efm.setup{on_attach=on_attach}
require('lspconfig').bashls.setup{on_attach=on_attach}
require('lspconfig').vimls.setup{on_attach=on_attach}
require('lspconfig').sqlls.setup{
    on_attach=function(client, bufnr)
        require('sqlls').on_attach(client, bufnr)
    end,
}
require('lspconfig').terraformls.setup{on_attach=on_attach}
require('lspconfig').pyright.setup{
  on_attach=on_attach,
  --flags={debounce_text_changes = 150},
  settings={
    python={analysis={typeCheckingMode = 'off'}}
  },
}

-- nvim-treesitter  {{{2
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- nvim-treesitter/playground  {{{2
require('nvim-treesitter.configs').setup {playground = {enable = true}}

EOF

" ibhagwan/fzf-lua  {{{2
nmap <C-p>        :FzfLua git_files<CR>
nmap <C-k><C-b>   :FzfLua buffers<CR>
nmap <C-k>d       :FzfLua lsp_workspace_diagnostics<CR>
nmap <C-k><C-d>   :FzfLua lsp_document_diagnostics<CR>
nmap <C-k><C-g>   :FzfLua live_grep<CR>
nmap <C-k><C-f>   :FzfLua files<CR>
nmap <C-k><C-h>   :FzfLua git_bcommits<CR>
nmap <C-k><C-k>   :FzfLua resume<CR>
nmap <C-k><C-l>   :FzfLua git_commits<CR>
nmap <C-k><C-o>   :FzfLua oldfiles<CR>
nmap <C-k><C-r>   :FzfLua registers<CR>
nmap <C-k><C-s>   :FzfLua git_status<CR>
nmap <C-k><Space> :FzfLua<Space>
nmap <C-k>gr      :FzfLua lsp_references<CR>

" nvim/lsp-config  {{{2
nmap gd :lua vim.lsp.buf.definition()<CR>
nmap gr :lua vim.lsp.buf.references()<CR>
nmap K :lua vim.lsp.buf.hover()<CR>
nmap <silent> [d :lua vim.diagnostic.goto_prev()<CR>
nmap <silent> ]d :lua vim.diagnostic.goto_next()<CR>
nmap <C-k>l :lua vim.diagnostic.setloclist()<CR>
nmap <C-k>r :lua vim.lsp.buf.rename()<CR>

nmap cod :lua vim.diagnostic.disable()<CR>
nmap coD :lua vim.diagnostic.enable()<CR>

augroup nvimlsp
  autocmd!
  autocmd FileType python nmap <buffer> <C-w><C-d> <C-w><C-v>gdzt
  autocmd FileType python nmap <buffer> <C-]> gdzt
augroup END

" nvim-treesitter/playground  {{{2
nnoremap zS :TSHighlightCapturesUnderCursor<CR>

endif
