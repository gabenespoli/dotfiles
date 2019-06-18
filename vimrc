" Author: Gabe Nespoli
" Email: gabenespoli@gmail.com
" File: vimrc/init.vim for vim/nvim
set encoding=utf-8
scriptencoding utf-8

" Plugin Manager {{{1
call plug#begin('~/.vim/plugged')

" general {{{2
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-fold'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'justinmk/vim-dirvish'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'

" tmux {{{2
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'wellle/tmux-complete.vim'
Plug 'jpalardy/vim-slime'

" python & R {{{2
Plug 'jalvesaq/Nvim-R',                {'for': 'r'}
Plug 'goerz/jupytext.vim'
" Plug 'davidhalter/jedi-vim',           {'for': 'python'}
Plug 'vim-scripts/indentpython.vim',   {'for': 'python'}
Plug 'tmhedberg/SimpylFold',           {'for': 'python'}

" markdown {{{2
Plug 'godlygeek/tabular',              {'for': ['markdown', 'pandoc']}
Plug 'rickhowe/diffchar.vim',          {'for': ['markdown', 'pandoc']}
Plug 'gabenespoli/vim-criticmarkup',   {'for': ['markdown', 'pandoc']}
Plug 'jszakmeister/markdown2ctags',    {'for': ['markdown', 'pandoc']}

" json {{{2
Plug 'elzr/vim-json',                  {'for': 'json'}

" my plugins {{{2
Plug 'gabenespoli/vim-colors-snooker'
Plug 'gabenespoli/vim-mutton'
Plug 'gabenespoli/vim-tabsms'
Plug 'gabenespoli/vim-neovim-defaults'
Plug 'gabenespoli/vim-komono'

call plug#end()

" General Settings {{{1
" System {{{2
if has('mac') | set fileformats=unix,dos | endif
set updatetime=750
set undofile
set undodir=~/.config/nvim/undo/
set backupdir=~/.config/nvim/backup/
set directory=~/.config/nvim/swap/
if !isdirectory(expand(&undodir))   | call mkdir(expand(&undodir),   'p') | endif
if !isdirectory(expand(&backupdir)) | call mkdir(expand(&backupdir), 'p') | endif
if !isdirectory(expand(&directory)) | call mkdir(expand(&directory), 'p') | endif

" Options {{{2
set hidden
set number relativenumber
set equalalways splitright splitbelow
set nowrap linebreak breakindent whichwrap+=h,l
set expandtab tabstop=2 softtabstop=2 shiftwidth=2
set listchars+=extends:>,precedes:<
set cursorline
set showmatch
set ignorecase smartcase nohlsearch
set foldlevel=99
set foldmethod=marker
set foldtext=getline(v:foldstart)
set wildignorecase wildmode=list:longest
set completeopt=menuone,preview,longest
set shortmess+=c
set diffopt+=context:3
set suffixesadd+=.m,.r,.R,.py
set clipboard=unnamed
set guioptions=g
set guicursor=n-v-sm:block-blinkon0,i-ci-c:ver25-blinkon0,r-cr-o:hor20-blinkon0
set guifont=IBMPlexMono:h14,Fira\ Code:h14,Menlo:h14,Consolas:h14,Courier:h14

" Status Line {{{2
set statusline=
set statusline+=%{SSHIndicator()}
set statusline+=%#Modified#%m\ %*%n:%<%.99f\ %w%r%y
set statusline+=%{FugitiveStatusline()}
set statusline+=%=%l/%L\,%c\ (%P)
function! SSHIndicator() abort
  if !empty($SSH_CLIENT) || !empty($SSH_TTY) | return '^' | else | return '' | endif
endfunction

" Line Return (https://bitbucket.org/sjl/dotfiles/) {{{2
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END

" Keybindings {{{1
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

