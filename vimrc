" Author: Gabe Nespoli
" Email: gabenespoli@gmail.com
" File: vimrc/init.vim for vim/nvim
set encoding=utf-8
scriptencoding utf-8

" Plugin Manager: {{{1
call plug#begin('~/.vim/plugged')

" Editing: {{{2
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'gabenespoli/vim-unimpaired'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-fold'
Plug 'romainl/vim-qf'

" General: {{{2
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" Plug 'gabenespoli/gv.vim'
Plug '~/bin/vim/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
" Plug '/usr/local/opt/fzf'
" Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'majutsushi/tagbar'
Plug 'ryanoasis/vim-devicons'

" Tmux: {{{2
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'wellle/tmux-complete.vim'
Plug 'jpalardy/vim-slime'

" Coding: {{{2
if has('nvim') | Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} | endif
Plug 'dense-analysis/ale'
" Plug 'puremourning/vimspector'
Plug 'Vimjas/vim-python-pep8-indent',  {'for': ['python']}
Plug 'tmhedberg/SimpylFold'
Plug 'jeetsukumaran/vim-pythonsense',  {'for': ['python']}

" Writing Notes: {{{2
Plug 'godlygeek/tabular',
Plug 'rickhowe/diffchar.vim',          {'for': ['markdown', 'pandoc']}
Plug 'gabenespoli/vim-criticmarkup',   {'for': ['markdown', 'pandoc']}
Plug 'jszakmeister/markdown2ctags',    {'for': ['markdown', 'pandoc']}
Plug '~/bin/vim/vim-toodo'

" My Plugins: {{{2
" Plug 'gabenespoli/vim-colors-snooker'
Plug '~/bin/vim/vim-colors-snooker'
Plug 'gabenespoli/vim-mutton'
Plug 'gabenespoli/vim-tabsms'
Plug 'gabenespoli/vim-neovim-defaults'
Plug 'gabenespoli/vim-komono'
Plug 'gabenespoli/vim-jupycent'

call plug#end()

" General Settings: {{{1
" System: {{{2
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

" Options: {{{2
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
let g:vimsyn_folding='af'
set wildignorecase
set completeopt=menuone,preview
set shortmess+=c
set tags^=.git/tags;~
set diffopt+=context:3
set suffixesadd+=.m,.r,.R,.py
set clipboard=unnamed
set guioptions=g
set guicursor=n-v-sm:block-blinkon0,i-ci-c:ver25-blinkon0,r-cr-o:hor20-blinkon0
set guifont=BlexMono\ Nerd\ Font:h12,IBMPlexMono:h12,Source\ Code\ Pro:h12,Menlo:h12,Consolas:h12,Courier:h12

" Status Line: {{{2
function! SSHIndicator() abort
  if !empty($SSH_CLIENT) || !empty($SSH_TTY) | return '^' | else | return '' | endif
