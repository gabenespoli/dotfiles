" Author: Gabe Nespoli
" Email: gabenespoli@gmail.com
" File: vimrc/init.vim for vim/nvim
scriptencoding utf-8

" Plugin Manager {{{1
call plug#begin('~/.vim/plugged')

" general {{{2
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/NERDTree'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'w0rp/ale'
if has('nvim')
  Plug 'Shougo/deoplete.nvim',         {'do': ':UpdateRemotePlugins'}
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'wellle/tmux-complete.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim',                {'for': 'vim'}
Plug 'zchee/deoplete-jedi',            {'for': 'python'}

" tmux {{{2
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'

" python & R {{{2
Plug 'jalvesaq/Nvim-R',                {'for': 'r'}
Plug 'davidhalter/jedi-vim',           {'for': 'python'}
Plug 'jeetsukumaran/vim-pythonsense',  {'for': 'python'}
Plug 'vim-scripts/indentpython.vim',   {'for': 'python'}
Plug 'tmhedberg/SimpylFold',           {'for': 'python'}
Plug 'numirias/semshi',                {'for': 'python', 'do': ':UpdateRemotePlugins'}
Plug 'szymonmaszke/vimpyter'

" markdown {{{2
Plug 'godlygeek/tabular',              {'for': ['markdown', 'pandoc']}
Plug 'rickhowe/diffchar.vim',          {'for': ['markdown', 'pandoc']}
Plug 'gabenespoli/vim-criticmarkup',   {'for': ['markdown', 'pandoc']}
Plug 'jszakmeister/markdown2ctags',    {'for': ['markdown', 'pandoc']}

" local {{{2
Plug '~/bin/vim/vim-colors-sumach'
Plug '~/bin/vim/vim-cider-vinegar'
Plug '~/bin/vim/vim-mutton'
Plug '~/bin/vim/vim-tabsms'

call plug#end()

" General Settings {{{1
" System {{{2
if has('mac') | set fileformats=unix,dos | endif
set updatetime=750
set undofile
set swapfile
set undodir=~/tmp/vim/undo/
set backupdir=~/tmp/vim/backup/
set directory=~/tmp/vim/swap/
if !isdirectory(expand(&undodir)) | call mkdir(expand(&undodir), 'p') | endif
if !isdirectory(expand(&backupdir)) | call mkdir(expand(&backupdir), 'p') | endif
if !isdirectory(expand(&directory)) | call mkdir(expand(&directory), 'p') | endif
if has('nvim')
  " https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
  let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
  let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
endif

" Colorscheme {{{2
syntax enable
let g:sumach_terminal_italics = 1
let g:sumach_color_cursor = 1
colorscheme sumach
if has('gui_running')
  set background=light
else
  set background=dark
endif

" Options {{{2
set hidden
set visualbell
set number relativenumber
set equalalways splitright splitbelow
set laststatus=2
set nowrap
set whichwrap+=h,l
set backspace=indent,eol,start
set clipboard=unnamed
set listchars=eol:\ ,tab:>-,trail:~,extends:>,precedes:<
set fillchars=fold:\ ,vert:\|
set diffopt+=context:3
set cursorline
set foldlevel=99
set linebreak
set breakindent
set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2
set wildmenu wildignorecase wildmode=list:longest
set ignorecase smartcase
set incsearch nohlsearch
set showmatch                   " hi matching [{()}]
let loaded_matchparen = 1       " don't match parentheses, use % instead
set suffixesadd+=.m,.r,.R,.py
set completeopt=menuone,preview,noinsert,noselect
set shortmess+=c
if executable('rg') | set grepprg=rg\ --line-number\ $* | endif
set guioptions=g
set guicursor=n-v-ve:block-blinkon0
  \,sm:block-blinkon750
  \,i-ci-c:ver25-blinkwait750-blinkon750-blinkoff750
  \,r-cr-o:hor20-blinkwait750-blinkon750-blinkoff750
if has('gui_running')
  set nonumber norelativenumber
  set laststatus=0
endif

" Status Line {{{2
set statusline=
set statusline+=%#ErrorStatus#%{ALEStatus('Errors')}%*
set statusline+=%#TodoStatus#%{ALEStatus('Warnings')}%*
set statusline+=\ %<%.99f
set statusline+=\ %w%#Modified#%m%*%#ReadOnly#%r%*
set statusline+=%y
set statusline+=%{FugitiveStatusline()}
set statusline+=%=
set statusline+=%l/%L\,%c\ (%P)

