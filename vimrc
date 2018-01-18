" .vimrc file for gabenespoli@gmail.com
" Plugin Manager (vim-plug) {{{1
call plug#begin('~/.vim/plugged')

" editing {{{2
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/matchit.zip'

" sidebars {{{2
Plug '~/bin/vim/vim-sidebar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'scrooloose/NERDTree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'jszakmeister/markdown2ctags'
Plug 'MarcWeber/vim-addon-qf-layout'

" syntax {{{2
Plug 'w0rp/ale'
Plug 'tmux-plugins/vim-tmux'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'rickhowe/diffchar.vim'
Plug 'gabenespoli/vim-criticmarkup'
Plug 'jvirtanen/vim-octave'
Plug 'guanqun/vim-mutt-aliases-plugin'

" external {{{2
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'
Plug 'inside/vim-grep-operator'

call plug#end()

" General Settings {{{1
" Colorscheme {{{2
if has("gui_running")
  colorscheme solarizedSumach
  set guicursor=n-v-c-i:blinkon0
else
  colorscheme gaberized
endif
syntax enable
set background=dark

" File stuff {{{2
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
set grepprg=git\ grep\ -n\ --no-color\ $*

" Folding {{{2
set fillchars="vert:' ',fold:-"
set foldminlines=0              " 0 means we can close a 1-line fold
set foldcolumn=0
set foldlevel=1
set foldmethod=marker
set foldtext=GetFoldText()
function! GetFoldText()
  if &foldmethod == 'marker'
    set foldtext=FoldTextMarker()
  else
    set foldtext=getline(v:foldstart)
  endif
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
  let prefix = repeat(' ', l:foldlevel-1) . ' + '
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
set statusline+=\ %#StatusMod#%m%*%#StatusFlag#%r%*\"%t\"\ %y
set statusline+=%{fugitive#statusline()}
" set statusline+=%#StatusLineFill#%=%*                      
set statusline+=%=
set statusline+=%l/%L\,%c\ (%P)                           

" Keybindings {{{1
" settings {{{2
let mapleader = "\<Space>"
set notimeout
set ttimeout
inoremap jk <Esc>

" general {{{2
nnoremap Y y$
nnoremap q :q<CR>
nnoremap Q :qa<CR>
nnoremap <leader>s :w<CR>

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
  cnoremap <M-f> <S-Right>
  cnoremap <M-b> <S-Left>
else
  inoremap <Esc>f <S-Right>
  inoremap <Esc>b <S-Left>
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
nnoremap <leader>d "=strftime("%Y-%m-%d")<CR>p
nnoremap <leader>D "=strftime("%Y-%m-%d %H:%M:%S")<CR>p
"vimdiff
nnoremap du :diffupdate<CR>
" Spell checking
nnoremap <localleader>s 1z=
" open with system on mac
if has('mac')
  nnoremap gO :!open <cfile><CR>
endif

" Plugin Settings {{{1
" tpope/vim-unimpaired {{{2
nnoremap coN :set relativenumber!<CR>:set number!<CR>
nnoremap coH :call SearchHighlightToggle()<CR>
nnoremap cop :call ToggleColorColumn()<CR>
nnoremap coYd :set syntax=pandoc<CR>
nnoremap coYk :set syntax=markdown<CR>
nnoremap coYm :set syntax=matlab<CR>
nnoremap coYo :set syntax=octave<CR>
nnoremap coYp :set syntax=python<CR>
nnoremap coYq :set syntax=qf<CR>
nnoremap coYr :set syntax=r<CR>
nnoremap coYs :set syntax=sh<CR>
nnoremap coYv :set syntax=vim<CR>
nnoremap coYy :set syntax=yaml<CR>
nnoremap <expr> cof &foldcolumn ? ':set foldcolumn=0<CR>' : ':set foldcolumn=1<CR>'
nnoremap coFl :set foldmethod=manual<CR>
nnoremap coFi :set foldmethod=indent<CR>
nnoremap coFe :set foldmethod=expr<CR>
nnoremap coFm :set foldmethod=marker<CR>
nnoremap coFs :set foldmethod=syntax<CR>
nnoremap coFd :set foldmethod=diff<CR>

" tpope/vim-commentary {{{2
xmap <leader>c  <Plug>Commentary
nmap <leader>c  <Plug>Commentary
omap <leader>c  <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine
if maparg('c','n') ==# ''
  nmap c<leader>c <Plug>ChangeCommentary
endif
nmap <leader>cu <Plug>Commentary<Plug>Commentary
autocmd FileType octave setlocal commentstring=%\ %s
autocmd FileType cfg,remind setlocal commentstring=#\ %s

" tpope/vim-fugitive {{{2
nnoremap gs :Gstatus<CR>
nnoremap gd :Gvdiff<CR>
nnoremap gA :Gwrite<CR>
nnoremap gc :Gcommit<CR>i
nnoremap gl :Glog<CR><CR>:copen<CR>
autocmd FileType gitcommit nnoremap <buffer> gc :silent wq<CR>

" airblade/gitgutter {{{2
nmap ga <Plug>GitGutterStageHunk
nnoremap ghc :GitGutterStageHunk<CR>:Gcommit<CR>i
nmap ghd <Plug>GitGutterPreviewHunk
nmap ghu <Plug>GitGutterUndoHunk
nnoremap cog :GitGutterSignsToggle<CR>
let g:gitgutter_eager = 0
let g:gitgutter_override_sign_column_highlight = 0

" gabenespoli/vim-sidebar {{{2
let g:SidebarEmptyStatusLine = '%#StatusLineFill#%=%*'
let g:SidebarEmptyPrefix = '<leader>'
let g:SidebarEmptyStickyKey = 'E'

" ctrlpvim/ctrlp.vim {{{2
let g:ctrlp_map = '<leader>o'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_match_window = 'bottom'
let g:ctrlp_prompt_mappings = { 
  \ 'PrtSelectMove("j")':     ['<C-n>','<down>'],
  \ 'PrtSelectMove("k")':     ['<C-p>','<up>'],
  \ 'PrtHistory(-1)':         [],
  \ 'PrtHistory(1)':          [],
  \ 'AcceptSelection("t")':   ['<C-t>'],
  \ 'AcceptSelection("e")':   ['<C-m>', '<C-j>', '<CR>', '<2-LeftMouse>'],
  \ 'ToggleType(-1)':         ['<C-b>', '<C-down>'],
  \ 'ToggleType(1)':          ['<C-f>', '<C-up>'],
  \ }

" jeetsukumaran/vim-buffergator {{{2
let g:buffergator_viewport_split_policy = "N"
let g:buffergator_suppress_keymaps = 1
nnoremap <leader>b :BuffergatorOpen<CR>
autocmd Filetype buffergator noremap <buffer> <silent> <leader>b :BuffergatorClose<CR>

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

nnoremap <leader>e :call ToggleNERDTreeLikeNetrw()<CR>
function! ToggleNERDTreeLikeNetrw()
  " TODO make this work even if called from buffergator
  let l:fname = expand("%:t")
  if exists('t:NERDTreeBufName')
    " switch to existing nerdtree buffer
    " this doesn't really work for some reason though
      execute "buffer" . bufnr(t:NERDTreeBufName)
  else
    " open dir of current file
    " should have g:NERDTreeHijackNetrw = 1
    execute "e " . expand("%:h")
  endif
  " go to line of current file
  execute "call search('".l:fname."', 'cW')"
  " after opening split, switch nerdtree back to the buffer it was called from
  nnoremap <buffer> v :call nerdtree#ui_glue#invokeKeyMap("v")<CR><C-w>p:bprevious<CR><C-w>p
  nnoremap <buffer> s :call nerdtree#ui_glue#invokeKeyMap("s")<CR><C-w>p:bprevious<CR><C-w>p
  nnoremap <buffer> <leader>e :bprevious<CR>
endfunction

" Xuyuanp/nerdtree-git-plugin {{{2
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "M",
    \ "Staged"    : "+",
    \ "Untracked" : "?",
    \ "Renamed"   : "R",
    \ "Unmerged"  : "U",
    \ "Deleted"   : "D",
    \ "Dirty"     : "*",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : "!",
    \ "Unknown"   : "X"
    \ }

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
if !has('nvim')
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