endfunction
set statusline=
set statusline+=%{SSHIndicator()}
set statusline+=[%n]
set statusline+=\ (%{FugitiveHead(12)})
set statusline+=\ %{WebDevIconsGetFileTypeSymbol()}
set statusline+=\ %<%.99f
set statusline+=%#Modified#%m%*
set statusline+=%w%r
set statusline+=%=
if exists("*coc#status") | set statusline+=[%{coc#status()}] | endif
set statusline+=[%l/%L\,%c\ (%P)]

" Line Return (https://bitbucket.org/sjl/dotfiles/): {{{2
augroup line_return
  au!
  au BufReadPost *
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

" paste without cutting
" vnoremap p "_dP

" popup menu: esc to exit, enter to select
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" open alternate buffer in a vertial split
nnoremap <C-w><C-^> :vsplit #<CR>

" resize windows
nnoremap + <C-w>+
nnoremap _ <C-w>>

" toggle fold
nnoremap = za

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

" Plugin Settings: {{{1
" Colorscheme: {{{2
let g:snooker_terminal_italics = 1
let g:snooker_color_cursor = 0
colorscheme snooker
nnoremap <silent> coC :SnookerContrastToggle<CR>:echo g:snooker_high_contrast<CR>

" Editing: {{{2
" tpope/vim-rsi: {{{3
cnoremap <expr> <C-p> pumvisible() ? "\<C-p>" : "\<up>"
cnoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<down>"

" tpope/vim-surround: {{{3
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%' ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" gabenespoli/vim-unimpaired: {{{3
nnoremap cof :set foldcolumn=<C-R>=&foldcolumn ? 0 : 2<CR><CR>
nnoremap coFn :set foldmethod=manual<CR>
nnoremap coFi :set foldmethod=indent<CR>
nnoremap coFe :set foldmethod=expr<CR>
nnoremap coFm :set foldmethod=marker<CR>
nnoremap coFs :set foldmethod=syntax<CR>
nnoremap coFd :set foldmethod=diff<CR>
nnoremap com :set number!<CR>:set relativenumber!<CR>

nnoremap <silent> coW :set colorcolumn=<C-R>=&colorcolumn ? 0 : &textwidth<CR><CR>
nnoremap <silent> coS :set laststatus=<C-R>=&laststatus ? 0 : 2<CR><CR>
nmap <silent> <M-S-s> coS
nnoremap <silent> coT :set showtabline=<C-R>=&showtabline==2 ? 1 : 2<CR><CR>
nmap <silent> <M-S-t> coT

nnoremap coFM :set filetype=markdown<CR>
nnoremap coFT :set filetype=text<CR>
nnoremap coFS :set filetype=sh<CR>
nnoremap coFJ :set filetype=json<CR>

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

" Highlight merge conflict markers
" match Search '\v^(\<|\=|\>){7}([^=].+)?$'

" romainl/vim-qf {{{3
let g:qf_shorten_path = 0
let g:qf_mapping_ack_style = 1

" General: {{{2
" tpope/vim-fugitive: {{{3
" nmap gs :call MyGstatus()<CR>
nnoremap gs :Gstatus<CR>
nnoremap gZ :Gdiff<CR>
nnoremap gC :Gcommit<CR>
nnoremap gA :Gwrite<CR>
xnoremap zp :diffput<CR>
xnoremap zo :diffget<CR>
nnoremap <C-k><C-g> :Ggrep!<Space>

function! MyGstatus()
  Gstatus
  nmap <buffer> o <CR>
  nmap <buffer> q :quit<CR>
endfunction

" airblade/gitgutter: {{{3
nmap ga  <Plug>(GitGutterStageHunk)
xmap ga  :GitGutterStageHunk<CR>
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

" junegunn/gv.vim: {{{3
nnoremap gL :GV --all<CR>
xnoremap gL :GV --all<CR>
nnoremap gl :GV <CR>
xnoremap gl :GV <CR>

" ctrlpvim/ctrlp.vim: {{{3
nnoremap <C-k><C-t> :CtrlPTag<CR>
nnoremap <C-k><C-b> :CtrlPBuffer<CR>
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_switch_buffer = 0 
let g:ctrlp_prompt_mappings = {
 \ 'PrtSelectMove("j")':     ['<C-n>'],
 \ 'PrtSelectMove("k")':     ['<C-p>'],
 \ 'PrtHistory(-1)':         ['<down>'],
 \ 'PrtHistory(1)':          ['<up>'],
 \ 'AcceptSelection("e")':   ['<CR>', '<2-LeftMouse>'],
 \ }
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'

" junegunn/fzf.vim: {{{3
" let $FZF_DEFAULT_OPTS .= ' --layout=default --no-border'
" " let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" nnoremap <C-p>      :MRU<CR>
" nnoremap <C-k><C-p> :Buffers<CR>
" nnoremap <C-k><C-o> :GFiles<CR>
" nnoremap <C-k><C-f> :Files ~<CR>
" nnoremap <C-k>f     :Files<CR>
" nnoremap <C-k>n     :Files ~/notes/<CR>
" nnoremap <C-k><C-g> :Ggrep 
" nnoremap <C-k>g     :GGrep<CR>
" nnoremap <C-k><C-m> :Marks<CR>
" nnoremap <C-k><C-t> :Tags<CR>
" command! -bang -nargs=* MRU call fzf#vim#history(fzf#vim#with_preview())
" command! -bang -nargs=? -complete=dir Files
"       \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" command! -bang -nargs=* GGrep
"       \ call fzf#vim#grep(
"       \ 'git grep --line-number '.shellescape(<q-args>), 0,
"       \ fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
" command! -bang -nargs=* Rg
"       \ call fzf#vim#grep(
"       \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"       \ fzf#vim#with_preview(), <bang>0)

" " CTRL-A CTRL-Q to select all and build quickfix list
" function! s:build_quickfix_list(lines)
"   call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
"   copen
"   cc
" endfunction

" let g:fzf_action = {
"   \ 'ctrl-q': function('s:build_quickfix_list'),
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-v': 'vsplit' }

" let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" justinmk/vim-dirvish: {{{3
let g:dirvish_mode = ':sort ,^.*[\/],'
if has('mac')
  let g:loaded_netrwPlugin = 1
  nnoremap gx :execute '!open ' . shellescape(expand('<cfile>'), 1)<CR><CR>
endif

" dense-analysis/ale: {{{3
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_set_loclist = 0
" let g:ale_set_highlights = 0
" let g:ale_fix_on_save = 1
let g:ale_linters = {'python': ['flake8', 'mypy', 'pydocstyle']}
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'python': ['black', 'isort'],
      \ }
nnoremap [d :ALEPrevious<CR>
nnoremap ]d :ALENext<CR>
nmap <leader>a <Plug>(ale_hover)

" neoclide/coc.nvim: {{{3
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
" nmap <silent> [d <Plug>(coc-diagnostic-prev)
" nmap <silent> ]d <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <leader>gd <C-w>vgdzMzv
nmap <leader>gD <C-w>sgdzMzv
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <C-k><C-l> :CocList<CR>
nnoremap <C-k><C-r> :CocListResume<CR>
nnoremap <C-k><C-d> :CocList diagnostics<CR>
nnoremap <C-k><C-y> :CocList yank<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
endif

" majutsushi/tagbar: {{{3
nnoremap <leader>t :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_type_r = {'ctagstype': 'r', 'kinds': ['f:Functions', 'g:GlobalVariables', 'v:FunctionVariables',]}
let g:tagbar_map_jump = ['<CR>', 'o']
let g:tagbar_map_togglefold = ['za']

" ryanoasis/vim-devicons: {{{3
let g:WebDevIconsOS = 'Darwin'
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['bashrc'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['bash_profile'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['bash_local'] = ''

" Tmux: {{{2
" christoomey/vim-tmux-navigator: {{{3
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

" jpalardy/vim-slime: {{{3
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

" Coding: {{{2
" jeetsukumaran/vim-pythonsense
let g:is_pythonsense_suppress_object_keymaps = 1

" Writing Notes: {{{2
" tpope/vim-markdown (built-in): {{{3
let g:markdown_fenced_languages = ['bash=sh', 'matlab', 'python', 'vim', 'r']
let g:markdown_folding = 1

" godlygeek/tabular: {{{3
nnoremap <leader>\| :Tabularize /\|<CR>

" rickhowe/diffchar: {{{3
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

" gabenespoli/vim-criticmarkup: {{{3
let g:criticmarkup#disable#highlighting = 1

" jszakmeister/markdown2ctags: {{{3
let g:tagbar_type_markdown = {
  \ 'ctagstype': 'markdown',
  \ 'ctagsbin' : '~/.vim/plugged/markdown2ctags/markdown2ctags.py',
  \ 'ctagsargs' : '-f - --sort=yes',
  \ 'kinds' : ['s:sections', 'i:images'],
  \ 'sro' : '|',
  \ 'kind2scope' : {'s' : 'section',},
  \ 'sort': 0,
\ }

" My Plugins: {{{2
" gabenespoli/vim-mutton
let g:mutton_min_center_width = 88
let g:mutton_min_side_width = 25

" Lilypond
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
filetype on
