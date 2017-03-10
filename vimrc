" .vimrc file for Gabriel A. Nespoli
" gabenespoli@gmail.com

"" Vundle Plugin Manager
" ---------------------
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-bufferline'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-criticmarkup'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'rickhowe/diffchar.vim'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tmux-plugins/vim-tmux-focus-events'
"Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'Yggdroot/indentLine'
"Plugin 'hrother/offlineimaprc.vim'
"Plugin 'toyamarinyon/vim-swift'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'scrooloose/nerdtree.git'
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
"  -----------
colorscheme solarized
"let s:vmode       = "cterm"
"let s:base03      = "8"
"let s:base02      = "0"
"let s:base01      = "10"
"let s:base00      = "11"
"let s:base0       = "12"
"let s:base1       = "14"
"let s:base2       = "7"
"let s:base3       = "15"
"let s:yellow      = "3"
"let s:orange      = "9"
"let s:red         = "1"
"let s:magenta     = "5"
"let s:violet      = "13"
"let s:blue        = "4"
"let s:cyan        = "6"
"let s:green       = "2"
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

"" Status Line
" -----------
set statusline=
"set statusline+=\ 
"set statusline+=%#StatusLineColorToggle#   " switch hi
"set statusline+=%2n\        " buffer number
"set statusline+=%*          " switch back to regular hi
hi FilepathStatusColor ctermfg=12 ctermbg=0
set statusline+=%#FilepathStatusColor#
set statusline+=%f           " filepath
hi ModifiedFlagColor ctermfg=1 ctermbg=0
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

" status line change color for insert mode
"hi StatusLineColorToggle ctermfg=white ctermbg=darkgrey 
"au InsertEnter * hi StatusLineColorToggle ctermfg=black ctermbg=3
"au InsertLeave * hi StatusLineColorToggle ctermfg=white ctermbg=darkgrey

"" Key bindings
"  ------------
let mapleader = "\<Space>"
set timeoutlen=500
"inoremap <Esc> <Esc>l
inoremap jk <Esc>
vnoremap jk <Esc>

" common actions
nnoremap <leader>e :e<Space>
nnoremap <leader>o :e<Space>
nnoremap <leader>n :enew<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>S :saveas<space>
nnoremap <leader>d :bd<CR>
nnoremap <leader>q :qa<CR>
nnoremap <leader>D :bd!<CR>
nnoremap <leader>Q :qa!<CR>

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
nnoremap <leader>J :tabprevious<CR>
nnoremap <leader>K :tabnext<CR>
nnoremap <leader>0 :ls<CR>
nnoremap <leader>) :ls!<CR>

" panes
map <leader>v :vs<CR>
map <leader>c :close<CR>

" movement
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
nnoremap W 5w
nnoremap B 5b
vnoremap W 5w
vnoremap B 5b
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
nnoremap <leader>z 1z=

