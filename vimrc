" Author: Gabe Nespoli
" Email: gabenespoli@gmail.com
" File: vimrc/init.vim for vim/nvim
set encoding=utf-8
scriptencoding utf-8

" Plugins: {{{1
call plug#begin('~/.vim/plugged')

" Editing:
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'gabenespoli/vim-unimpaired'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-fold'
Plug 'romainl/vim-qf'
Plug 'junegunn/vim-peekaboo'

" General:
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'gabenespoli/gv.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'roginfarrer/vim-dirvish-dovish', {'branch': 'main'}
Plug 'kristijanhusak/vim-dirvish-git'

" Coding:
Plug 'dense-analysis/ale'
Plug 'natebosch/vim-lsc'
Plug 'liuchengxu/vista.vim'
Plug 'majutsushi/tagbar'
Plug 'Vimjas/vim-python-pep8-indent',  {'for': ['python']}
Plug 'kalekundert/vim-coiled-snake'
Plug 'jeetsukumaran/vim-pythonsense',  {'for': ['python']}

" Writing:
Plug 'junegunn/vim-easy-align'
Plug 'rickhowe/diffchar.vim',          {'for': ['markdown', 'pandoc']}
Plug 'gabenespoli/vim-criticmarkup',   {'for': ['markdown', 'pandoc']}
Plug 'jszakmeister/markdown2ctags',    {'for': ['markdown', 'pandoc']}

" Tmux:
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'

" My Plugins:
Plug 'gabenespoli/vim-mutton'
Plug 'gabenespoli/vim-tabsms'
Plug 'gabenespoli/vim-neovim-defaults'
Plug 'gabenespoli/vim-komono'
Plug 'gabenespoli/vim-jupycent'

call plug#end()

" General: {{{1
if has('mac') | set fileformats=unix,dos | endif
set updatetime=300
set undofile
set undodir=~/.config/nvim/undo/
set backupdir=~/.config/nvim/backup/
set directory=~/.config/nvim/swap/
if !isdirectory(expand(&undodir))   | call mkdir(expand(&undodir),   'p') | endif
if !isdirectory(expand(&backupdir)) | call mkdir(expand(&backupdir), 'p') | endif
if !isdirectory(expand(&directory)) | call mkdir(expand(&directory), 'p') | endif
if has('macunix')
  let g:python_host_prog = expand('~').'/miniconda/envs/neovim2/bin/python'
  let g:python3_host_prog = expand('~').'/miniconda/envs/neovim3/bin/python'
else
  let g:python3_host_prog = expand('~').'/.pyenv/neovim3/bin/python'
endif
set hidden
set nomodeline
set number
set equalalways splitright splitbelow
set nowrap linebreak breakindent whichwrap+=h,l
set expandtab tabstop=2 softtabstop=2 shiftwidth=2
set listchars+=extends:>,precedes:<
set formatoptions-=t
set cursorline
set showmatch
set ignorecase smartcase nohlsearch
set foldlevel=99
set foldmethod=marker
set foldtext=getline(v:foldstart)
let g:vimsyn_folding='af'
set wildignorecase
set completeopt=menuone
set shortmess+=c
set tags^=.git/tags;~
set diffopt+=context:3
set suffixesadd+=.m,.r,.R,.py
set clipboard=unnamed
set guioptions=g
set guicursor=n-v-sm:block-blinkon0,i-ci-c:ver25-blinkon0,r-cr-o:hor20-blinkon0
set guifont=BlexMono\ Nerd\ Font:h12,IBMPlexMono:h12,Source\ Code\ Pro:h12,Menlo:h12,Consolas:h12,Courier:h12
let g:snooker_terminal_italics = 1
colorscheme snooker

" Status Line: {{{1
function! SSHIndicator() abort
  if !empty($SSH_CLIENT) || !empty($SSH_TTY) | return '^' | else | return '' | endif
endfunction
set statusline=
set statusline+=%{SSHIndicator()}
set statusline+=[%n]
set statusline+=\ (%{FugitiveHead(12)})
set statusline+=\ %<%.99f
set statusline+=\ %y%h%w%#Modified#%m%*%r
set statusline+=%=
set statusline+=%{LinterStatus()}
set statusline+=[%l/%L\,%c\ (%P)]

