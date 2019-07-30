" Author: Gabe Nespoli
" Email: gabenespoli@gmail.com
" File: vimrc/init.vim for vim/nvim
set encoding=utf-8
scriptencoding utf-8

" Plugin Manager {{{1
call plug#begin('~/.vim/plugged')

" editing {{{2
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'gabenespoli/vim-unimpaired'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-fold'

" general {{{2
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'majutsushi/tagbar'

" tmux {{{2
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'wellle/tmux-complete.vim'
Plug 'jpalardy/vim-slime'

" coding {{{2
if has('nvim') | Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} | endif
Plug 'goerz/jupytext.vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tmhedberg/SimpylFold'
Plug 'kkoomen/vim-doge'

" writing & notes {{{2
Plug 'godlygeek/tabular',
Plug 'rickhowe/diffchar.vim',          {'for': ['markdown', 'pandoc']}
Plug 'gabenespoli/vim-criticmarkup',   {'for': ['markdown', 'pandoc']}
Plug 'jszakmeister/markdown2ctags',    {'for': ['markdown', 'pandoc']}
Plug '~/bin/vim/vim-toodo'

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
set updatetime=300
set undofile
set undodir=~/.config/nvim/undo/
set backupdir=~/.config/nvim/backup/
set directory=~/.config/nvim/swap/
if !isdirectory(expand(&undodir))   | call mkdir(expand(&undodir),   'p') | endif
if !isdirectory(expand(&backupdir)) | call mkdir(expand(&backupdir), 'p') | endif
if !isdirectory(expand(&directory)) | call mkdir(expand(&directory), 'p') | endif
let g:python_host_prog = expand('~').'/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = expand('~').'/.pyenv/versions/neovim3/bin/python'

" Options {{{2
set hidden
set nomodeline
set number relativenumber
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
set wildignorecase wildmode=list:longest
set completeopt=menuone,preview,longest
set shortmess+=c
set diffopt+=context:3
set suffixesadd+=.m,.r,.R,.py
set clipboard=unnamed
set guioptions=g
set guicursor=n-v-sm:block-blinkon0,i-ci-c:ver25-blinkon0,r-cr-o:hor20-blinkon0
set guifont=IBMPlexMono:h12,Source\ Code\ Pro:h12,Menlo:h12,Consolas:h12,Courier:h12

" Status Line {{{2
set statusline=
set statusline+=%{SSHIndicator()}
set statusline+=%#Modified#%m\ %*%n:%<%.99f\ %w%r%y
set statusline+=%{FugitiveStatusline()}
if has('nvim') | set statusline+=[%{coc#status()}] | endif
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

" select last paste selection
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

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
nnoremap <silent> coC :SnookerContrastToggle<CR>:echo g:snooker_high_contrast<CR>
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

" editing {{{2
" tpope/vim-rsi {{{3
cnoremap <C-n> <down>
cnoremap <C-p> <up>

" tpope/vim-surround {{{3
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%' ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" tpope/vim-unimpaired {{{3
nnoremap <silent> cof :set foldcolumn=<C-R>=&foldcolumn ? 0 : 2<CR><CR>
nnoremap coFn :set foldmethod=manual<CR>
nnoremap coFi :set foldmethod=indent<CR>
nnoremap coFe :set foldmethod=expr<CR>
nnoremap coFm :set foldmethod=marker<CR>
nnoremap coFs :set foldmethod=syntax<CR>
nnoremap coFd :set foldmethod=diff<CR>
nnoremap <silent> com :set number!<CR>:set relativenumber!<CR>
nnoremap <silent> coW :set colorcolumn=<C-R>=&colorcolumn ? 0 : &textwidth<CR><CR>
nnoremap <silent> coS :set laststatus=<C-R>=&laststatus ? 0 : 2<CR><CR>
nmap <silent> <M-S-s> coS
nnoremap <silent> coT :set showtabline=<C-R>=&showtabline==2 ? 1 : 2<CR><CR>
nmap <silent> <M-S-t> coT
nnoremap <silent> coFM :set filetype=markdown<CR>
nnoremap <silent> coFT :set filetype=text<CR>
nnoremap <silent> coFS :set filetype=sh<CR>
nnoremap <silent> coFJ :set filetype=json<CR>
nnoremap <leader>s 1z=
nnoremap <silent> <expr> <leader>q
      \ empty(filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')) ?
      \ ':botright copen<CR>' : ':cclose<CR>'
nnoremap <silent> <expr> <leader>l
      \ empty(filter(getwininfo(), 'v:val.quickfix && v:val.loclist')) ?
      \ ':botright lopen<CR>' : ':lclose<CR>'

" general {{{2
" tpope/vim-fugitive {{{3
nnoremap gs :Gstatus<CR>
nnoremap gZ :Gdiff<CR>
nnoremap gC :Gcommit<CR>
nnoremap gA :Gwrite<CR>

" junegunn/gv.vim {{{3
nnoremap gL :GV!<CR>
nnoremap gl :GV<CR>
xnoremap gl :GV<CR>

" airblade/gitgutter {{{3
nmap ga  <Plug>GitGutterStageHunk
nmap ghu <Plug>GitGutterUndoHunk
nmap gz  <Plug>GitGutterPreviewHunk
nnoremap <silent> cog :GitGutterToggle<CR>:echo g:gitgutter_enabled<CR>
nnoremap <silent> coG :GitGutterLineHighlightsToggle<CR>:echo g:gitgutter_highlight_lines<CR>
let g:gitgutter_override_sign_column_highlight = 0

" ryanoasis/vim-devicons {{{3
let g:WebDevIconsOS = 'Darwin'
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['bashrc'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['bash_profile'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['bash_local'] = ''

" justinmk/vim-dirvish {{{3
let g:dirvish_mode = ':sort ,^.*[\/],'
if has('mac')
  let g:loaded_netrwPlugin = 1
  nnoremap gx :!open <cfile><CR><CR>
endif

" kristijanhusak/vim-dirvish-git {{{3
hi link DirvishGitModified Type
hi link DirvishGitStaged Statement
hi link DirvishGitRenamed Identifier
hi link DirvishGitUnmerged Debug
hi link DirvishGitIgnored Comment
hi link DirvishGitUntracked Operator

" majutsushi/tagbar {{{3
nnoremap <leader>t :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['▸', '▾']
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
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30,results:30'

" neoclide/coc.nvim {{{3
if has('nvim')
let g:coc_enable_locationlist = 0
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
nnoremap <silent> <expr> coy g:coc_enabled ? ':CocDisable<CR>' : ':CocEnable<CR>'
nmap <silent> [y <Plug>(coc-diagnostic-prev)
nmap <silent> ]y <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
endif

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

" coding {{{2
" goerz/jupytext.vim
let g:jupytext_fmt = 'py'
let g:jupytext_filetype_map = {'py': 'python'}

" writing & notes {{{2
" tpope/vim-markdown (built-in) {{{3
let g:markdown_fenced_languages = ['bash=sh', 'matlab', 'python', 'vim']
let g:markdown_folding = 1

" kkoomen/vim-doge {{{3
let g:doge_doc_standard_python = 'google'

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
