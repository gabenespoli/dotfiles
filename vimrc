" .vimrc file for Gabriel A. Nespoli
" gabenespoli@gmail.com

"" Vundle Plugin Manager
" ---------------------
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'gabenespoli/vim-sumach-colors'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-criticmarkup'
Plugin 'https://github.com/junegunn/goyo.vim'
Plugin 'airblade/vim-gitgutter'
"Plugin 'tpope/fugitive'
Plugin 'toyamarinyon/vim-swift'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tmux-plugins/vim-tmux-focus-events'
"Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'Yggdroot/indentLine'
Plugin 'bling/vim-bufferline'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree.git'
"Plugin 'chrisbra/csv.vim'
"Plugin 'godlygeek/tabular'
"Plugin 'jez/vim-superman'
"Plugin 'kien/ctrlp.vim'
"Plugin 'severin-lemaignan/vim-minimap'
"Plugin 'hrother/offlineimaprc.vim'

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

colorscheme solarized
set background=dark

"" Key bindings
" ------------
let mapleader = "\<Space>"
set timeoutlen=300
inoremap <Tab> <Esc>l
inoremap <Esc> <Esc>l
inoremap jk <Esc>l

" common actions
nnoremap <leader>e :e<Space>
nnoremap <leader>o :e<Space>
nnoremap <leader>n :enew<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>S :saveas<space>
nnoremap <leader>d :bd<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>.d :bd!<CR>
nnoremap <leader>.q :q!<CR>

" copy/paste with system clipboard
vnoremap <leader>y "+y
nnoremap <leader>y V"+y
nnoremap <leader>p "+p
" stuff for tmux from https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
set clipboard=unnamed

" buffers & tabs
"nnoremap <leader>h :bprevious<CR>
nnoremap <leader>j :bprevious<CR>
"nnoremap <leader>l :bnext<CR>
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
nnoremap <leader>J :tabprevious<CR>
nnoremap <leader>K :tabnext<CR>
nnoremap <leader>0 :ls<CR>
nnoremap <leader>) :ls!<CR>

" split panes
"nnoremap <leader>;; :vs<CR>
"nnoremap <leader>;: :sv<CR>
"nnoremap <leader>;o :on<CR>
"nnoremap <leader>;q <C-w>q
"nnoremap <leader>;h <C-w><C-h>
"nnoremap <leader>;l <C-w><C-l>
"nnoremap <leader>;j <C-w><C-j>
"nnoremap <leader>;k <C-w><C-k>
"nnoremap <leader>;i :vertical resize +5<CR>
"nnoremap <leader>;d :vertical resize -5<CR>

" movement
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
nnoremap W 5w
nnoremap B 5b
vnoremap W 5w
vnoremap B 5b
nnoremap <leader>b :set scrollbind<CR>
nnoremap <leader>B :set noscrollbind<CR>
inoremap <C-i> <Tab>

" emacs movement
"nnoremap <C-h> X
inoremap <C-d> <Del>
inoremap <C-n> <C-o>gj
inoremap <C-p> <C-o>gk
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" Spell checking
nnoremap <leader>Z :set spell!<CR>
nnoremap <leader>z= 1z=