" Toggles
nnoremap <leader>X :SyntasticToggleMode<CR>
nnoremap <leader>G :GitGutterToggle<CR>
nnoremap <leader>I :IndentLinesToggle<CR>
nnoremap <leader>N :set invnumber<CR>
nnoremap <leader>/ :set hlsearch!<CR>
nnoremap <leader>\ :set hlsearch!<CR>
nnoremap <leader>F :call ToggleStatusBar()<CR>
"nnoremap <leader>t " this is mapped in .vim/ftplugin/*.vim for showing TOC

" work signature
nnoremap <leader>x <Esc>o<CR>-- <CR>Gabriel A. Nespoli, B.Sc., M.A.<CR>Ph.D. Student \| SMART Lab<CR>Psychology \| Ryerson University<CR>105 Bond St, Toronto, ON M5B 1Y3<CR>gabe@psych.ryerson.ca<Esc>

"" Plugin settings
" ---------------
" Char Diff
let g:solarized_diffmode = 'high'

" Pandoc
"let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#toc#position = 'left'
let g:pandoc#toc#close_after_navigating = 1

" CriticMarkup
nnoremap <leader>a :Critic accept<CR>
nnoremap <leader>r :Critic reject<CR>
nnoremap <leader>h :call criticmarkup#InjectHighlighting()<CR>
"nnoremap <leader>c F{df}
" edit syntax highlighing in ~/.vim/vim-criticmarkup/autoload/ ??

" CSV
function! FormatTSV()
    " http://alangrow.com/blog/turn-vim-into-excel-tips-for-tabular-data-editing
    setlocal number noexpandtab shiftwidth=20 softtabstop=20 tabstop=20 nowrap
endfunc
nnoremap <leader>T :call FormatTSV()<CR>

" GitGutter 
let g:gitgutter_map_keys = 0 " unmap bindings that conflict with <leader>h
let g:gitgutter_enabled = 0 " toggle to start vim with gitgutter enabled

" IndentLine
let g:indentLine_char = '|'
let g:indentLine_color_term = 242

" NERDTree
nnoremap <leader>O :NERDTreeToggle<CR>

" minimap
"let g:minimap_show='<leader>ms'
"let g:minimap_update='<leader>mu'
"let g:minimap_close='<leader>gc'
"let g:minimap_toggle='<leader>gt'

" Lilypond
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
"set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
filetype on

" tmux navigator stuff
" https://github.com/christoomey/vim-tmux-navigator/issues/59
"let g:tmux_navigator_no_mappings = 1
"nnoremap <silent> <c-w>h :TmuxNavigateLeft<cr>
"nnoremap <silent> <c-w>j :TmuxNavigateDown<cr>
"nnoremap <silent> <c-w>k :TmuxNavigateUp<cr>
"nnoremap <silent> <c-w>l :TmuxNavigateRight<cr>
"nnoremap <silent> <c-w>; :TmuxNavigatePrevious<cr>

" tmux set tab title to vim filename; reset when quitting vim
"autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window '" . expand("%:t") . "'")
"autocmd VimLeave * call system("tmux setw automatic-rename")

"" Functions
" ---------
function! GetSyntaxUnderCursor() 
    return synIDattr(synID(line("."),col("."),1),"name")
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
    exe ":call ToggleCenteredWindow(80)"
    setlocal textwidth=0 wrapmargin=0 wrap linebreak laststatus=0 nonumber
    "setlocal nocp 
    exe "/^$"
endfunc

" center the pane by creating two empty panes on either side
" first arg is width of centered window (default 80)
" second arg is the width of the left-hand pad 
"   (default (winwidth - centerwidth) / 2)
let g:CenteredWindow = 0
let g:CenteredWindowPadLeft = 0 " buffer number of pad so it can be reused
let g:CenteredWindowPadRight = 0
function! ToggleCenteredWindow(...)

    if g:CenteredWindow != 0
        exe "normal! \<C-w>o"
        "execute "colorscheme ".g:colors_name
        hi nonText ctermfg=0
        hi VertSplit ctermfg=10
        let g:CenteredWindow = 0

    else
        let currentsplitrightvalue = &splitright
        hi NonText ctermfg=8
        hi VertSplit ctermfg=8
        if a:0 < 2
            "TODO round leftpadwidth to avoid decimals
            let leftpadwidth = (winwidth('%') - a:1) / 2
        else
            let leftpadwidth = a:2
        end

        " add left side pad pane and move focus back to current
        set nosplitright
        if g:CenteredWindowPadLeft == 0
            vnew
            let g:CenteredWindowPadLeft = bufnr('%') 
            set nobuflisted
            setlocal nonumber
            setlocal statusline=%(%)
        else
            vsplit
            exe "buffer".g:CenteredWindowPadLeft
        endif
        exe "vert resize ".leftpadwidth 
        exe "normal! \<C-w>l"

        " add right side pad pane and move focus back to current
        set splitright
        if g:CenteredWindowPadRight == 0
            vnew
            let g:CenteredWindowPadRight = bufnr('%')
            set nobuflisted
            setlocal nonumber
            setlocal statusline=%(%)
        else
            vsplit
            exe "buffer".g:CenteredWindowPadRight
        endif
        exe "normal! \<C-w>h"

        " resize center window, reset splitright value
        exe "vert resize ".a:1
        let g:CenteredWindow = bufnr('%')
        let &splitright=currentsplitrightvalue

    endif
endfunc
nnoremap <leader>C :call ToggleCenteredWindow(100)<CR>

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

" force some pandoc highlighting cause it always screws up
" (especially italics (emphasis); why is this always cterm=reverse?!)
hi pandocAtxStart ctermfg=7
hi pandocAtxHeader cterm=bold ctermfg=15
hi pandocOperator ctermfg=darkgrey
hi pandocStrong cterm=bold ctermfg=15
au VimEnter * hi pandocEmphasis cterm=none ctermfg=7
au VimEnter * hi pandocStrongEmphasis cterm=none ctermfg=15
au VimEnter * hi pandocStrongInEmphasis cterm=none ctermfg=15
au VimEnter * hi pandocEmphasisInStrong cterm=none ctermfg=7
nnoremap <leader>i :hi pandocEmphasis cterm=none<CR>:hi pandocStrongEmphasis cterm=none<CR>:hi pandocEmphasisInStrong cterm=none<CR>
":hi clear markdownItalic<CR>:hi markdownItalic ctermfg=7<CR>