" display errors from Ale in statusline (https://kadekillary.work/post/statusline-vim/)
function! LinterStatus() abort
   let l:counts = ale#statusline#Count(bufnr(''))
   let l:all_errors = l:counts.error + l:counts.style_error
   let l:all_non_errors = l:counts.total - l:all_errors
   return l:counts.total == 0 ? '' : printf(
   \ '[E:%d W:%d]',
   \ l:all_errors,
   \ l:all_non_errors
   \)
endfunction

" Line Return (https://bitbucket.org/sjl/dotfiles/): {{{2
augroup line_return
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END

" Keybindings: {{{1
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

" close preview window (alternative to builtin <C-w>z)
nnoremap <silent> <leader>z :pclose<CR>

" echo syntax under cursor
nnoremap <silent> zS :echo synIDattr(synID(line("."),col("."),1),"name")<CR>

" change pwd to that of current file or git repo
nnoremap <expr> cd exists(":Gcd") == 2 ? ':Gcd<CR>:pwd<CR>' : ':cd %:p:h<CR>:pwd<CR>'

" add last search to location list
nnoremap z/ :lvimgrep // %<CR>:botright lopen<CR>

" grep [git] folder for todos
nnoremap <expr> zT 
      \ exists(':Ggrep') == 2 ?
      \ ':Ggrep! "TODO\\|FIXME\\|XXX"<CR><CR>:botright copen<CR>' :
      \ ':vimgrep /TODO\|FIXME\|XXX/j *<CR><CR>:botright copen<CR>'

" Plugin Settings: {{{1
" tpope/vim-rsi: {{{2
cnoremap <expr> <C-p> pumvisible() ? "\<C-p>" : "\<up>"
cnoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<down>"

" tpope/vim-surround: {{{2
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%' ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" gabenespoli/vim-unimpaired: {{{2
nnoremap cof :set foldcolumn=<C-R>=&foldcolumn ? 0 : 2<CR><CR>
nnoremap <expr> cot
      \ &softtabstop==2 ?
      \ ':set tabstop=4 softtabstop=4 shiftwidth=4<CR>:echo 4<CR>' :
      \ ':set tabstop=2 softtabstop=2 shiftwidth=2<CR>:echo 2<CR>'

nnoremap <silent> coW :set colorcolumn=<C-R>=&colorcolumn ? 0 : &textwidth<CR><CR>
nnoremap <silent> coS :set laststatus=<C-R>=&laststatus ? 0 : 2<CR><CR>
nnoremap <silent> coT :set showtabline=<C-R>=&showtabline==2 ? 1 : 2<CR><CR>
nmap <silent> <M-S-t> coT

