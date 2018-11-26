" .vimrc file for gabenespoli@gmail.com
" Plugin Manager {{{1
" make sure vim-plug is installed {{{2 
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup vim_plug
    au!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif
call plug#begin('~/.vim/plugged')

" editing {{{2
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'andymass/vim-tradewinds'

" git/diff {{{2
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'mhinz/vim-signify'
Plug 'rickhowe/diffchar.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'

" sidebars & sidebar control {{{2
Plug 'gabenespoli/vim-cider-vinegar'
Plug 'gabenespoli/vim-mutton'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/NERDTree'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'majutsushi/tagbar'
" Plug 'MarcWeber/vim-addon-qf-layout'
Plug 'tacahiroy/ctrlp-funky'

" syntax/linting/highlighting {{{2
Plug 'w0rp/ale'
Plug 'gabenespoli/vim-criticmarkup'
Plug 'jszakmeister/markdown2ctags'
Plug 'gabenespoli/vim-colors-sumach'
" Plug 'vim-python/python-syntax'

" auto-completion {{{2
if has('nvim')
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'wellle/tmux-complete.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim', {'for': 'vim'}
Plug 'lionawurscht/deoplete-biblatex', {'for': ['markdown', 'pandoc']}
Plug 'zchee/deoplete-jedi', {'for': 'python'}

" external {{{2
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'
Plug 'jalvesaq/Nvim-R', {'for': 'r'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}

call plug#end()

" General Settings {{{1
" Environment {{{2
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

" File stuff {{{2
if has('mac') | set fileformats=unix,dos | endif
set updatetime=750
set undofile
set swapfile
set undodir=~/tmp/vim/undo/
set backupdir=~/tmp/vim/backup/
set directory=~/tmp/vim/swap/
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), 'p')
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), 'p')
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), 'p')
endif

" Editing {{{2
set number relativenumber
set cursorline
set equalalways splitright splitbelow
set laststatus=2
set listchars=eol:\ ,tab:>-,trail:~,extends:>,precedes:<
set fillchars=fold:\ ,vert:\|
set backspace=indent,eol,start
set nowrap
set whichwrap+=h,l
set visualbell
set hidden
set clipboard=unnamed
set diffopt+=context:0

" Folding {{{2
set foldminlines=0
set foldlevel=2
set foldtext=FoldSMS_Text()
function! FoldSMS_Text() "{{{
  if &textwidth > 0
    let l:width = &textwidth
  else
    let l:width = 80
  endif

  let prefix = repeat('-', v:foldlevel) . ' '
  let lines = v:foldend - v:foldstart + 1 . ' lines'
  let line = getline(v:foldstart)
  " remove leading comment character(s) and whitespace
  let commentchar = substitute(&commentstring, '%s', '', '')
  let line = substitute(line, '^\s*'.commentchar.'\+\s*', '', '')

  " remove trailing fold characters
  if &foldmethod ==? 'marker'
    let line = substitute(line, '\s*{{{\d\=$', '', 'g') "}}}
  elseif &filetype ==? 'r'
    let line = substitute(line, '[-=#]\{4,\}$', '', 'g')
  elseif &filetype ==? 'markdown' || &filetype ==? 'pandoc'
    if line ==# '---'
      let line = 'YAML'
    else
      let line = substitute(line, '^#\{1,6}\ ', '', 'g')
    endif
    " TODO: if g:FoldSMS_MarkdownFlat == 1, we need to set prefix without
    " using foldlevel
  endif

  " shorten line based on window width; subtract 6 for gutter
  if l:width > winwidth(0) - 6
    let l:width = winwidth(0) - 6
  endif

  " get fill, shorten line if needed
  let lenstuff = len(prefix) + len(lines)
  if len(line) > l:width - lenstuff
    let fill = '... '
    let lastind = l:width - lenstuff - len(fill)
    let line = line[0:lastind-1]
  else
    let fill = repeat(' ', l:width - lenstuff - len(line))
  endif

  return prefix . line . fill . lines
endfunction "}}}

