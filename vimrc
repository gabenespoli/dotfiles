" .vimrc file for gabenespoli@gmail.com
" Plugin Manager (vim-plug) {{{1
" make sure vim-plug is installed {{{2
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" editing {{{2
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'gabenespoli/vim-impaired'
Plug 'godlygeek/tabular'

" git / diff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rickhowe/diffchar.vim'

" sidebars & sidebar control {{{2
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/NERDTree'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'majutsushi/tagbar'
Plug 'MarcWeber/vim-addon-qf-layout'
Plug 'gabenespoli/vim-cider-vinegar'
Plug 'gabenespoli/vim-mutton'

" completion {{{2
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'lionawurscht/deoplete-biblatex'

" syntax/linting/highlighting {{{2
Plug 'w0rp/ale'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'gabenespoli/vim-criticmarkup'
Plug 'jszakmeister/markdown2ctags'
Plug 'gabenespoli/vim-colors-sumach'

" external {{{2
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'
Plug 'jalvesaq/Nvim-R'

call plug#end()

" General Settings {{{1
" Environment {{{2
if has('nvim')
  let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
  let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
endif

" Colorscheme {{{2
syntax enable
let g:sumach_terminal_italics = 1
colorscheme sumach
if has("gui_running")
  set background=light
else
  set background=dark
endif

" File stuff {{{2
if has("mac") | set fileformats=unix,dos | endif
set updatetime=750
set undofile
set swapfile
set undodir=~/tmp/vim/undo/
set backupdir=~/tmp/vim/backup/
set directory=~/tmp/vim/swap/
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" Editing {{{2
set number relativenumber
set cursorline
set equalalways splitright splitbelow
set laststatus=2
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set fillchars=fold:\ ,vert:\|
set backspace=indent,eol,start
set whichwrap+=h,l
set completeopt=noinsert,menuone,noselect
set visualbell
set hidden
set clipboard=unnamed
set mouse=a

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
if executable('rg')
  set grepprg=rg\ --line-number\ $*
  " set grepprg=git\ grep\ --line-number\ --no-color\ $*
endif

" Folding {{{2
set foldminlines=0              " 0 means we can close a 1-line fold
set foldcolumn=0
set foldlevel=99
set foldmethod=marker
set foldtext=MyFoldText()
function! GetFoldText()
  if &foldmethod == 'marker'
    set foldtext=FoldTextMarker()
  else
    set foldtext=getline(v:foldstart)
  endif
endfunction

function! MyFoldText()
  let size = v:foldend - v:foldstart
  let sizewidth = len(line('$'))
  let blanks = repeat(' ', sizewidth - len(size))
  let sizestr = ' (' . blanks . size . ' lines) '

  let line = getline(v:foldstart)

  " filetype-specific adjustments
  if &filetype == "json"
    if substitute(line, '^\s*{\s*$', '{', '') == '{'
      let line = getline(v:foldstart + 1)
    endif
  elseif (&filetype == "pandoc" || &filetype == "markdown") && line == '---'
    " pandoc yaml front matter
    let line = 'YAML'
  endif

  " strip surrounding whitespace, add fold indent & icon
  let line = substitute(line, '^\s*\(.\{-}\)\s*$', '\1', '')
  let prefix = repeat(' ', v:foldlevel - 1) . '▸ '
  let linestr = prefix . line . ' '

  " shorten linestr if too long
  if !exists("b:foldtextwidth")
    let totalwidth = 80
  elseif b:foldtextwidth <= 0
    let totalwidth = winwidth(0) + b:foldtextwidth
  else
    let totalwidth = b:foldtextwidth
  endif
  let maxpos = totalwidth - len(sizestr)
  if len(linestr) > maxpos
    let linestr = linestr[0:maxpos - 3] . '...'
  endif

  let fillstr = repeat('-', totalwidth - len(linestr) - len(sizestr) + 1)
  return linestr . fillstr . sizestr
endfunction