nnoremap <silent> <expr> <leader>q
      \ empty(filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')) ?
      \ ':botright copen<CR>' : ':cclose<CR>'
nnoremap <silent> <expr> <leader>l
      \ empty(filter(getwininfo(), 'v:val.quickfix && v:val.loclist')) ?
      \ ':botright lopen<CR>' : ':lclose<CR>'

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END

" map down and up to c/lnext and c/lprevious
" lnext/lprevious if location list is open, else cnext/cprevious
nnoremap <silent> <expr> <down>
      \ empty(filter(getwininfo(), 'v:val.loclist')) ?
      \ ':cnext<CR>' : ':lnext<CR>'
nnoremap <silent> <expr> <up>
      \ empty(filter(getwininfo(), 'v:val.loclist')) ?
      \ ':cprevious<CR>' : ':lprevious<CR>'

nnoremap <expr> coX &winfixwidth ? ':set nowinfixwidth<CR>' : ':set winfixwidth<CR>'
nnoremap <leader>s 1z=

" romainl/vim-qf: {{{2
let g:qf_shorten_path = 0
let g:qf_mapping_ack_style = 1

" kshenoy/vim-signature: {{{2
nnoremap com :SignatureToggle<CR>

" tpope/vim-fugitive: {{{2
nnoremap gs :Gedit :<CR>
nnoremap gZ :Gdiff<CR>
nnoremap gC :Gcommit<CR>
nnoremap gA :Gwrite<CR>
xnoremap zp :diffput<CR>
xnoremap zo :diffget<CR>
nnoremap <C-k><C-g> :Ggrep!<Space>
nnoremap co<Space> :Git co<Space>

" airblade/gitgutter: {{{2
nmap ga <Plug>(GitGutterStageHunk)
xmap ga :GitGutterStageHunk<CR>
nmap ghu <Plug>(GitGutterUndoHunk)
nmap =  <Plug>(GitGutterPreviewHunk)
nnoremap <silent> cog :GitGutterToggle<CR>:echo g:gitgutter_enabled<CR>
nnoremap <silent> coG :GitGutterLineHighlightsToggle<CR>:echo g:gitgutter_highlight_lines<CR>
let g:gitgutter_override_sign_column_highlight = 0

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

" junegunn/gv.vim: {{{2
nnoremap gL :GV --all<CR>
xnoremap gL :GV --all<CR>
nnoremap gl :GV <CR>
xnoremap gl :GV <CR>

" junegunn/fzf.vim: {{{2
nnoremap <C-p>      :GFiles<CR>
nnoremap <C-k><C-p> :Files <C-r>=expand('%:h')<CR><CR>
nnoremap <C-k><C-f> :History<CR>
nnoremap <C-k><C-b> :Buffers<CR>
nnoremap <C-k><C-g> :Rg<CR>

augroup fzf
  autocmd!
  autocmd FileType fzf tnoremap <buffer> <C-p> <Up>
  autocmd FileType fzf tnoremap <buffer> <C-n> <Down>
  autocmd FileType fzf tnoremap <buffer> <Up> <C-p>
  autocmd FileType fzf tnoremap <buffer> <Down> <C-n>
augroup END

let g:fzf_history_dir = '~/.local/share/fzf-history'

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" justinmk/vim-dirvish: {{{2
let g:dirvish_mode = ':sort ,^.*[\/],'
if has('mac')
  let g:loaded_netrwPlugin = 1
  nnoremap gx :execute '!open ' . shellescape(expand('<cfile>'), 1)<CR><CR>
endif

" dense-analysis/ale: {{{2
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_set_loclist = 0
let g:ale_linters = {'python': ['flake8', 'pydocstyle']}
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'python': ['black', 'isort'],
      \ }
let g:ale_python_black_options = '--line-length=79'
let g:ale_python_isort_options = '--line-width=79 --force-single-line-imports'
nnoremap [d :ALEPrevious<CR>
nnoremap ]d :ALENext<CR>
nnoremap coy :ALEToggle<CR>
augroup ale
  autocmd!
  autocmd FileType python nnoremap <buffer> gqq :ALEFix<CR>
augroup END

" natebosch/vim-lsc:  {{{2
let g:lsc_server_commands = {'python': 'pyls'}
let g:lsc_enable_autocomplete = v:false
let g:lsc_enable_diagnostics = v:false
let g:lsc_auto_map = {
      \ 'GoToDefinition': '<C-]>',
      \ 'FindReferences': 'gr',
      \ 'FindImplementations': 'gI',
      \ 'Rename': 'gR',
      \ 'ShowHover': v:true,
      \ 'DocumentSymbol': 'go',
      \ 'WorkspaceSymbol': 'gS',
      \ 'SignatureHelp': 'gm',
      \ 'Completion': 'completefunc',
      \ }
nnoremap <C-w><C-]> :vertical LSClientGoToDefinitionSplit<CR>

" liuchengxu/vista.vim:  {{{2
let g:vista_executive_for = {'python': 'vim_lsc'}
let g:vista_sidebar_width = 40

" majutsushi/tagbar: {{{2
nnoremap <leader>t :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_type_r = {'ctagstype': 'r', 'kinds': ['f:Functions', 'g:GlobalVariables', 'v:FunctionVariables',]}
let g:tagbar_map_jump = ['<CR>', 'o']
let g:tagbar_map_togglefold = ['za']