else
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
nnoremap coy :ALEToggle<CR>
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
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
" let g:pandoc#modules#enabled = ["command", "bibliographies", "completion", "keyboard"]
let g:pandoc#modules#enabled = ["command", "completion", "keyboard"]
let g:pandoc#keyboard#enabled_submodules = ["sections"]
let g:pandoc#biblio#sources = "g"
" let g:pandoc#biblio#bibs = ["/Users/gmac/dotfiles/pandoc/library.bib", "/home/efgh/dotfiles/pandoc/library.bib"]
let g:pandoc#command#autoexec_on_writes = 0
let g:pandoc#command#autoexec_command = "Pandoc docx --reference-docx=~/dotfiles/pandoc/apa.docx"

" vim-pandoc/vim-pandoc-syntax {{{2
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#codeblocks#embeds#langs = ["vim", "bash=sh", "python", "matlab", "octave"]
let g:markdown_fenced_languages = g:pandoc#syntax#codeblocks#embeds#langs

" gabenespoli/vim-criticmarkup {{{2
let g:criticmarkup#disable#highlighting = 1

" rickhowe/diffchar {{{2
map  <localleader>D <Plug>ToggleDiffCharAllLines
map  <localleader>d <Plug>ToggleDiffCharCurrentLine
nmap [d             <Plug>JumpDiffCharPrevStart
nmap ]d             <Plug>JumpDiffCharNextStart
nmap <F13>          <Plug>JumpDiffCharPrevEnd
nmap <F14>          <Plug>JumpDiffCharNextEnd
nmap dO             <Plug>GetDiffCharPair
nmap dP             <Plug>PutDiffCharPair