" swap single quote (mark bol) and back tick (mark)
nnoremap ' `
nnoremap ` '

" popup menu: esc to exit, enter to select
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" open alternate buffer in a vertial split
nnoremap <C-w><C-^> :vsplit #<CR>

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
nnoremap <expr> zT exists(':Ggrep') == 2 ?
      \ ':Ggrep! "TODO\\|FIXME\\|XXX"<CR><CR>:botright copen<CR>' :
      \ ':vimgrep /TODO\|FIXME\|XXX/j *<CR><CR>:botright copen<CR>'

" Plugin Settings {{{1
" Colorscheme {{{2
let g:snooker_terminal_italics = 1
let g:snooker_color_cursor = 1
colorscheme snooker
nnoremap <silent> yoC :SnookerContrastToggle<CR>:echo g:snooker_high_contrast<CR>
augroup highlight_fold_markers_as_titles
  au!
  " TODO: use &commentstring so this works for all filetypes
  "   currently it's hardcoded for ", #, or %
  " autocmd BufEnter,BufWritePost * 
  "       \ execute 'syntax match FoldMarkerLines /\V^\s\*' . 
  "       \ escape(substitute(&commentstring,"%s","",""), '/') . 
  "       \ '\.\*{{{\d\{0,1\}\$/'
  "       \ | hi! link FoldMarkerLines Title
  autocmd BufEnter,BufWritePost * 
        \ execute 'syntax match FoldMarkerLines /^\s*' . 
        \ '["#%]' . 
        \ '.*{{{\d\{0,1\}$/'
        \ | hi! link FoldMarkerLines Title
augroup END

" general {{{2
" tpope/vim-rsi {{{3
inoremap <C-n> <down>
inoremap <C-p> <up>
inoremap <C-x><C-n> <C-n>
inoremap <C-x><C-p> <C-p>
cnoremap <C-n> <down>
cnoremap <C-p> <up>

" tpope/vim-unimpaired {{{3
nmap co yo
nnoremap <silent> yof :set foldcolumn=<C-R>=&foldcolumn ? 0 : 2<CR><CR>
nnoremap yoFn :set foldmethod=manual<CR>
nnoremap yoFi :set foldmethod=indent<CR>
nnoremap yoFe :set foldmethod=expr<CR>
nnoremap yoFm :set foldmethod=marker<CR>
nnoremap yoFs :set foldmethod=syntax<CR>
nnoremap yoFd :set foldmethod=diff<CR>
nnoremap <silent> yom :set number!<CR>:set relativenumber!<CR>
nnoremap <silent> yoW :set colorcolumn=<C-R>=&colorcolumn ? 0 : &textwidth<CR><CR>
nnoremap <silent> yoS :set laststatus=<C-R>=&laststatus ? 0 : 2<CR><CR>
nmap <silent> <M-S-s> yoS
nnoremap <silent> yoT :set showtabline=<C-R>=&showtabline==2 ? 1 : 2<CR><CR>
nmap <silent> <M-S-t> yoT
nnoremap <silent> yoFM :set filetype=markdown<CR>
nnoremap <silent> yoFT :set filetype=text<CR>
nnoremap <silent> yoFS :set filetype=sh<CR>
nnoremap <silent> yoFJ :set filetype=json<CR>
nnoremap <leader>s 1z=
nnoremap <silent> <expr> <leader>q
      \ empty(filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')) ?
      \ ':botright copen<CR>' : ':cclose<CR>'
nnoremap <silent> <expr> <leader>l
      \ empty(filter(getwininfo(), 'v:val.quickfix && v:val.loclist')) ?
      \ ':botright lopen<CR>' : ':lclose<CR>'
augroup unimpaired
  au!
  autocmd VimEnter * unmap =p
  autocmd VimEnter * unmap =P
augroup END

" tpope/vim-fugitive {{{3
nnoremap gs :Gstatus<CR>
nnoremap gY :Gdiff<CR>
nnoremap gC :Gcommit<CR>
nnoremap gA :Gwrite<CR>

" junegunn/gv.vim {{{3
nnoremap gL :GV!<CR>
nnoremap gl :GV<CR>
xnoremap gl :GV<CR>

" airblade/gitgutter {{{3
nmap ga  <Plug>GitGutterStageHunk
nmap ghu <Plug>GitGutterUndoHunk
nmap gy  <Plug>GitGutterPreviewHunk
nnoremap <silent> yog :GitGutterToggle<CR>:echo g:gitgutter_enabled<CR>
nnoremap <silent> yoG :GitGutterLineHighlightsToggle<CR>:echo g:gitgutter_highlight_lines<CR>
let g:gitgutter_override_sign_column_highlight = 0

" justinmk/vim-dirvish {{{3
let g:dirvish_mode = ':sort ,^.*[\/],'
if has('mac')
  let g:loaded_netrwPlugin = 1
  nnoremap gx :!open <cfile><CR><CR>
endif

" jeetsukumaran/vim-buffergator {{{3
let g:buffergator_autoupdate = 0
let g:buffergator_autodismiss_on_select = 1
let g:buffergator_viewport_split_policy = 'N'
let g:buffergator_suppress_keymaps = 1
nnoremap gb :BuffergatorMruCyclePrev<CR>
nnoremap gB :BuffergatorMruCycleNext<CR>
nnoremap = :BuffergatorToggle<CR>
nnoremap <leader>= :BuffergatorTabsToggle<CR>

" majutsushi/tagbar {{{3
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['+', '-']
let g:tagbar_type_r = {'ctagstype': 'r', 'kinds': ['f:Functions', 'g:GlobalVariables', 'v:FunctionVariables',]}
let g:tagbar_map_jump = ['<CR>', 'o']
let g:tagbar_map_togglefold = ['za']

" ctrlpvim/ctrlp.vim {{{3
nnoremap <C-n> :CtrlP ~/
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_switch_buffer = 0 
let g:ctrlp_prompt_mappings = {
 \ 'PrtSelectMove("j")':     ['<C-n>','<down>'],
 \ 'PrtSelectMove("k")':     ['<C-p>','<up>'],
 \ 'PrtHistory(-1)':         [],
 \ 'PrtHistory(1)':          [],
 \ 'AcceptSelection("e")':   ['<CR>', '<2-LeftMouse>'],
 \ }

" tmux {{{2
" christoomey/vim-tmux-navigator {{{3
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

" jpalardy/vim-slime {{{3
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

" python & R {{{2
" jalvesaq/Nvim-R
let R_assign = 0
let R_esc_term = 0
let R_show_args = 0
let R_objbr_place = 'LEFT'
let rout_follow_colorscheme = 1
let Rout_more_colors = 1

" " davidhalter/jedi-vim
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#smart_auto_mappings = 0
" let g:jedi#popup_on_dot = 0
" let g:jedi#show_call_signatures = 2
" let g:jedi#goto_command = '<localleader>d' " also gD in ftplugin/python.vim
" let g:jedi#goto_assignments_command = '<localleader>g' " also gd
" let g:jedi#rename_command = '<localleader>r'
" let g:jedi#usages_command = '<localleader>n'

" goerz/jupytext.vim
let g:jupytext_fmt = 'py'
let g:jupytext_filetype_map = {'py': 'python'}

" markdown {{{2
" tpope/vim-markdown (built-in) {{{3
let g:markdown_fenced_languages = ['bash=sh', 'matlab', 'python', 'vim']
let g:markdown_folding = 1

" godlygeek/tabular {{{3
nnoremap <leader>\| :Tabularize /\|<CR>

" rickhowe/diffchar {{{3
let g:DiffPairVisible = 0
let g:DiffUpdate = 0
let g:DiffModeSync = 0
nmap yoD    <Plug>ToggleDiffCharAllLines
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
nnoremap <leader>t :TagbarToggle<CR>
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
" gabenespoli/vim-mutton
let g:mutton_min_center_width = 88
let g:mutton_min_side_width = 25

" Lilypond
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
filetype on