function! FoldTextMarker()
  let line = getline(v:foldstart)
  let l:foldlevel = split(line, '{'.'{{')
  let l:foldlevel = l:foldlevel[-1]
  let line = substitute(line, '{'.'{{\d\=', '', 'g')
  let cstr = substitute(&commentstring, '%s', '', 'g')
  let line = substitute(line, '^\s*'.cstr.'\+\s*', '', 'g')
  let lines = v:foldend-v:foldstart + 1
  let linesdigits = 4
  if strlen(lines) < linesdigits + 1
    let lines = repeat(' ', linesdigits-strlen(lines)) . lines
  endif
  let prefix = repeat(' ', l:foldlevel-1) . ' ▸ '
  let offset = 24
  let midfix = repeat(' ', winwidth(0)-strlen(prefix . line)-offset)
  return prefix . line . midfix . ' ('. lines .' lines)'
endfunction

" Status Line {{{2
" ale [+][RO] 'filename' [type][fugitive] ... line/lines,col (pct)
" use this to add [tab#|win#] ... [%{tabpagenr()}\|%{winnr()}]
set statusline=
set statusline+=%#ErrorMsg#%{LinterStatus('Errors')}%*
set statusline+=%#WarningMsg#%{LinterStatus('Warnings')}%*
" set statusline+=%{mode()}
set statusline+=\ %#DiffText#%m%*%#DiffDelete#%r%*\"%t\"\ %y
set statusline+=%{fugitive#statusline()}
" set statusline+=%#StatusLineFill#%=%*                      
set statusline+=%=
set statusline+=%l/%L\,%c\ (%P)                           

" GUI Settings {{{2
set guioptions=g
set guicursor=n-v-ve:block-blinkon0
  \,sm:block-blinkon750
  \,i-ci-c:ver25-blinkwait750-blinkon750-blinkoff750
  \,r-cr-o:hor20-blinkwait750-blinkon750-blinkoff750
set guifont=Fira\ Code\ Regular:h14
if has("gui_running")
  set nonumber norelativenumber
  set laststatus=0
  set macligatures
  let g:gitgutter_signs = 0
endif

" nvim Terminal Settings {{{2
if has('nvim')
  autocmd TermOpen * setlocal nocursorline nonumber norelativenumber
  autocmd TermOpen * execute "nnoremap <buffer> <CR> i"
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
  autocmd BufWinEnter,WinEnter term://* hi! Cursor ctermbg=7
  autocmd BufLeave term://* hi! Cursor ctermbg=0
  tnoremap <silent> <C-v> <C-\><C-N>
endif

" misc {{{2
" Line Return {{{3
" from Steve Losh's (sjl) vimrc
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END

" tmux make cursor line when in insert mode {{{3
" Change cursor shape from block (command mode) to line (insert mode)
" tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users
if !has('nvim') || !has('gui_running')
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif

" Keybindings {{{1
" settings
let maplocalleader = "\<Space>"
nnoremap <Space><Esc> <nop>
set notimeout
set ttimeout
inoremap jk <Esc>

" general
nnoremap Y y$
nnoremap q :q<CR>
nnoremap Q q
cnoremap <C-n> <down>
cnoremap <C-p> <up>
if has('nvim')
  nnoremap <M-s> :w<CR>
  inoremap <M-s> <Esc>:w<CR>a
  nnoremap <M-{> gT
  nnoremap <M-}> gt
  tnoremap <M-{> <C-\><C-N>gT
  tnoremap <M-}> <C-\><C-N>gt
else
  nnoremap <Esc>s :w<CR>
  inoremap <Esc>s <Esc>:w<CR>a
endif

" resizing windows
nnoremap = <C-w>>
nnoremap + <C-w>+

" swap single quote (mark bol) and back tick (mark)
nnoremap ' `
nnoremap ` '

" Esc to exit pop-up menu without insertion
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"

" change pwd to git root if in repo (vim-fugitive), else current file's dir
nnoremap <expr> cd exists(":Gcd")==2 ? ':Gcd<CR>:pwd<CR>' : ':cd %:p:h<CR>:pwd<CR>'

"vimdiff
nnoremap du :diffupdate<CR>

" Spell checking
nnoremap <leader>s 1z=

" insert dates
nnoremap <leader>id "=strftime("%Y-%m-%d")<CR>P
nnoremap <leader>iD "=strftime("%Y-%m-%d %H:%M:%S")<CR>P
nnoremap <leader>ad "=strftime("%Y-%m-%d")<CR>p
nnoremap <leader>aD "=strftime("%Y-%m-%d %H:%M:%S")<CR>p

" open with system on mac
if has("mac") | nnoremap gO :!open <cfile><CR> | endif

" Plugin Settings {{{1
" tpope/vim-commentary {{{2
autocmd FileType octave setlocal commentstring=%\ %s
autocmd FileType cfg,remind setlocal commentstring=#\ %s

" tpope/vim-fugitive {{{2
nnoremap gs :execute "Gstatus"<CR>:execute "resize ".&lines/2<CR>
nnoremap gd :Gdiff<CR>
nnoremap gA :Gwrite<CR>
nnoremap gC :let @" = expand("%:t")<CR>:Gcommit<CR>""pa:<Space>
nmap gcC gC
nnoremap gl :Glog<CR><CR>:copen<CR>
autocmd FileType gitcommit nnoremap <buffer> gC :silent wq<CR>
autocmd FileType gitcommit nnoremap <buffer> gcC :silent wq<CR>

" airblade/gitgutter {{{2
nmap ga <Plug>GitGutterStageHunk
nnoremap ghc :GitGutterStageHunk<CR>:Gcommit<CR>i
nmap ghd <Plug>GitGutterPreviewHunk
nmap ghu <Plug>GitGutterUndoHunk
let g:gitgutter_eager = 0
let g:gitgutter_override_sign_column_highlight = 0

" rickhowe/diffchar {{{2
let g:DiffPairVisible = 0
let g:DiffUpdate = 0
nmap <leader>d      <Plug>ToggleDiffCharAllLines
nmap <leader>D      <Plug>ToggleDiffCharCurrentLine
nmap [d             <Plug>JumpDiffCharPrevStart
nmap ]d             <Plug>JumpDiffCharNextStart
nmap <nop>          <Plug>JumpDiffCharPrevEnd
nmap <nop>          <Plug>JumpDiffCharNextEnd
nmap dO             <Plug>GetDiffCharPair
nmap dP             <Plug>PutDiffCharPair

" ctrlpvim/ctrlp.vim {{{2
nnoremap <C-q> :CtrlPQuickfix<CR>
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

" scrooloose/NERDTree {{{2
let g:NERDTreeMinimalUI = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeWinPos = 'left'
let g:NERDTreeMapToggleHidden = 'zh'
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapPreview = 'i'
let g:NERDTreeMapPreviewSplit = 'S'
let g:NERDTreeMapPreviewVSplit = 'V'
let g:NERDTreeMapJumpNextSibling = '<C-n>'
let g:NERDTreeMapJumpPrevSibling = '<C-p>'
let g:NERDTreeMapCWD = 'cD'

" jeetsukumaran/vim-buffergator {{{2
let g:buffergator_suppress_keymaps = 1
let g:buffergator_viewport_split_policy = "N"

" majutsushi/tagbar{{{2
let g:tagbar_left = 1
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

" MarcWeber/vim-addon-qf-layout {{{2
let g:vim_addon_qf_layout = {}
let g:vim_addon_qf_layout.quickfix_formatters = [
  \ 'vim_addon_qf_layout#DefaultFormatter',
  \ 'vim_addon_qf_layout#FormatterNoFilename',
  \ 'vim_addon_qf_layout#Reset',
  \ 'NOP',
  \ ]
let g:vim_addon_qf_layout.lhs_cycle = '<buffer> \v'

" gabenespoli/vim-cider-vinegar {{{2
let g:CiderVinegarToggle = '-'
let g:CiderVinegarToggleBuffers = '<leader>b'
let g:CiderVinegarToggleQF = '<leader>q'
let g:CiderVinegarToggleLL = '<leader>l'
let g:CiderVinegarEnableNERDTree = 1
let g:CiderVinegarEnableBuffergator = 1

" gabenespoli/vim-mutton {{{2
nnoremap <leader>m :MuttonToggle<CR>
nnoremap <leader>t :MuttonTagbarToggle<CR>

" Shougo/deoplete.vim {{{2
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete', v:false)
inoremap <silent> <expr> <Tab>
  \ pumvisible() ? deoplete#smart_close_popup()."\<Tab>" :
  \ <SID>check_back_space() ? "\<Tab>" :
  \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" lionawurscht/deoplete-biblatex {{{2
let g:deoplete#sources#biblatex#bibfile = '~/dotfiles/pandoc/library.bib'
let g:deoplete#sources#biblatex#startpattern = '\[@|\[-@'
let g:deoplete#sources#biblatex#delimiter = ';'
call deoplete#custom#source('biblatex', 'filetypes', ['markdown', 'pandoc'])

" w0rp/ale {{{2
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '??'
let g:ale_linter_aliases = {'octave': 'matlab'}
let g:ale_r_lintr_options = 'lintr::with_defaults(object_usage_linter=NULL, spaces_left_parentheses_linter=NULL, snake_case_linter=NULL, camel_case_linter=NULL, multiple_dots_linter=NULL, absolute_paths_linter=NULL, infix_spaces_linter=NULL, line_length_linter(80))'
function! LinterStatus(type) abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  if a:type == 'Errors'
    return l:all_errors == 0 ? '' : printf('%dE', all_errors)
  elseif a:type == 'Warnings'
    return l:all_non_errors == 0 ? '' : printf('%dW', all_non_errors)
  else
    return ''
  endif
endfunction
nmap [v <Plug>(ale_previous_wrap)
nmap ]v <Plug>(ale_next_wrap)

" vim-pandoc/vim-pandoc-syntax {{{2
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#codeblocks#embeds#langs = ["vim", "bash=sh", "python", "matlab", "octave", "R"]
let g:markdown_fenced_languages = g:pandoc#syntax#codeblocks#embeds#langs

" gabenespoli/vim-criticmarkup {{{2
let g:criticmarkup#disable#highlighting = 1


" jszakmeister/markdown2ctags {{{2
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

" Lilypond {{{2
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
"set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
filetype on

" christoomey/vim-tmux-navigator {{{2
let g:tmux_navigator_no_mappings = 1
if has('nvim')
  tnoremap <silent> <A-h> <C-\><C-N>:TmuxNavigateLeft<CR>
  tnoremap <silent> <A-j> <C-\><C-N>:TmuxNavigateDown<CR>
  tnoremap <silent> <A-k> <C-\><C-N>:TmuxNavigateUp<CR>
  tnoremap <silent> <A-l> <C-\><C-N>:TmuxNavigateRight<CR>
  inoremap <silent> <A-h> <C-\><C-N>:TmuxNavigateLeft<CR>
  inoremap <silent> <A-j> <C-\><C-N>:TmuxNavigateDown<CR>
  inoremap <silent> <A-k> <C-\><C-N>:TmuxNavigateUp<CR>
  inoremap <silent> <A-l> <C-\><C-N>:TmuxNavigateRight<CR>
  nnoremap <silent> <A-h> <Esc>:TmuxNavigateLeft<CR>
  nnoremap <silent> <A-j> <Esc>:TmuxNavigateDown<CR>
  nnoremap <silent> <A-k> <Esc>:TmuxNavigateUp<CR>
  nnoremap <silent> <A-l> <Esc>:TmuxNavigateRight<CR>

elseif has('gui_running') && has('gui_macvim')
  " TODO need to unmap D-h and D-l before this will work
  nmap <silent> <D-h> <C-w>h<CR>
  nmap <silent> <D-j> <C-w>j<CR>
  nmap <silent> <D-k> <C-w>k<CR>
  nmap <silent> <D-l> <C-w>l<CR>
  imap <silent> <D-h> <Esc><C-w>h<CR>
  imap <silent> <D-j> <Esc><C-w>j<CR>
  imap <silent> <D-k> <Esc><C-w>k<CR>
  imap <silent> <D-l> <Esc><C-w>l<CR>
  vmap <silent> <D-h> <Esc><C-w>h<CR>
  vmap <silent> <D-j> <Esc><C-w>j<CR>
  vmap <silent> <D-k> <Esc><C-w>k<CR>
  vmap <silent> <D-l> <Esc><C-w>l<CR>

else
  if substitute(system('hostname'), '\n', '', '') == 'gmac'
    execute "set <M-h>=\eh"
    execute "set <M-j>=\ej"
    execute "set <M-k>=\ek"
    execute "set <M-l>=\el"
  else
    execute "set <M-h>=h"
    execute "set <M-j>=j"
    execute "set <M-k>=k"
    execute "set <M-l>=l"
  endif
  nmap <silent> <M-h> :TmuxNavigateLeft<CR>
  nmap <silent> <M-j> :TmuxNavigateDown<CR>
  nmap <silent> <M-k> :TmuxNavigateUp<CR>
  nmap <silent> <M-l> :TmuxNavigateRight<CR>
  imap <silent> <M-h> <Esc>:TmuxNavigateLeft<CR>
  imap <silent> <M-j> <Esc>:TmuxNavigateDown<CR>
  imap <silent> <M-k> <Esc>:TmuxNavigateUp<CR>
  imap <silent> <M-l> <Esc>:TmuxNavigateRight<CR>
  vmap <silent> <M-h> <Esc>:TmuxNavigateLeft<CR>
  vmap <silent> <M-j> <Esc>:TmuxNavigateDown<CR>
  vmap <silent> <M-k> <Esc>:TmuxNavigateUp<CR>
  vmap <silent> <M-l> <Esc>:TmuxNavigateRight<CR>
endif

" jpalardy/vim-slime {{{2
let g:slime_target = "tmux"
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1
nmap <C-l>   <Plug>SlimeLineSend
nmap <M-C-l> :execute "normal \<Plug>SlimeLineSendj"<CR>
nmap <C-k>   <Plug>SlimeParagraphSend
nmap <M-C-k> :execute "normal \<Plug>SlimeParagraphSend}j"<CR>
if exists('$TMUX')
  let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.1"}
endif

" jalvesaq/Nvim-R {{{2
let R_assign = 0
let R_esc_term = 0
let R_show_args = 0
let R_objbr_place = 'LEFT'
let g:rout_follow_colorscheme = 1

" Shougo/deoplete.vim {{{2
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete', v:false)
inoremap <silent> <expr> <Tab>
  \ pumvisible() ? deoplete#smart_close_popup()."\<Tab>" :
  \ <SID>check_back_space() ? "\<Tab>" :
  \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" lionawurscht/deoplete-biblatex {{{2
let g:deoplete#sources#biblatex#bibfile = '~/dotfiles/pandoc/library.bib'
let g:deoplete#sources#biblatex#startpattern = '\[@|\[-@'
let g:deoplete#sources#biblatex#delimiter = ';'
call deoplete#custom#source('biblatex', 'filetypes', ['markdown', 'pandoc'])

" w0rp/ale {{{2
nnoremap coy :ALEToggle<CR>:echo g:ale_enabled<CR>
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '??'
let g:ale_linter_aliases = {'octave': 'matlab'}
let g:ale_r_lintr_options = 'lintr::with_defaults(object_usage_linter=NULL, spaces_left_parentheses_linter=NULL, snake_case_linter=NULL, camel_case_linter=NULL, multiple_dots_linter=NULL, absolute_paths_linter=NULL, infix_spaces_linter=NULL, line_length_linter(80))'
function! LinterStatus(type) abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  if a:type == 'Errors'
    return l:all_errors == 0 ? '' : printf('%dE', all_errors)
  elseif a:type == 'Warnings'
    return l:all_non_errors == 0 ? '' : printf('%dW', all_non_errors)
  else
    return ''
  endif
endfunction
nmap [v <Plug>(ale_previous_wrap)
nmap ]v <Plug>(ale_next_wrap)

" vim-pandoc/vim-pandoc-syntax {{{2
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#codeblocks#embeds#langs = ["vim", "bash=sh", "python", "matlab", "octave", "R"]
let g:markdown_fenced_languages = g:pandoc#syntax#codeblocks#embeds#langs

" gabenespoli/vim-criticmarkup {{{2
let g:criticmarkup#disable#highlighting = 1

" rickhowe/diffchar {{{2
let g:DiffPairVisible = 0
let g:DiffUpdate = 0
nmap <leader>d      <Plug>ToggleDiffCharAllLines
nmap <leader>D      <Plug>ToggleDiffCharCurrentLine
nmap [d             <Plug>JumpDiffCharPrevStart
nmap ]d             <Plug>JumpDiffCharNextStart
nmap <nop>          <Plug>JumpDiffCharPrevEnd
nmap <nop>          <Plug>JumpDiffCharNextEnd
nmap dO             <Plug>GetDiffCharPair
nmap dP             <Plug>PutDiffCharPair

" Lilypond {{{2
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
"set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
filetype on
