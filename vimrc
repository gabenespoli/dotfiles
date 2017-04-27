" .vimrc file for Gabriel A. Nespoli
" gabenespoli@gmail.com

"" Vundle Plugin Manager
" ---------------------
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" my plugins
"Plugin 'gabenespoli/vim-cenwin'
Plugin 'file:///Users/gmac/bin/vim/vim-cenwin'

" files
"Plugin 'vifm/vifm.vim'
Plugin 'francoiscabrol/ranger.vim'
"Plugin 'bling/vim-bufferline'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'ctrlpvim/ctrlp.vim'

" git
Plugin 'tpope/vim-fugitive'
Plugin 'rickhowe/diffchar.vim'
Plugin 'airblade/vim-gitgutter'

" tmux
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tmux-plugins/vim-tmux-focus-events'

" syntax
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-criticmarkup'
Plugin 'vim-scripts/todo-txt.vim'
"Plugin 'hrother/offlineimaprc.vim'
"Plugin 'toyamarinyon/vim-swift'
"Plugin 'chrisbra/csv.vim'
"Plugin 'godlygeek/tabular'
"Plugin 'jez/vim-superman'
" vim
Plugin 'tpope/vim-unimpaired'
Plugin 'kana/vim-submode'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'gcmt/taboo.vim'
Plugin 'vim-scripts/Rename'
Plugin 'jceb/vim-orgmode'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'itchyny/calendar.vim'
"Plugin 'blindFS/vim-taskwarrior'
"Plugin 'vim-scripts/TaskList.vim'
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
if has("gui_running")
    colorscheme solarizedSumach
    set guicursor=n-v-c-i:blinkon0
else
    colorscheme gaberized
endif
syntax enable
set background=dark

"" File stuff
set undofile
set swapfile
set undodir=~/.vim/tmp/undo
set backupdir=~/.vim/tmp/backup/
set directory=~/.vim/tmp/swap/
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