" Tabline {{{2
" Rename tabs to show tab# and # of viewports
" http://stackoverflow.com/questions/5927952/whats-the-implementation-of-vims-default-tabline-function
set tabline=%!MyTabLine()
function! MyTabLine() "{{{
  let s = ''
  let wn = ''
  let t = tabpagenr()
  let i = 1
  while i <= tabpagenr('$')
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)

    let s .= '%#TabLineFill#'
    let s .= '%' . i . 'T'
    let s .= (i == t ? '%1*' : '%2*')
    let s .= ''
    let wn = tabpagewinnr(i,'$')

    "tab/window number
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
    let s .= '[' . i
    if tabpagewinnr(i,'$') > 1
      let s .= '|'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
    end
    let s .= ']%*'

    "modified flag
    let s .= (i == t ? '%#TabModSel#%m' : '%#TabMod#')
    let s .= ' %*'

    "filename
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
    let bufnr = buflist[winnr - 1]
    let file = bufname(bufnr)
    let buftype = getbufvar(bufnr, 'buftype')
    if buftype ==? 'nofile'
      if file =~? '\/.'
        let file = substitute(file, '.*\/\ze.', '', '')
      endif
    else
      let file = fnamemodify(file, ':p:t')
    endif
    if file ==? ''
      let file = '[No Name]'
    endif

    " space until next tab
    let s .= file . ' ' . '%#TablineFill# %*'

    let i = i + 1
  endwhile
  let s .= '%T%#TabLineFill#%='
  return s
endfunction "}}}