" inside/vim-grep-operator {{{2
nmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
vmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
nmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt
vmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt

" Lilypond {{{2
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
"set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
filetype on

" Functions {{{1
" Toggle qf and loclist {{{2
" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nnoremap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>

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

" Tab names {{{2
" Rename tabs to show tab# and # of viewports
" http://stackoverflow.com/questions/5927952/whats-the-implementation-of-vims-default-tabline-function
if exists("+showtabline")
  let s:currentShowtabline = &showtabline
  function! MyTabLine()
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
      let s .= (i == t ? '%#TabNumSel#' : '%#TabNum#')
      let s .= '['
      let s .= i
      if tabpagewinnr(i,'$') > 1
        let s .= '|'
        let s .= (i == t ? '%#TabWinNumSel#' : '%#TabWinNum#')
        let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
      end
      let s .= ']%*'

      "modified flag
      let s .= (i == t ? '%#TabModSel#%m%r' : '%#TabMod#')
      let s .= ' %*'

      "filename
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      if !exists("TabooTabName(i)") || TabooTabName(i) == ''
        let bufnr = buflist[winnr - 1]
        let file = bufname(bufnr)
        let buftype = getbufvar(bufnr, 'buftype')
        if buftype == 'nofile'
          if file =~ '\/.'
            let file = substitute(file, '.*\/\ze.', '', '')
          endif
        else
          let file = fnamemodify(file, ':p:t')
        endif
        if file == ''
          let file = '[No Name]'
        endif
      else
        let file = TabooTabName(i)
      endif
      let s .= file
      let s .= ' '
      let s .= '%#TablineFill# %*'
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    return s
  endfunction
  set stal=2
  set tabline=%!MyTabLine()
  execute 'set showtabline='.s:currentShowtabline
endif

" tmux make cursor line when in insert mode {{{2
" Change cursor shape from block (command mode) to line (insert mode)
" tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
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