" Line Return {{{2
" from Steve Losh's (sjl) vimrc
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END

" cursor shape {{{2
if empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
endif

" Keybindings {{{1
" settings {{{2
let maplocalleader = "\<Space>"
nnoremap <Space><Esc> <nop>
set notimeout
set ttimeout

" general {{{2
inoremap jk <Esc>
nnoremap <C-j> <CR>
nnoremap ! :!
nnoremap q :q<CR>
nnoremap Q q
nnoremap Y y$

" next/previous {{{2
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [e :<C-U>execute 'move -1-'. v:count1<CR>
nnoremap <silent> ]e :<C-U>execute 'move +'. v:count1<CR>
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" option toggles (not incl. plugins) {{{2
nnoremap <silent> cob :set background=<C-R>=&background == "dark" ? "light" : "dark"<CR><CR>
nnoremap <silent> coc :set cursorline!<CR>
nnoremap <silent> cod :<C-R>=&diff ? "diffoff" : "diffthis"<CR><CR>
nnoremap <silent> cof :set foldcolumn=<C-R>=&foldcolumn ? 0 : 2<CR><CR>
nnoremap <silent> coh :set hlsearch!<CR>
nnoremap <silent> col :set list!<CR>
nnoremap <silent> com :set number!<CR>:set relativenumber!<CR>
nnoremap <silent> con :set number!<CR>
nnoremap <silent> cop :set colorcolumn=<C-R>=&colorcolumn ? 0 : &textwidth<CR><CR>
nnoremap <silent> cor :set relativenumber!<CR>
nnoremap <silent> cou :set cursorcolumn!<CR>
nnoremap <silent> cos :set spell!<CR>
nnoremap <silent> coS :set laststatus=<C-R>=&laststatus ? 0 : 2<CR><CR>
nnoremap <silent> cow :set wrap!<CR>
nnoremap <silent> cox :set cursorline!<CR>:set cursorcolumn!<CR>
nnoremap <silent> coFm :set filetype=markdown<CR>
nnoremap <silent> coFt :set filetype=text<CR>
nnoremap <silent> zS :echo synIDattr(synID(line("."),col("."),1),"name")<CR>

" misc {{{2
" swap single quote (mark bol) and back tick (mark)
nnoremap ' `
nnoremap ` '

" Esc to exit pop-up menu without insertion
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" spell checking
nnoremap <leader>s 1z=

" insert dates
nnoremap <leader>id "=strftime("%Y-%m-%d")<CR>P
nnoremap <leader>iD "=strftime("%Y-%m-%d %H:%M:%S")<CR>P
nnoremap <leader>ad "=strftime("%Y-%m-%d")<CR>p
nnoremap <leader>aD "=strftime("%Y-%m-%d %H:%M:%S")<CR>p

" open with system on mac
if has('mac') | nnoremap gO :!open <cfile><CR> | endif

" open current file in new tab
nnoremap <C-w><C-t> mx:tabnew %<CR>`x

" prompt to open note
nnoremap <leader>N :edit ~/notes/<C-d> 

" change pwd to that of current file or git repo
nnoremap <expr> cd exists(":Gcd") == 2 ? ':Gcd<CR>:pwd<CR>' : ':cd %:p:h<CR>:pwd<CR>'

" function for grep
nnoremap <leader>/ :lvimgrep // %<CR>:botright lopen<CR>
nnoremap <leader>G :MyGrep 
nnoremap <leader>T :MyGrep TODO<CR>
command! -nargs=+ MyGrep call MyGrep(<q-args>)
function! MyGrep(expr)
  if exists(':Ggrep')
    execute 'Ggrep ' . a:expr
  else
    execute 'grep ' . a:expr . ' *'
  endif
  botright copen
endfunction

" function to check if preview window is open
function! PreviewWindowIsOpen()
  for nr in range(1, winnr('$'))
    if getwinvar(nr, '&previewwindow') == 1
        return 1
    endif
  endfor
  return 0
endfunction

" Plugin Settings {{{1
" general {{{2
" tpope/vim-rsi {{{3
inoremap <C-n> <down>
inoremap <C-p> <up>
cnoremap <C-n> <down>
cnoremap <C-p> <up>