" jeetsukumaran/vim-pythonsense
let g:is_pythonsense_suppress_object_keymaps = 1

augroup pythonsense
  autocmd!
  autocmd FileType python vmap <buffer> aC <Plug>(PythonsenseOuterClassTextObject)
  autocmd FileType python omap <buffer> aC <Plug>(PythonsenseOuterClassTextObject)
  autocmd FileType python sunmap <buffer> aC
  autocmd FileType python vmap <buffer> iC <Plug>(PythonsenseInnerClassTextObject)
  autocmd FileType python omap <buffer> iC <Plug>(PythonsenseInnerClassTextObject)
  autocmd FileType python sunmap <buffer> iC
  autocmd FileType python vmap <buffer> af <Plug>(PythonsenseOuterFunctionTextObject)
  autocmd FileType python omap <buffer> af <Plug>(PythonsenseOuterFunctionTextObject)
  autocmd FileType python sunmap <buffer> af
  autocmd FileType python vmap <buffer> if <Plug>(PythonsenseInnerFunctionTextObject)
  autocmd FileType python omap <buffer> if <Plug>(PythonsenseInnerFunctionTextObject)
  autocmd FileType python sunmap <buffer> if
  autocmd FileType python omap <buffer> ad <Plug>(PythonsenseOuterDocStringTextObject)
  autocmd FileType python vmap <buffer> ad <Plug>(PythonsenseOuterDocStringTextObject)
  autocmd FileType python sunmap <buffer> ad
  autocmd FileType python omap <buffer> id <Plug>(PythonsenseInnerDocStringTextObject)
  autocmd FileType python vmap <buffer> id <Plug>(PythonsenseInnerDocStringTextObject)
  autocmd FileType python sunmap <buffer> id
augroup END

" Writing: {{{2
" tpope/vim-markdown (built-in): {{{2
let g:markdown_fenced_languages = ['bash=sh', 'matlab', 'python', 'vim', 'r']
let g:markdown_folding = 1

" junegunn/vim-easy-align: {{{2
nmap cg <Plug>(EasyAlign)

" rickhowe/diffchar: {{{2
let g:DiffPairVisible = 0
let g:DiffUpdate = 0
let g:DiffModeSync = 0
nmap coD    <Plug>ToggleDiffCharAllLines
nmap <Plug> <Plug>ToggleDiffCharCurrentLine
nmap <Plug> <Plug>JumpDiffCharPrevStart
nmap <Plug> <Plug>JumpDiffCharNextStart
nmap <Plug> <Plug>JumpDiffCharPrevEnd
nmap <Plug> <Plug>JumpDiffCharNextEnd
nmap dO     <Plug>GetDiffCharPair
nmap dP     <Plug>PutDiffCharPair

" gabenespoli/vim-criticmarkup: {{{2
let g:criticmarkup#disable#highlighting = 1

" jszakmeister/markdown2ctags: {{{2
let g:tagbar_type_markdown = {
  \ 'ctagstype': 'markdown',
  \ 'ctagsbin' : '~/.vim/plugged/markdown2ctags/markdown2ctags.py',
  \ 'ctagsargs' : '-f - --sort=yes',
  \ 'kinds' : ['s:sections', 'i:images'],
  \ 'sro' : '|',
  \ 'kind2scope' : {'s' : 'section',},
  \ 'sort': 0,
\ }

" christoomey/vim-tmux-navigator: {{{2
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

" jpalardy/vim-slime: {{{2
let g:slime_no_mappings = 1
xmap <C-l>      <Plug>SlimeRegionSend
nmap <C-l>      <Plug>SlimeMotionSend
nmap <C-l><C-l> <Plug>SlimeLineSend
let g:slime_target = 'tmux'
let g:slime_dont_ask_default = 1
if exists('$TMUX')
  let g:slime_default_config = {'socket_name': split($TMUX, ',')[0], 'target_pane': ':.2'}
endif
nnoremap g<C-l> <C-l>

" gabenespoli/vim-mutton: {{{2
let g:mutton_min_center_width = 88
let g:mutton_min_side_width = 25

" Lilypond: {{{2
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
filetype on