" Toggles
nnoremap <leader>X :SyntasticToggleMode<CR>
nnoremap <leader>G :GitGutterToggle<CR>
nnoremap <leader>I :IndentLinesToggle<CR>
nnoremap <leader>N :set invnumber<CR>
nnoremap <leader>/ :set hlsearch!<CR>
"nnoremap <leader>\ :call StatusToggle()<CR>
nnoremap <leader>F :call StatusToggle()<CR>
"nnoremap <leader>t " this is mapped in .vim/ftplugin/*.vim for showing TOC

"" Plugin settings
" ---------------
" Airline
"let g:airline_theme='base16color' " this has been modified to have Sumach colors
"let g:airline_section_b = airline#section#create(['hunks', 'branch', '%{getcwd()}'])
"let g:airline_section_x = airline#section#create(['tagbar', '%{GetSyntax()}', ' ', 'filetype',])
"let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%', ' ', 'linenr', 'maxlinenr', ',%2v', ' : ', '%{WordCount()}'])
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#buffer_nr_show = 1

" Pandoc
"let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#toc#position = 'left'
let g:pandoc#toc#close_after_navigating = 0

" CriticMarkup
nnoremap <leader>a :Critic accept<CR>
nnoremap <leader>r :Critic reject<CR>
nnoremap <leader>c F{df}
" edit syntax highlighing in ~/.vim/vim-criticmarkup/autoload/ ??

" Goyo
nnoremap <leader>g :Goyo<CR>
let g:goyo_height=100
let g:goyo_width=100
function! s:goyo_enter()
  silent !tmux set status off
  "silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
endfunction
function! s:goyo_leave()
  silent !tmux set status on
  "silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  doautocmd Syntax
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" CSV
let g:csv_delim="|"
"let g:csv_no_conceal = 1
"hi CSVColumnHeaderOdd cterm=none ctermfg=White ctermbg=DarkGrey
"hi CSVColumnHeaderEven cterm=none ctermfg=White ctermbg=Black
"hi CSVColumnOdd cterm=none ctermfg=White ctermbg=DarkGrey
"hi CSVColumnEven cterm=none ctermfg=White ctermbg=Black
"hi CSVDelimiter cterm=none ctermfg=Black ctermbg=Black

" GitGutter 
let g:gitgutter_map_keys = 0 "unmap bindings that conflict with <leader>h

" IndentLine
let g:indentLine_char = '|'
let g:indentLine_color_term = 242

" NERDTree
nnoremap <leader>O :NERDTreeToggle<CR>

" Lilypond
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
"set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
filetype on

" tmux set tab title to vim filename; reset when quitting vim
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window '" . expand("%:t") . "'")
autocmd VimLeave * call system("tmux setw automatic-rename")
" vim-tmux navigator
"let g:tmux_navigator_no_mappings = 1
"nnoremap <silent> <C-w><C-h> :TmuxNavigateLeft<CR>
"nnoremap <silent> <C-w><C-j> :TmuxNavigateDown<CR>
"nnoremap <silent> <C-w><C-k> :TmuxNavigateUp<CR>
"nnoremap <silent> <C-w><C-l> :TmuxNavigateRight<CR>
"nnoremap <silent> <C-w><C-p> :TmuxNavigatePrevious<CR>

"" Functions
" ---------
function! GetListOfBuffers()
    autocmd VimEnter *
        \ let &listofbuffers='%{bufferline#refresh_status()}' . bufferline#get_status_string()
    return listofbuffers
endfunction
"let g:bufferline_echo = 0
"autocmd VimEnter *
"  \ let &statusline='%{bufferline#refresh_status()}' .bufferline#get_status_string()

" get syntax hi under cursor
function! GetSyntax() 
    return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" show word count (function from
" http://stackoverflow.com/questions/114431/fast-word-count-function-in-vim)
function! WordCount()
    let lnum = 1
    let n = 0
    while lnum <= line('$')
        let n = n + len(split(getline(lnum)))
        let lnum = lnum + 1
    endwhile
    return n
endfunction

" show/hide statusline, airline, tabline
function! StatusToggle()
        if &laststatus==2
                set laststatus=0
                "set showtabline=0
        elseif &laststatus==0
                set laststatus=2
                "set showtabline=2
        endif
endfunction

"" Colors and design
" -----------------
syntax enable           " Enable syntax hiing
set laststatus=2        " always show the status bar
set showtabline=0

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
set number              " show line numbers
set showcmd             " show command in bottom bar
set wildmode=longest,list,full
set wildmenu            " visual autocomplete for command menu
set showmatch           " hi matching [{()}]
set visualbell          " no sound

" Status Line
" -----------
set statusline=
"set statusline+=\ \ \ 
"set statusline+=%#StatusLineColorToggle#   " switch hi
"set statusline+=%2n\        " buffer number
"set statusline+=%*          " switch back to regular hi
set statusline+=%f           " filepath
hi ModifiedFlagColor ctermfg=1
set statusline+=%#ModifiedFlagColor#
set statusline+=%m          " modified flag
set statusline+=%*          " switch back to regular hi
set statusline+=\           " <space>
set statusline+=%y          " filetype
set statusline+=[%{GetSyntax()}]
set statusline+=%=          " switch to the right side
set statusline+=[%{WordCount()}]
set statusline+=\           " <space>
set statusline+=%3c         " current column
set statusline+=\           " <space>
set statusline+=%5l         " current line
set statusline+=/           " <space>
set statusline+=%L          " total lines

" status line change color for insert mode
hi StatusLineColorToggle ctermfg=white ctermbg=darkgrey 
au InsertEnter * hi StatusLineColorToggle ctermfg=black ctermbg=3
au InsertLeave * hi StatusLineColorToggle ctermfg=white ctermbg=darkgrey

"" Misc
" ----
set hidden

" more natural default splits
set splitright
set splitbelow

" force some pandoc highlighting cause it always screws up
" (especially italics (emphasis); why is this always cterm=reverse?!)
hi pandocAtxStart ctermfg=7
hi pandocAtxHeader cterm=bold ctermfg=7*
hi clear pandocEmphasis
hi pandocEmphasis ctermfg=7
hi pandocOperator ctermfg=darkgrey
hi pandocStrong cterm=bold ctermfg=7*

nnoremap <leader>i :hi clear pandocEmphasis<CR>:hi pandocEmphasis ctermfg=7<CR>