" Spacing {{{2
set linebreak
set breakindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Searching {{{2
set wildmenu wildignorecase wildmode=list:longest
set ignorecase smartcase
set incsearch nohlsearch
set showmatch                   " hi matching [{()}]
let loaded_matchparen = 1       " don't match parentheses, use % instead
set suffixesadd+=.m,.r,.R,.py
set completeopt=menuone,preview,noinsert,noselect
set shortmess+=c
if executable('rg')
  set grepprg=rg\ --line-number\ $*
  " set grepprg=git\ grep\ --line-number\ --no-color\ $*
endif

" Status Line {{{2
" ale [+][RO] 'filename' [type] [fugitive] ... line/lines,col (pct)
" use this to add [tab#|win#] ... [%{tabpagenr()}\|%{winnr()}]
set statusline=
set statusline+=%#ErrorMsg#%{ALEStatus('Errors')}%*
set statusline+=%#TodoStatus#%{ALEStatus('Warnings')}%*
" set statusline+=%{mode()}
set statusline+=%#Modified#%m%*%#ReadOnly#%r%*\ %t\ %y
set statusline+=\ %{fugitive#statusline()}
" set statusline+=%#StatusLineFill#%=%*
set statusline+=%=
set statusline+=%l/%L\,%c\ (%P)
" TODO: function to dynamically create statusbar highlights
" - get statusbar background color
" - get desired fg color from another hl group
" - put them together

" GUI Settings {{{2
set guioptions=g
set guicursor=n-v-ve:block-blinkon0
  \,sm:block-blinkon750
  \,i-ci-c:ver25-blinkwait750-blinkon750-blinkoff750
  \,r-cr-o:hor20-blinkwait750-blinkon750-blinkoff750
set guifont=Fira\ Code\ Regular:h14
if has('gui_running')
  set nonumber norelativenumber
  set laststatus=0
  set macligatures
endif

" nvim Terminal Settings {{{2
if has('nvim')
  autocmd TermOpen * setlocal nocursorline nonumber norelativenumber
  " autocmd TermOpen * execute "nnoremap <buffer> <CR> i"
  augroup my_nvim_term
    au!
    " pretend term buffer doesn't have a normal mode
    " autocmd BufWinEnter,WinEnter term://* startinsert
    " autocmd BufLeave term://* stopinsert
    " 'hide' cursor when term doesn't have focus
    autocmd BufWinEnter,WinEnter term://* hi! Cursor ctermbg=7
    autocmd BufLeave term://* hi! Cursor ctermbg=0
  augroup END
endif

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
inoremap jk <Esc>

" general {{{2
nnoremap <C-j> <CR>
nnoremap Y y$
nnoremap q :q<CR>
nnoremap Q q
nnoremap <BS> <C-^>
inoremap <C-n> <down>
inoremap <C-p> <up>
cnoremap <C-n> <down>
cnoremap <C-p> <up>
nnoremap <silent> <M-s> :silent write<CR>
inoremap <silent> <M-s> <Esc>:silent write<CR>a
nnoremap <M-{> :tabprevious<CR>
nnoremap <M-}> :tabnext<CR>
inoremap <M-{> <Esc>:tabprevious<CR>
inoremap <M-}> <Esc>:tabnext<CR>
tnoremap <silent> <C-Space> <C-\><C-N>
tnoremap <silent> <M-{> <C-\><C-N>:tabprevious<CR>
tnoremap <silent> <M-}> <C-\><C-N>:tabnext<CR>
nnoremap <C-w><C-f> <C-w>vgf

" next/previous {{{2
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [e :<C-U>execute 'move -1-'. v:count1<CR>
nnoremap <silent> ]e :<C-U>execute 'move +'. v:count1<CR>
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>

" option toggles (not incl. plugins) {{{2
nnoremap <silent> cob :set background=<C-R>=&background == "dark" ? "light" : "dark"<CR><CR>
nnoremap <silent> coc :set cursorline!<CR>
nnoremap <silent> cod :<C-R>=&diff ? "diffoff" : "diffthis"<CR><CR>
nnoremap <silent> coff :set foldcolumn=<C-R>=&foldcolumn ? 0 : 2<CR><CR>
nnoremap <silent> cofm :set foldmethod=manual<CR>
nnoremap <silent> cofi :set foldmethod=indent<CR>
nnoremap <silent> cofe :set foldmethod=expr<CR>
nnoremap <silent> cofk :set foldmethod=marker<CR>
nnoremap <silent> cofs :set foldmethod=syntax<CR>
nnoremap <silent> cofd :set foldmethod=diff<CR>
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
nnoremap <silent> coy :echo synIDattr(synID(line("."),col("."),1),"name")<CR>
nnoremap <silent> coFm :set filetype=markdown<CR>
nnoremap <silent> coFt :set filetype=text<CR>

" window resizing {{{2
nnoremap _        <C-w>>:echo winwidth('.')<CR>
nnoremap <Right>  <C-w>>:echo winwidth('.')<CR>
nnoremap <Left>   <C-w><:echo winwidth('.')<CR>
nnoremap +        <C-w>+:echo winheight('.')<CR>
nnoremap <Up>     <C-w>+:echo winheight('.')<CR>
nnoremap <Down>   <C-w>-:echo winheight('.')<CR>

" misc {{{2
" swap single quote (mark bol) and back tick (mark)
nnoremap ' `
nnoremap ` '

" Esc to exit pop-up menu without insertion
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-y>" : "\<CR>"

"vimdiff
nnoremap du :diffupdate<CR>
" vnoremap do :diffget<CR>
" vnoremap dp :diffput<CR>
" vnoremap dd d

" Spell checking
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

" Plugin Settings {{{1
" editing {{{2
" godlygeek/tabular
nnoremap <leader>\| :Tabularize /\|<CR>

" git/diff {{{2
" tpope/vim-fugitive
nnoremap gs :Gstatus<CR>
nnoremap gC :Gcommit<CR>
nnoremap gd mx:tabnew %<CR>`x:Gdiff<CR>
nnoremap gA :Gwrite<CR>:write<CR>
nnoremap gl :Glog<CR><CR>:copen<CR>
nnoremap <expr> cd exists(":Gcd") == 2 ? ':Gcd<CR>:pwd<CR>' : ':cd %:p:h<CR>:pwd<CR>'
augroup gitcommit
  au!
  " TODO: make height of window bigger
  autocmd FileType gitcommit nnoremap <buffer> <CR> :wq<CR><CR>
  autocmd FileType gitcommit nnoremap <buffer> <M-s> :wq<CR><CR>:Gstatus<CR>
augroup END

" airblade/gitgutter
nnoremap <silent> cog :GitGutterToggle<CR>:echo g:gitgutter_enabled<CR>
nnoremap <silent> coG :GitGutterLineHighlightsToggle<CR>:echo g:gitgutter_highlight_lines<CR>
nmap ga <Plug>GitGutterStageHunk
nmap ghd <Plug>GitGutterPreviewHunk
nmap ghu <Plug>GitGutterUndoHunk
let g:gitgutter_eager = 0
let g:gitgutter_override_sign_column_highlight = 0

" rickhowe/diffchar
let g:DiffPairVisible = 0
let g:DiffUpdate = 0
let g:DiffModeSync = 0
nmap coD            <Plug>ToggleDiffCharAllLines
nmap <nop>          <Plug>ToggleDiffCharCurrentLine
nmap <nop>          <Plug>JumpDiffCharPrevStart
nmap <nop>          <Plug>JumpDiffCharNextStart
nmap <nop>          <Plug>JumpDiffCharPrevEnd
nmap <nop>          <Plug>JumpDiffCharNextEnd
nmap dO             <Plug>GetDiffCharPair
nmap dP             <Plug>PutDiffCharPair

" sidebars {{{2
" gabenespoli/vim-cider-vinegar {{{3
let g:CiderEnableNERDTree = 1
let g:CiderEnableBuffergator = 1
let g:CiderToggleNERDTree = '-'
let g:CiderToggleBuffergator = '='
" let g:CiderQuitMap = 'q'
let g:CiderToggleQF = '<leader>Q'
let g:CiderToggleLL = '<leader>L'
nnoremap <silent> <expr> <leader>q CiderVinegarListIsOpen('c') ? 
      \ ':cclose<CR>' : ':botright copen<CR>'
nnoremap <silent> <expr> <leader>l CiderVinegarListIsOpen('l') ?
      \ ':lclose<CR>' : ':botright lopen<CR>'

" gabenespoli/vim-mutton {{{3
nnoremap <leader>t :MuttonToggle('tagbar')<CR>
nnoremap <leader>n :MuttonToggle('nerdtree')<CR>
nnoremap <leader>b :MuttonToggle('buffergator')<CR>
let g:mutton_min_center_width = 88
let g:mutton_min_side_width = 25

" ctrlpvim/ctrlp.vim {{{3
nnoremap <C-q> :CtrlPQuickfix<CR>
nnoremap <C-n> :CtrlP<CR>
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_switch_buffer = 0 
if executable('fd')
  let g:ctrlp_user_command = 'fd --color never "" %s'
endif
let g:ctrlp_prompt_mappings = {
 \ 'PrtSelectMove("j")':     ['<C-n>','<down>'],
 \ 'PrtSelectMove("k")':     ['<C-p>','<up>'],
 \ 'PrtHistory(-1)':         [],
 \ 'PrtHistory(1)':          [],
 \ 'AcceptSelection("e")':   ['<C-j>', '<CR>', '<2-LeftMouse>'],
 \ }

" scrooloose/NERDTree {{{3
augroup nerdtree
  au!
  autocmd filetype nerdtree setlocal bufhidden=wipe
  autocmd filetype nerdtree nmap <buffer> <C-j> o
  autocmd filetype nerdtree nnoremap <buffer> q :q<CR>
augroup END
let g:NERDTreeMinimalUI = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeWinPos = 'left'
let g:NERDTreeMapToggleHidden = 'zh'
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapPreview = 'i'
let g:NERDTreeMapPreviewSplit = 'S'
let g:NERDTreeMapPreviewVSplit = 'V'
let g:NERDTreeMapCWD = 'cD'

" jeetsukumaran/vim-buffergator {{{3
let g:buffergator_suppress_keymaps = 1
let g:buffergator_autodismiss_on_select = 0
let g:buffergator_autoupdate = 1
nnoremap gb :BuffergatorMruCyclePrev<CR>
nnoremap gB :BuffergatorMruCycleNext<CR>

" majutsushi/tagbar{{{3
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_show_linenumbers = -1
let g:tagbar_foldlevel = 1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_map_jump = ['<CR>', '<C-j>', 'o']
let g:tagbar_map_preview = 'i'
let g:tagbar_map_showproto = 'p'
let g:tagbar_map_openfold = ['l', '+', 'zo']
let g:tagbar_map_closefold = ['h', '-', 'zc']
let g:tagbar_map_togglefold = 'za'
let g:tagbar_map_toggleautoclose = 'C'
let g:tagbar_map_togglecaseinsensitive = 'I'
let g:tagbar_map_zoomwin = 'A'
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

" tacahiroy/ctrlp-funky {{{3
nnoremap <leader>f :CtrlPFunky<CR>

" syntax/linting/highlighting {{{2
" w0rp/ale
nnoremap <silent> cov :ALEToggle<CR>:echo g:ale_enabled<CR>
nmap [v <Plug>(ale_previous_wrap)
nmap ]v <Plug>(ale_next_wrap)
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '>>'
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

" gabenespoli/vim-colors-sumach
nnoremap <silent> coC :SumachContrastToggle<CR>

" gabenespoli/vim-criticmarkup
let g:criticmarkup#disable#highlighting = 1

" jszakmeister/markdown2ctags {{{3
let g:tagbar_type_pandoc = {
  \ 'ctagstype': 'pandoc',
  \ 'ctagsbin' : '~/.vim/plugged/markdown2ctags/markdown2ctags.py',
  \ 'ctagsargs' : '-f - --sort=yes',
  \ 'kinds' : [
    \ 's:sections',
    \ 'i:images'
  \ ],
  \ 'sro' : '|',
  \ 'kind2scope' : {
    \ 's' : 'section',
  \ },
  \ 'sort': 0,
\ }

let g:tagbar_type_markdown = {
  \ 'ctagstype': 'markdown',
  \ 'ctagsbin' : '~/.vim/plugged/markdown2ctags/markdown2ctags.py',
  \ 'ctagsargs' : '-f - --sort=yes',
  \ 'kinds' : [
    \ 's:sections',
    \ 'i:images'
  \ ],
  \ 'sro' : '|',
  \ 'kind2scope' : {
    \ 's' : 'section',
  \ },
  \ 'sort': 0,
\ }

" auto-completion {{{2
" Shougo/deoplete.vim
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

" lionawurscht/deoplete-biblatex
if exists('g:deoplete#_initialized')
  let g:deoplete#sources#biblatex#bibfile = '~/dotfiles/pandoc/library.bib'
  let g:deoplete#sources#biblatex#startpattern = '\[@|\[-@'
  let g:deoplete#sources#biblatex#delimiter = ';'
  call deoplete#custom#source('biblatex', 'filetypes', ['markdown', 'pandoc'])
endif

" external {{{2
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
let g:slime_target = 'tmux'
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1
nmap <C-l>   <Plug>SlimeLineSend
nmap <M-C-l> :execute "normal \<Plug>SlimeLineSendj"<CR>
nmap <C-k>   <Plug>SlimeParagraphSend
nmap <M-C-k> :execute "normal \<Plug>SlimeParagraphSend}j"<CR>
if exists('$TMUX')
  let g:slime_default_config = {'socket_name': split($TMUX, ',')[0], 'target_pane': ':.1'}
endif

" jalvesaq/Nvim-R {{{3
let R_assign = 0
let R_esc_term = 0
let R_show_args = 0
let R_objbr_place = 'LEFT'
let rout_follow_colorscheme = 1
let Rout_more_colors = 1

" davidhalter/jedi-vim {{{3
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = '' " just use <C-x><C-o>
let g:jedi#goto_command = '<localleader>d'
let g:jedi#goto_assignments_command = '<localleader>g'
let g:jedi#rename_command = '<localleader>r'
let g:jedi#usages_command = '<localleader>n'

" Lilypond {{{3
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
"set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
filetype on