"" Spaces & Tabs
set linebreak           " stop soft wrapping in the middle of words  
set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set shiftwidth=4
set expandtab           " tabs are spaces
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set nolist              " show invisibles
set backspace=indent,eol,start " enable backspacing text that was inserted previously
set ignorecase
set smartcase           " if [search terms] has uppercase, then case sensitive
set nofoldenable        " turn off folding by default
set foldlevel=20        " set a high fold level so that folds are open by default
"set digraph             " use <BS> for accents (e.g., e<BS>' for é; e<BS>! for è; o<BS>: for ö)

"" UI Config
set number
set relativenumber
set showcmd             " show command in bottom bar
"set noshowmode          " show mode below status line
set wildmode=longest,list,full
set wildmenu            " visual autocomplete for command menu
set showmatch           " hi matching [{()}]
set visualbell          " no sound
set laststatus=2        " 0 = no status bar, 2 = show status bar
set showtabline=2       " 0 = no tabline, 1 = show if > 1 tab, 2 = always
set tabpagemax=8
set hidden
set splitright
set splitbelow
set incsearch           " highlight search results as you type

"" Status Line
set statusline=\                                " 
set statusline+=%{mode()}                       " mode character
set statusline+=\                               " 
set statusline+=[%{tabpagenr()}\|%{winnr()}]    " tab#|win#
set statusline+=%#WarningMsg#%m%r%*             " modified/read-only
set statusline+=\                               " 
set statusline+=%t                              " :filename
set statusline+=\                               " 
set statusline+=%y[%{GetSyntaxUnderCursor()}]   " filetype & syntax
set statusline+=\                               " 
set statusline+=%#StatusLineFill#
set statusline+=%=                              " switch to the right side
set statusline+=%*
set statusline+=\                               " 
set statusline+=%{fugitive#statusline()}
set statusline+=\                               " 
set statusline+={%{WordCount()}}                " word count
set statusline+=\                               " 
set statusline+=%3c                             " current column
set statusline+=\                               " 
set statusline+=%4l/%L                          " current line/total lines
set statusline+=\ \                             ""
set statusline+=(%P)                            " percent through file
set statusline+=\                                " 

"" Keybindings
let mapleader = "\<Space>"
set notimeout
set ttimeout
set timeoutlen=500
inoremap jk <Esc>
vnoremap jk <Esc>

" common actions
nnoremap <leader>e :e<Space>
"<leader>o opens ctrlp plugin
"<leader>O opens ranger / vifm
nnoremap <leader>s :w<CR>
nnoremap <leader>w :close<CR>
nnoremap <leader>D :bdelete<CR>
nnoremap <leader>X :bwipe<CR>
nnoremap <leader>q :qa

" tabs, windows/panes, buffers
call submode#enter_with('TABS', 'n', '', '<leader>n', ':tab new<CR>') 
call submode#enter_with('TABS', 'n', '', '<leader>t', ':tabedit #<CR>') 
call submode#enter_with('TABS', 'n', '', '<leader>W', ':close<CR>') 
call submode#enter_with('TABS', 'n', '', '<leader>1', '1gt') 
call submode#enter_with('TABS', 'n', '', '<leader>2', '2gt') 
call submode#enter_with('TABS', 'n', '', '<leader>3', '3gt') 
call submode#enter_with('TABS', 'n', '', '<leader>4', '4gt') 
call submode#enter_with('TABS', 'n', '', '<leader>5', '5gt') 
call submode#enter_with('TABS', 'n', '', '<leader>6', '6gt') 
call submode#enter_with('TABS', 'n', '', '<leader>7', '7gt') 
call submode#enter_with('TABS', 'n', '', '<leader>8', '8gt') 
call submode#enter_with('TABS', 'n', '', '<leader>9', ':tabprevious<CR>')
call submode#enter_with('TABS', 'n', '', '<leader>0', ':tabnext<CR>') 
call submode#enter_with('TABS', 'n', '', '<leader>(', ':bprevious<CR>') 
call submode#enter_with('TABS', 'n', '', '<leader>)', ':bnext<CR>') 
call submode#leave_with('TABS', 'n', '', '<Esc>') 
call submode#map('TABS', 'n', '', 't', ':tabedit %<CR>')
call submode#map('TABS', 'n', '', 'W', ':close<CR>')
call submode#map('TABS', 'n', '', '1', '1gt') 
call submode#map('TABS', 'n', '', '2', '2gt') 
call submode#map('TABS', 'n', '', '3', '3gt') 
call submode#map('TABS', 'n', '', '4', '4gt') 
call submode#map('TABS', 'n', '', '5', '5gt') 
call submode#map('TABS', 'n', '', '6', '6gt') 
call submode#map('TABS', 'n', '', '7', '7gt') 
call submode#map('TABS', 'n', '', '8', '8gt') 
call submode#map('TABS', 'n', '', '9', ':tabprevious<CR>') 
call submode#map('TABS', 'n', '', '0', ':tabnext<CR>')
call submode#map('TABS', 'n', '', '(', ':bprevious<CR>') 
call submode#map('TABS', 'n', '', ')', ':bnext<CR>')

nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
" tab to cycle between panes
nnoremap <Tab> <C-w>w
" split with next or previous file
nnoremap <leader>H <C-w>v:bprevious<CR>
nnoremap <leader>L <C-w>v:bnext<CR>

" copy/paste with system clipboard
vnoremap <leader>y "+y
nnoremap <leader>y V"+y
nnoremap <leader>p "+p
nnoremap Y y$
" stuff for tmux from https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
set clipboard=unnamed

nnoremap <leader>d :r! date "+\%Y-\%m-\%d \%H:\%M:\%S"<CR>

" swap j/k with gj/gk
"nnoremap j gj
"nnoremap k gk
"nnoremap gj j
"nnoremap gk k
nnoremap <Down> gj
nnoremap <Up> gk
"vnoremap j gj
"vnoremap k gk
"vnoremap gj j
"vnoremap gk k
vnoremap <Down> gj
vnoremap <Up> gk

" misc movement
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
nnoremap <leader>N :set invrelativenumber<CR>:set invnumber<CR>
nnoremap <leader>/ :set hlsearch!<CR>
nnoremap <leader>\ :set hlsearch!<CR>

"" Plugin settings
" CenWin
nnoremap <leader>C :call CenWinToggle(0)<CR>
nnoremap <localleader>c :call CenWinToggleWidth()<CR>
nnoremap <localleader>l :call CenWinOutlineEnable(0,1)<CR>
nnoremap <localleader>L :call CenWinOutlineEnable(0,2)<CR>
nnoremap <localleader>q :call CenWinTodoToggle()<CR>
nnoremap <localleader>t :call CenWinTodoAdd()<CR>
nnoremap <localleader>T :call CenWinTodoRemove()<CR>

" Taboo
let g:taboo_tabline = 0
"let g:taboo_tab_format = ' %f%m '
"let g:taboo_renamed_tab_format = ' [%l]%m'
nnoremap <leader>r :TabooRename 
nnoremap <leader>R :TabooReset<CR>

" buffergator
let g:buffergator_suppress_keymaps = 1
"nnoremap <leader>b :BuffergatorOpen<CR>
"nnoremap <leader>B :BuffergatorClose<CR>
"nnoremap <leader>t :BuffergatorTabsOpen<CR>
"nnoremap <leader>T :BuffergatorTabsClose<CR>
nnoremap <leader>b :BuffergatorToggle<CR>
nnoremap <leader>T :BuffergatorTabsToggle<CR>
nnoremap gb :BuffergatorMruCyclePrev<CR>
nnoremap gB :BuffergatorMruCycleNext<CR>

" submode
let g:submode_timeout = 0
let g:submode_tiemoutlen = 1500
let g:submode_keep_leaving_key = 1

" calendar.vim
let g:calendar_google_calendar = 1
let g:calendar_week_number = 1
let g:calendar_views = ['year', 'month', 'week', 'day_4', 'agenda', 'event']
let g:calendar_view = 'agenda'

" ranger
let g:ranger_map_keys = 0
nnoremap <leader>O :RangerNewTab<CR>

" vifm
"nnoremap <leader>O :EditVifm<CR>

" yankring
let g:yankring_history_dir = '$HOME/.vim'

" CtrlP
let g:ctrlp_map = '<leader>o'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_prompt_mappings = { 
            \ 'PrtSelectMove("j")':     ['<C-n>'],
            \ 'PrtSelectMove("k")':     ['<C-p>'],
            \ 'PrtHistory(-1)':         ['<down>'],
            \ 'PrtHistory(1)':          ['<up>'],
            \ 'AcceptSelection("e")':   ['<C-j>'],
            \ 'AcceptSelection("t")':   ['<C-m>', '<CR>', '<2-LeftMouse>'],
            \ 'ToggleType(-1)':         ['<C-b>', '<C-down>'],
            \ 'ToggleType(1)':          ['<C-f>', '<C-up>'],
            \ }

" Pandoc
let g:pandoc#modules#enabled = ["command","completion","keyboard"]
let g:pandoc#keyboard#enabled_submodules = ["sections"]
"let g:pandoc#biblio#sources = "g"
"let g:pandoc#biblio#bibs = ["~/.pandoc/library.bib"]
"let g:pandoc#completion#bib#mode = "citeproc"
let g:pandoc#command#autoexec_on_writes = 0
"let g:pandoc#command#autoexec_command = "Pandoc docx --reference-docx='~/dotfiles/pandoc/apa.docx'"

" Pandoc Syntax
let g:pandoc#syntax#conceal#use = 0

" CriticMarkup
" see settings in .vim/ftplugin/markdown.vim

" GitGutter 
let g:gitgutter_map_keys = 0 " unmap bindings that conflict with <leader>h
let g:gitgutter_enabled = 1 " toggle to start vim with gitgutter enabled
let g:gitgutter_signs = 0
nnoremap <leader>G :GitGutterSignsToggle<CR>

" Fugitive
nnoremap gs :Gstatus<CR>
nnoremap gc :Gwrite<CR>:Gcommit<CR>i
nnoremap gd :Gdiff<CR>

" IndentLine
let g:indentLine_char = '|'
let g:indentLine_color_term = 242

" Lilypond
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
"set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
filetype on

"" Functions
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

function! ToggleTabline()
    " 0 = never, 1 = if > 1 tab, 2 = always
    if &showtabline==0
       set showtabline=2
    elseif &showtabline==1
        set showtabline=0
    elseif &showtabline==2
        set showtabline=0
    endif
endfunction
nnoremap <leader>F :call ToggleTabline()<CR>

function! ToggleStatusBar()
    if &laststatus == 2
        set laststatus=0
    elseif &laststatus == 0
        set laststatus=2
    endif
endfunction
nnoremap <leader>f :call ToggleStatusBar()<CR>

" Rename tabs to show tab# and # of viewports
" http://stackoverflow.com/questions/5927952/whats-the-implementation-of-vims-default-tabline-function
if exists("+showtabline")
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
endif

" settings for proper formatting of emails function! ToggleMailMode()
function! MuttMailMode()
    exe ':call CenWinToggle(80)'
    setlocal textwidth=0 wrapmargin=0 wrap linebreak 
    hi StatusLine ctermfg=8
    hi StatusLineNC ctermfg=8
    setlocal statusline=%*%#WarningMsg#%m%r%*
    set norelativenumber nonumber
    set spell
    set laststatus=2 showtabline=0
    nnoremap <buffer> <leader>x <Esc>o<CR>-- <CR>Gabriel A. Nespoli, B.Sc., M.A.<CR>Ph.D. Student \| SMART Lab<CR>Psychology \| Ryerson University<CR>105 Bond St, Toronto, ON M5B 1Y3<CR>gabe@psych.ryerson.ca<Esc>
    "setlocal nocp 
    exe "/^$"
endfunction

function! ToggleInvisibles()
    if &list==1
        set nolist
    else
        set list
    endif
endfunction
nnoremap <leader>i :call ToggleInvisibles()<CR>

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

