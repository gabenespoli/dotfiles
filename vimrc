" .vimrc file for gabenespoli@gmail.com
" Plugin Manager (vim-plug) {{{1
" make sure vim-plug is installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" editing {{{2
Plug 'vim-scripts/matchit.zip'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rickhowe/diffchar.vim'
Plug 'vim-scripts/ReplaceWithRegister'

" sidebars {{{2
Plug 'gabenespoli/vim-mutton'
Plug 'gabenespoli/vim-cider-vinegar'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'scrooloose/NERDTree'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jszakmeister/markdown2ctags'
Plug 'MarcWeber/vim-addon-qf-layout'

" syntax, highlighting, linting {{{2
Plug 'gabenespoli/vim-colors-solarized'
Plug 'w0rp/ale'
Plug 'tmux-plugins/vim-tmux'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'gabenespoli/vim-criticmarkup'
Plug 'jvirtanen/vim-octave'
" colorschemes
Plug '~/bin/vim/vim-colors-palettes'
if has("gui_running")
  Plug 'reedes/vim-colors-pencil'
  Plug 'altercation/vim-colors-solarized'
  Plug 'morhetz/gruvbox'
endif

" external {{{2
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'

call plug#end()

" General Settings {{{1
" Colorscheme {{{2
function! SetColorpalette(palette)
  let g:solarized_palette = a:palette
  colorscheme solarized
endfunction
command! -nargs=1 Colorpalette :call SetColorpalette(<f-args>)
cnoreabbrev colorpalette Colorpalette

syntax enable
let g:solarized_bold = 1
let g:solarized_italic = 1
let g:solarized_underline = 1
let g:palettes_terminal_italics = 1
if has("gui_running")
  set background=light
  colorscheme pencil
else
  set background=dark
  colorscheme palettes
endif

" File stuff {{{2
if has("mac") | set fileformats=unix,dos | endif
set updatetime=750
set undofile
set swapfile
set undodir=~/bin/vim/tmp/undo/
set backupdir=~/bin/vim/tmp/backup/
set directory=~/bin/vim/tmp/swap/
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
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
set equalalways splitright splitbelow
set laststatus=2                " 0 = no status bar, 2 = show status bar
set showtabline=1               " 0 = no tabline, 1 = show if > 1 tab, 2 = always
set nolist listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set backspace=indent,eol,start
set whichwrap+=h,l              " let h and l move across lines
set visualbell
set hidden
set clipboard=unnamed
set fillchars=fold:\ ,vert:\|

" Spacing {{{2
set linebreak                   " stop soft wrapping in the middle of words  
set breakindent                 " auto indent soft wrap line breaks
set tabstop=2                   " number of visual spaces per TAB
set softtabstop=2               " number of spaces in tab when editing
set shiftwidth=2
set expandtab                   " tabs are spaces

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
set guioptions=
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

" Keybindings {{{1
" settings {{{2
let maplocalleader = "\<Space>"
nnoremap <Space><Esc> <nop>
set notimeout
set ttimeout
inoremap jk <Esc>

" general {{{2
nnoremap Y y$
nnoremap q :q<CR>
nnoremap Q q
if has('nvim')
  nnoremap <M-s> :w<CR>
  inoremap <M-s> <Esc>:w<CR>a
else
  nnoremap <Esc>s :w<CR>
  inoremap <Esc>s <Esc>:w<CR>a
endif
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]
cnoremap <C-n> <down>
cnoremap <C-p> <up>

" emacs-style movement {{{2
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
if has('nvim')
  inoremap <M-f> <S-Right>
  inoremap <M-b> <S-Left>
  inoremap <M-d> <Esc>ldwi
  cnoremap <M-f> <S-Right>
  cnoremap <M-b> <S-Left>
else
  inoremap <Esc>f <S-Right>
  inoremap <Esc>b <S-Left>
  inoremap <Esc>d <Esc>ldwi
  cnoremap <Esc>f <S-Right>
  cnoremap <Esc>b <S-Left>
endif

" misc {{{2
" status/info toggles
nnoremap <silent> <leader>F :call ToggleTabline()<CR>
nnoremap <silent> <leader>S :call ToggleStatusBar()<CR>
nnoremap <leader>W :echo WordCount()<CR>
nnoremap <leader>Y :echo GetSyntaxUnderCursor()<CR>
" change pwd to git root if in repo (vim-fugitive), else current file's dir
nnoremap <expr> cd exists(":Gcd")==2 ? ':Gcd<CR>' : ':cd %:p:h<CR>'
" insert dates
nnoremap <leader>id "=strftime("%Y-%m-%d")<CR>P
nnoremap <leader>iD "=strftime("%Y-%m-%d %H:%M:%S")<CR>P
nnoremap <leader>ad "=strftime("%Y-%m-%d")<CR>p
nnoremap <leader>aD "=strftime("%Y-%m-%d %H:%M:%S")<CR>p
"vimdiff
nnoremap du :diffupdate<CR>
" Spell checking
nnoremap <leader>s 1z=
" open with system on mac
if has("mac") | nnoremap gO :!open <cfile><CR> | endif

" Plugin Settings {{{1
" tpope/vim-unimpaired {{{2
nmap co yo
nnoremap com :set relativenumber!<CR>:set number!<CR>
nnoremap coH :call SearchHighlightToggle()<CR>
nnoremap cop :call ToggleColorColumn()<CR>
nnoremap <expr> cof &foldcolumn ? ':set foldcolumn=0<CR>' : ':set foldcolumn=2<CR>'
nnoremap coFl :set foldmethod=manual<CR>
nnoremap coFi :set foldmethod=indent<CR>
nnoremap coFe :set foldmethod=expr<CR>
nnoremap coFm :set foldmethod=marker<CR>
nnoremap coFs :set foldmethod=syntax<CR>
nnoremap coFd :set foldmethod=diff<CR>

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
nnoremap cog :GitGutterToggle<CR>:echo g:gitgutter_enabled<CR>
let g:gitgutter_eager = 0
let g:gitgutter_override_sign_column_highlight = 0

" gabenespoli/vim-mutton {{{2
nnoremap <leader>m :MuttonToggle<CR>
nnoremap <leader>t :MuttonTagbarToggle<CR>

" junegunn/fzf {{{2
nnoremap <leader><leader> :call fzf#run({'source': 'find -L ~/dotfiles ~/projects ~/bin ~/lib ~/notes ~/todo ~/Dropbox/web ~/local -type f -not -path "*/\.*"', 'sink':  'edit'})<CR>
nnoremap <expr> <leader>f system("git rev-parse --show-toplevel 2>/dev/null") == 0 ? ':Files<CR>' : ':GFiles<CR>'
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>B :Buffers<CR>
nnoremap gl :Commits!<CR>
let g:fzf_layout = { 'up': '~40%' }
let g:fzf_action = { 'ctrl-s': 'split' }
let g:fzf_history_dir = '~/lib/fzf/history'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Search'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Error'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" jeetsukumaran/vim-buffergator {{{2
let g:buffergator_viewport_split_policy = "N"
let g:buffergator_suppress_keymaps = 1

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

" gabenespoli/vim-cider-vinegar {{{2
let g:CiderVinegarToggle = '<leader>o'
let g:CiderVinegarToggleBuffers = '<leader>b'
let g:CiderVinegarToggleQF = '<leader>q'
let g:CiderVinegarToggleLL = '<leader>l'

" majutsushi/tagbar{{{2
let g:tagbar_left = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_show_linenumbers = -1
let g:tagbar_foldlevel = 1
let g:tagbar_iconchars = ['+', '-']
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

" MarcWeber/vim-addon-qf-layout {{{2
let g:vim_addon_qf_layout = {}
let g:vim_addon_qf_layout.quickfix_formatters = [
  \ 'vim_addon_qf_layout#DefaultFormatter',
  \ 'vim_addon_qf_layout#FormatterNoFilename',
  \ 'vim_addon_qf_layout#Reset',
  \ 'NOP',
  \ ]
let g:vim_addon_qf_layout.lhs_cycle = '<buffer> \v'

" christoomey/vim-tmux-navigator {{{2
let g:tmux_navigator_no_mappings = 1
if has('nvim')
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
  tnoremap <silent> [b <C-\><C-N>:bprevious<CR>
  tnoremap <silent> ]b <C-\><C-N>:bnext<CR>
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
  nnoremap <silent> <A-l> <esc>:TmuxNavigateRight<CR>

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

" vim-pandoc/pandoc {{{2
" vim-pandoc
" see other settings in .vim/ftplugin/markdown.vim
let g:pandoc#modules#enabled = ["keyboard"]
let g:pandoc#keyboard#enabled_submodules = ["sections", "styles"]

" vim-pandoc/vim-pandoc-syntax {{{2
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#conceal#urls = 0
let g:pandoc#syntax#conceal#blacklist = ["atx", "ellipses"]
let g:pandoc#syntax#codeblocks#embeds#langs = ["vim", "bash=sh", "python", "matlab", "octave", "R"]
let g:markdown_fenced_languages = g:pandoc#syntax#codeblocks#embeds#langs

" gabenespoli/vim-criticmarkup {{{2
let g:criticmarkup#disable#highlighting = 1

" rickhowe/diffchar {{{2
map  <leader>D      <Plug>ToggleDiffCharAllLines
map  <leader>d      <Plug>ToggleDiffCharCurrentLine
nmap [d             <Plug>JumpDiffCharPrevStart
nmap ]d             <Plug>JumpDiffCharNextStart
nmap <F13>          <Plug>JumpDiffCharPrevEnd
nmap <F14>          <Plug>JumpDiffCharNextEnd
nmap dO             <Plug>GetDiffCharPair
nmap dP             <Plug>PutDiffCharPair

" Lilypond {{{2
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
"set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
filetype on

" Functions {{{1
" Toggle Tabline {{{2
function! ToggleTabline()
  " 0 = never, 1 = if > 1 tab, 2 = always
  if &showtabline==0
    set showtabline=2
  elseif &showtabline==1
    set showtabline=0
  elseif &showtabline==2
    set showtabline=1
  endif
  echo 'set showtabline='.&showtabline
endfunction

" Toggle Status Bar {{{2
function! ToggleStatusBar()
  if &laststatus == 2
    set laststatus=0
  elseif &laststatus == 0
    set laststatus=2
  endif
endfunction

" Toggle Search Highlight Colour {{{2
function! SearchHighlightToggle()
  let bgcolor=synIDattr(hlID('Search'), 'bg#')
  if bgcolor == 1
    execute "hi Search ctermbg=0 ctermfg=none cterm=none"
  elseif bgcolor == 0
    execute "hi Search ctermbg=12 ctermfg=8 cterm=none"
  elseif bgcolor == 12
    execute "hi Search ctermbg=8 ctermfg=none cterm=none"
  elseif bgcolor == 8
    execute "hi Search ctermbg=1 ctermfg=15 cterm=none"
  endif
endfunction

" Toggle Color Column {{{2
function! ToggleColorColumn()
  if &filetype == "matlab" || &filetype == "octave"
    let l:col = 75
  else
    let l:col = 80
  endif
  if &colorcolumn == l:col
    execute "set colorcolumn=\"\""
  else
    execute "set colorcolumn=".l:col
  endif
endfunction

" Toggle csv tsv {{{2
function! ToggleCsvTsv()
  if exists("b:delimiter")
    if b:delimiter==","
      exe "%s/,/\t/g"
      let b:delimiter="\t"
    elseif b:delimiter=="\t"
      exe "%s/\t/,/g"
      let b:delimiter=","
    endif
  else
    echo "b:delimiter is not defined."
  endif
endfunction

" Get Syntax Under Cursor {{{2
function! GetSyntaxUnderCursor() 
  let g:SyntaxUnderCursor = synIDattr(synID(line("."),col("."),1),"name")
  return g:SyntaxUnderCursor
endfunction

" Word Count {{{2
function! WordCount()
" http://stackoverflow.com/questions/114431/fast-word-count-function-in-vim
  let lnum = 1
  let n = 0
  while lnum <= line('$')
    let n = n + len(split(getline(lnum)))
    let lnum = lnum + 1
  endwhile
  return n
endfunction

" Resize windows based on terminal size {{{2
" for some reason nvim doesn't know the correct &columns until after startup
" so, we have to use autocmds for width and height
let g:centerwidth = 100
function! ResizeCenterWidth()
  execute 'vertical resize '.100
endfunction
function! ResizeSideWidth()
  execute 'vertical resize '.&columns/4
endfunction
function! ResizeSideHeight()
  execute 'resize '.&lines/4
endfunction
nnoremap <leader>rc :call ResizeCenterWidth()<CR>
nnoremap <leader>rw :call ResizeSideWidth()<CR>
nnoremap <leader>rh :call ResizeSideHeight()<CR>

" Line Return {{{2
" from Steve Losh's (sjl) vimrc
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END

"" Tab names {{{2
"" Rename tabs to show tab# and # of viewports
"" http://stackoverflow.com/questions/5927952/whats-the-implementation-of-vims-default-tabline-function
"if exists("+showtabline")
"  let s:currentShowtabline = &showtabline
"  function! MyTabLine()
"    let s = ''
"    let wn = ''
"    let t = tabpagenr()
"    let i = 1
"    while i <= tabpagenr('$')
"      let buflist = tabpagebuflist(i)
"      let winnr = tabpagewinnr(i)

"      let s .= '%#TabLineFill#'
"      let s .= '%' . i . 'T'
"      let s .= (i == t ? '%1*' : '%2*')
"      let s .= ''
"      let wn = tabpagewinnr(i,'$')

"      "tab/window number
"      let s .= (i == t ? '%#TabNumSel#' : '%#TabNum#')
"      let s .= '['
"      let s .= i
"      if tabpagewinnr(i,'$') > 1
"        let s .= '|'
"        let s .= (i == t ? '%#TabWinNumSel#' : '%#TabWinNum#')
"        let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
"      end
"      let s .= ']%*'

"      "modified flag
"      let s .= (i == t ? '%#TabModSel#%m%r' : '%#TabMod#')
"      let s .= ' %*'

"      "filename
"      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
"      if !exists("TabooTabName(i)") || TabooTabName(i) == ''
"        let bufnr = buflist[winnr - 1]
"        let file = bufname(bufnr)
"        let buftype = getbufvar(bufnr, 'buftype')
"        if buftype == 'nofile'
"          if file =~ '\/.'
"            let file = substitute(file, '.*\/\ze.', '', '')
"          endif
"        else
"          let file = fnamemodify(file, ':p:t')
"        endif
"        if file == ''
"          let file = '[No Name]'
"        endif
"      else
"        let file = TabooTabName(i)
"      endif
"      let s .= file
"      let s .= ' '
"      let s .= '%#TablineFill# %*'
"      let i = i + 1
"    endwhile
"    let s .= '%T%#TabLineFill#%='
"    return s
"  endfunction
"  set stal=2
"  set tabline=%!MyTabLine()
"  execute 'set showtabline='.s:currentShowtabline
"endif

" tmux make cursor line when in insert mode {{{2
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

" Mutt Mail Mode {{{2
" settings for proper formatting of emails function! ToggleMailMode()
function! MuttMailMode()
  "exe ':call CenWinToggle(80)'
  setlocal textwidth=0 wrapmargin=0 wrap linebreak 
  setlocal statusline=%*%#StatusFlag#%m%r%*
  set norelativenumber nonumber
  set spell
  set laststatus=2 showtabline=0
  inoremap <buffer> <Tab> <C-x><C-o>
  noremap <buffer> <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
  noremap <buffer> <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
  noremap <buffer> <silent> <expr> gj (v:count == 0 ? 'j' : 'gj')
  noremap <buffer> <silent> <expr> gk (v:count == 0 ? 'k' : 'gk')
  nnoremap <buffer> <leader>x <Esc>o<CR>-- <CR>Gabriel A. Nespoli, B.Sc., M.A.<CR>Ph.D. Candidate<CR>Ryerson University<CR>Toronto, ON, Canada<Esc>
  nnoremap <buffer> q :wq<CR>
  "setlocal nocp 
  "exe "/^$"
  "exe "normal! gg}O\<Esc>o"
  exe "normal! gg"
endfunction

" Thyme cli {{{2
function! Thyme()
  if executable('thyme')
    if !exists("g:ThymeEnabled") || g:ThymeEnabled == 0
      let g:ThymeEnabled = 1
      execute "!thyme -d"
      echo "Thyme started."
    elseif g:ThymeEnabled == 1
      let g:ThymeEnabled = 0
      execute "!thyme -s"
      echo "Thyme stopped."
    endif
  else
    echoerr 'Thyme is not installed.'
  endif
endfunction
command! Thyme :call Thyme()
cnoreabbrev pomo Thyme
nmap <leader>p :Thyme<CR><CR>

" Open Pomodoro File {{{2
command! Pomfile :execute "edit $HOME/pomodoro/" . strftime("%Y-%m-%d") . ".txt"
cnoreabbrev pomfile Pomfile
nnoremap <leader>P :Pomfile<CR>
