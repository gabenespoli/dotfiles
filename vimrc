" .vimrc file for Gabriel A. Nespoli
" gabenespoli@gmail.com

"" Vundle Plugin Manager
" ---------------------
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"Plugin 'file:///Users/gmac/Dropbox/dotfiles/vim/myplugins/vim-cenwin/autoload'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-bufferline'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-criticmarkup'
Plugin 'tpope/vim-fugitive'
Plugin 'rickhowe/diffchar.vim'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-scripts/todo-txt.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/TaskList.vim'
Plugin 'itchyny/calendar.vim'
"Plugin 'airblade/vim-gitgutter'
"Plugin 'hrother/offlineimaprc.vim'
"Plugin 'toyamarinyon/vim-swift'
"Plugin 'chrisbra/csv.vim'
"Plugin 'godlygeek/tabular'
"Plugin 'jez/vim-superman'
"Plugin 'severin-lemaignan/vim-minimap'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"" Colorscheme 
colorscheme gaberized
syntax enable
set background=dark

"" Spaces & Tabs
" -------------
set linebreak           " stop soft wrapping in the middle of words
set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set shiftwidth=4
set expandtab           " tabs are spaces
set backspace=indent,eol,start " enable backspacing text that was inserted previously
set ignorecase
set smartcase           " if [search terms] has uppercase, then case sensitive
set nofoldenable        " turn off folding by default
set foldlevel=20        " set a high fold level so that folds are open by default
"set digraph             " use <BS> for accents (e.g., e<BS>' for é; e<BS>! for è; o<BS>: for ö)

"" UI Config
" ---------
set nonumber            " show line numbers
set showcmd             " show command in bottom bar
set wildmode=longest,list,full
set wildmenu            " visual autocomplete for command menu
set showmatch           " hi matching [{()}]
set visualbell          " no sound
set laststatus=2        " 0 = no status bar, 2 = show status bar
set showtabline=0
set hidden
set splitright
set splitbelow
set incsearch           " highlight search results as you type

" Status Line
" -----------
set statusline=
"set statusline+=\ 
"set statusline+=%#StatusLineColorToggle#   " switch hi
set statusline+=[%n]\        " buffer number
"set statusline+=%*          " switch back to regular hi
set statusline+=%#FilepathStatusColor#
set statusline+=%f           " filepath
set statusline+=%#ModifiedFlagColor#
set statusline+=%m          " modified flag
set statusline+=%*          " switch back to regular hi
set statusline+=\           " <space>
set statusline+=%y          " filetype
set statusline+=[%{GetSyntaxUnderCursor()}]
set statusline+=%=          " switch to the right side
set statusline+={%{WordCount()}}
set statusline+=\           " <space>
set statusline+=%3c         " current column
set statusline+=\           " <space>
set statusline+=%4l/%L      " current line/total lines
set statusline+=\ \         " <space><space>
set statusline+=(%P)

"" Keybindings
"  -----------
let mapleader = "\<Space>"
set timeoutlen=500
"inoremap <Esc> <Esc>l
inoremap jk <Esc>
vnoremap jk <Esc>

" common actions
nnoremap <leader>e :e<Space>
nnoremap <leader>n :enew<CR>
nnoremap <leader>w :w
nnoremap <leader>s :w<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader>q :qa
nnoremap <leader>D :bd!<CR>
nnoremap <leader>Q :qa!

" copy/paste with system clipboard
vnoremap <leader>y "+y
nnoremap <leader>y V"+y
nnoremap <leader>p "+p
" stuff for tmux from https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
set clipboard=unnamed

" buffers & tabs
nnoremap <leader>j :bprevious<CR>
nnoremap <leader>k :bnext<CR>
nnoremap <leader>1 :b1<CR>
nnoremap <leader>2 :b2<CR>
nnoremap <leader>3 :b3<CR>
nnoremap <leader>4 :b4<CR>
nnoremap <leader>5 :b5<CR>
nnoremap <leader>6 :b6<CR>
nnoremap <leader>7 :b7<CR>
nnoremap <leader>8 :b8<CR>
nnoremap <leader>9 :b9<CR>
nnoremap <leader>b :ls<CR>
nnoremap <leader>B :ls!<CR>
nnoremap <leader>J :tabprevious<CR>
nnoremap <leader>K :tabnext<CR>

" movement
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk
nnoremap <Down> gj
vnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Up> gk
nnoremap W 5w
vnoremap W 5w
nnoremap B 5b
vnoremap B 5b
inoremap <C-i> <Tab>

"vimdiff
nnoremap du :diffupdate<CR>
" force this diffchar.vim highlight cause it always reverts
nnoremap dh :hi _DiffDelPos ctermfg=1 ctermbg=0 cterm=underline<CR>

" emacs movement
"nnoremap <C-h> X " this one seems to already work, no need to remap
inoremap <C-d> <Del>
inoremap <C-n> <C-o>gj
inoremap <C-p> <C-o>gk
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" Spell checking
"nnoremap <leader>Z :set spell!<CR>
"nnoremap <leader>z 1z=
nnoremap <leader>S :set spell!<CR>
nnoremap <localleader>s 1z=

" Toggles
nnoremap <leader>G :GitGutterToggle<CR>
nnoremap <leader>N :set invnumber<CR>
nnoremap <leader>F :call ToggleStatusBar()<CR>
nnoremap <leader>/ :set hlsearch!<CR>
nnoremap <leader>\ :set hlsearch!<CR>

" work signature
nnoremap <leader>x <Esc>o<CR>-- <CR>Gabriel A. Nespoli, B.Sc., M.A.<CR>Ph.D. Student \| SMART Lab<CR>Psychology \| Ryerson University<CR>105 Bond St, Toronto, ON M5B 1Y3<CR>gabe@psych.ryerson.ca<Esc>

"" MyPlugin settings
" -------------------
" CenWin
so ~/.vim/myplugins/cenwin/plugin/cenwin.vim
nnoremap <leader>C :call CenWinToggle(0)<CR>
nnoremap <localleader>l :call CenWinOutlineEnable(0,1)<CR>
nnoremap <localleader>L :call CenWinOutlineEnable(0,2)<CR>
nnoremap <localleader>q :call CenWinTodoToggle()<CR>
nnoremap <localleader>t :call CenWinTodoAdd()<CR>
nnoremap <localleader>T :call CenWinTodoRemove()<CR>

"" Plugin settings
" ---------------
" calendar.vim
let g:calendar_google_calendar = 1
let g:calendar_week_number = 1
let g:calendar_views = ['year', 'month', 'week', 'day_4', 'agenda', 'event']
let g:calendar_view = 'agenda'

" CtrlP
let g:ctrlp_map = '<leader>o'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_prompt_mappings = { 
            \ 'PrtSelectMove("j")':     ['<C-n>'],
            \ 'PrtSelectMove("k")':     ['<C-p>'],
            \ 'PrtHistory(-1)':         ['<down>'],
            \ 'PrtHistory(1)':          ['<up>'],
            \ 'AcceptSelection("e")':   ['<C-j>', '<CR>', '<2-LeftMouse>'], 
            \ 'ToggleType(1)':          ['<C-b>', '<C-down>'],
            \ 'ToggleType(-1)':         ['<C-f>', '<C-up>'],
            \ }

" Pandoc
let g:pandoc#modules#enabled = ["command","bibliographies","completion","keyboard"]
let g:pandoc#biblio#sources = "g"
let g:pandoc#biblio#bibs = ["~/bin/cite/library.bib"]
let g:pandoc#completion#bib#mode = "citeproc"
let g:pandoc#keyboard#enabled_submodules = ["sections"]

" Pandoc Syntax
let g:pandoc#syntax#conceal#use = 0

" CriticMarkup
" see settings in .vim/ftplugin/markdown.vim

" CSV
function! FormatTSV()
    " http://alangrow.com/blog/turn-vim-into-excel-tips-for-tabular-data-editing
    setlocal number noexpandtab shiftwidth=20 softtabstop=20 tabstop=20 nowrap
endfunc
"nnoremap <leader>T :call FormatTSV()<CR>

" GitGutter 
let g:gitgutter_map_keys = 0 " unmap bindings that conflict with <leader>h
let g:gitgutter_enabled = 0 " toggle to start vim with gitgutter enabled

" IndentLine
let g:indentLine_char = '|'
let g:indentLine_color_term = 242

" Lilypond
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
"set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
filetype on

"" Functions
" ---------
function! GetSyntaxUnderCursor() 
    let g:SyntaxUnderCursor = synIDattr(synID(line("."),col("."),1),"name")
    return g:SyntaxUnderCursor
endfunction

" http://stackoverflow.com/questions/114431/fast-word-count-function-in-vim
function! WordCount()
    let lnum = 1
    let n = 0
    while lnum <= line('$')
        let n = n + len(split(getline(lnum)))
        let lnum = lnum + 1
    endwhile
    return n
endfunction

function! ToggleStatusBar()
        if &laststatus==2
                set laststatus=0
        elseif &laststatus==0
                set laststatus=2
        endif
endfunction

" settings for proper formatting of emails function! ToggleMailMode()
function! MuttMailMode()
    exe ":call CenWinToggle(80)"
    setlocal textwidth=0 wrapmargin=0 wrap linebreak laststatus=0 nonumber
    "setlocal nocp 
    exe "/^$"
endfunc

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