" tpope/vim-fugitive {{{3
nnoremap <expr> gs PreviewWindowIsOpen() ? ':pclose<CR>' : ':Gstatus<CR>'
nnoremap gY :Gdiff<CR>
nnoremap gC :Gcommit<CR>
nnoremap gA :Gwrite<CR>
augroup fugitive
  au!
  autocmd BufRead fugitive://* nnoremap du :diffupdate<CR>
  autocmd BufRead fugitive://* xnoremap <buffer> dp :diffput<CR>
  autocmd BufRead fugitive://* xnoremap <buffer> do :diffget<CR>
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" airblade/gitgutter {{{3
nmap ga <Plug>GitGutterStageHunk
nmap ghu <Plug>GitGutterUndoHunk
nnoremap <expr> gy PreviewWindowIsOpen() ? ':pclose<CR>' : ':call gitgutter#hunk#preview()<CR>'
nnoremap <silent> cog :GitGutterToggle<CR>:echo g:gitgutter_enabled<CR>
nnoremap <silent> coG :GitGutterLineHighlightsToggle<CR>:echo g:gitgutter_highlight_lines<CR>
let g:gitgutter_eager = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_max_signs = 1000

" scrooloose/NERDTree {{{3
let g:NERDTreeMinimalUI = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeWinPos = 'left'
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapPreviewSplit = 'S'
let g:NERDTreeMapPreviewVSplit = 'V'
augroup nerdtree
  au!
  autocmd filetype nerdtree setlocal bufhidden=wipe
  autocmd filetype nerdtree nnoremap <buffer> q :q<CR>
augroup END

" jeetsukumaran/vim-buffergator {{{3
let g:buffergator_autoupdate = 0
let g:buffergator_autodismiss_on_select = 1
let g:buffergator_viewport_split_policy = 'B'
let g:buffergator_hsplit_size = 10
let g:buffergator_suppress_keymaps = 1
nnoremap gb :BuffergatorMruCyclePrev<CR>
nnoremap gB :BuffergatorMruCycleNext<CR>
nnoremap <leader>b :BuffergatorToggle<CR>
nnoremap <leader>B :BuffergatorTabsToggle<CR>

" majutsushi/tagbar {{{3
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_type_r = {
    \ 'ctagstype': 'r',
    \ 'kinds': ['f:Functions', 'g:GlobalVariables', 'v:FunctionVariables',]
\ }

" ctrlpvim/ctrlp.vim & tacahiroy/ctrlp-funky {{{3
nnoremap <C-n> :CtrlP
nnoremap <leader>f :CtrlPFunky<CR>
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_switch_buffer = 0 
if executable('fd') | let g:ctrlp_user_command = 'fd --color never "" %s' | endif
let g:ctrlp_prompt_mappings = {
 \ 'PrtSelectMove("j")':     ['<C-n>','<down>'],
 \ 'PrtSelectMove("k")':     ['<C-p>','<up>'],
 \ 'PrtHistory(-1)':         [],
 \ 'PrtHistory(1)':          [],
 \ 'AcceptSelection("e")':   ['<CR>', '<2-LeftMouse>'],
 \ }

" w0rp/ale {{{3
nnoremap <silent> cov :ALEToggle<CR>:echo g:ale_enabled<CR>
nmap [v <Plug>(ale_previous_wrap)
nmap ]v <Plug>(ale_next_wrap)
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_loclist = 0
let g:ale_linter_aliases = {'octave': 'matlab'}
let g:ale_r_lintr_options = 'lintr::with_defaults(object_usage_linter=NULL, spaces_left_parentheses_linter=NULL, snake_case_linter=NULL, camel_case_linter=NULL, multiple_dots_linter=NULL, absolute_paths_linter=NULL, infix_spaces_linter=NULL, line_length_linter(80))'
let g:ale_python_flake8_options = '--extend-ignore=E221,E266,E261,E3,E402,E501'
function! ALEStatus(type) abort "{{{
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  if a:type ==# 'Errors'
    return l:all_errors == 0 ? '' : printf('[%dE]', all_errors)
  elseif a:type ==# 'Warnings'
    return l:all_non_errors == 0 ? '' : printf('[%dW]', all_non_errors)
  else
    return ''
  endif
endfunction "}}}

" Shuogo/deoplete & completion sources {{{3
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete', v:false)
call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer', 'file']})
imap <expr> <Tab> MyCompletion()
function! MyCompletion() "{{{
  let col = col('.') - 1
  if pumvisible()
    return "\<C-e>\<Space>\<Tab>"
  elseif !col || getline('.')[col - 1]  =~# '\s'
    " if cursor is at bol or in front of whitespace
    return "\<Tab>"
  else
    return deoplete#manual_complete()
  endif
endfunction "}}}

" Shougo/neco-syntax (completion from syntax files)
let g:necosyntax#max_syntax_lines = 1000

" Shougo/neco-vim (vimscript completion)
if !exists('g:necovim#complete_functions')
  let g:necovim#complete_functions = {}
endif
let g:necovim#complete_functions.Ref = 'ref#complete'

" tmux {{{2
" christoomey/vim-tmux-navigator {{{3
let g:tmux_navigator_no_mappings = 1
if !has('nvim')
  if has('mac')
    execute "set <M-h>=\eh"
    execute "set <M-j>=\ej"
    execute "set <M-k>=\ek"
    execute "set <M-l>=\el"
  else
    execute 'set <M-h>=h'
    execute 'set <M-j>=j'
    execute 'set <M-k>=k'
    execute 'set <M-l>=l'
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

" jpalardy/vim-slime {{{3
let g:slime_no_mappings = 1
xmap <C-c>      <Plug>SlimeRegionSend
nmap <C-c>      <Plug>SlimeMotionSend
nmap <C-c><C-c> <Plug>SlimeLineSend
let g:slime_target = 'tmux'
let g:slime_dont_ask_default = 1
if exists('$TMUX')
  let g:slime_default_config = {'socket_name': split($TMUX, ',')[0], 'target_pane': ':.1'}
endif

" python & R {{{2
" jalvesaq/Nvim-R
let R_assign = 0
let R_esc_term = 0
let R_show_args = 0
let R_objbr_place = 'LEFT'
let rout_follow_colorscheme = 1
let Rout_more_colors = 1

" davidhalter/jedi-vim
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = '<localleader>d'
let g:jedi#goto_assignments_command = '<localleader>g'
let g:jedi#rename_command = '<localleader>r'
let g:jedi#usages_command = '<localleader>n'

" numirias/semshi (Python semantic highlighting)
let g:semshi#error_sign	= v:false
let g:semshi#excluded_hl_groups	= ['local', 'unresolved']

" markdown {{{2
" godlygeek/tabular {{{3
nnoremap <leader>\| :Tabularize /\|<CR>

" rickhowe/diffchar {{{3
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

" gabenespoli/vim-criticmarkup {{{3
let g:criticmarkup#disable#highlighting = 1

" jszakmeister/markdown2ctags {{{3
let g:tagbar_type_pandoc = {
  \ 'ctagstype': 'pandoc',
  \ 'ctagsbin' : '~/.vim/plugged/markdown2ctags/markdown2ctags.py',
  \ 'ctagsargs' : '-f - --sort=yes',
  \ 'kinds' : ['s:sections', 'i:images'],
  \ 'sro' : '|',
  \ 'kind2scope' : {'s' : 'section',},
  \ 'sort': 0,
\ }

let g:tagbar_type_markdown = {
  \ 'ctagstype': 'markdown',
  \ 'ctagsbin' : '~/.vim/plugged/markdown2ctags/markdown2ctags.py',
  \ 'ctagsargs' : '-f - --sort=yes',
  \ 'kinds' : ['s:sections', 'i:images'],
  \ 'sro' : '|',
  \ 'kind2scope' : {'s' : 'section',},
  \ 'sort': 0,
\ }

" local {{{2
" gabenespoli/vim-colors-sumach
nnoremap <silent> coC :SumachContrastToggle<CR>

" gabenespoli/vim-cider-vinegar
let g:CiderEnableNERDTree = 1
let g:CiderToggleNERDTree = '-'
" let g:CiderQuitMap = 'q'
let g:CiderToggleQF = '<leader>Q'
let g:CiderToggleLL = '<leader>L'
nnoremap <silent> <expr> <leader>q CiderVinegarListIsOpen('c') ? 
      \ ':cclose<CR>' : ':botright copen<CR>'
nnoremap <silent> <expr> <leader>l CiderVinegarListIsOpen('l') ?
      \ ':lclose<CR>' : ':botright lopen<CR>'

" gabenespoli/vim-mutton
nnoremap <leader>t :MuttonToggle('tagbar')<CR>
nnoremap <leader>n :MuttonToggle('nerdtree')<CR>
nnoremap gS :MuttonToggle('gitcommit')<CR>
let g:mutton_min_center_width = 88
let g:mutton_min_side_width = 25

" Lilypond
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
"set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
filetype on
