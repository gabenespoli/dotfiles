" .vimrc file for Gabriel A. Nespoli
" gabenespoli@gmail.com

"" Vundle Plugin Manager
" ---------------------
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-criticmarkup'
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
"hi clear SpellBad
hi SpellBad ctermfg=252 guifg=#d0d0d0 ctermbg=197 guibg=#ff005f
hi SpellCap ctermfg=252 guifg=#d0d0d0 ctermbg=33 guibg=#0087ff
"hi SpellLocal
hi SpellRare ctermfg=252 guifg=#d0d0d0 ctermbg=141 guibg=#af87ff

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
hi pandocAtxStart ctermfg=35 guifg=#00af5f
hi pandocEmphasis ctermbg=39 guibg=#00afff ctermfg=233 guifg=#121212
hi pandocStrong cterm=bold ctermfg=33 guifg=#0087ff
hi pandocListItemBulletId ctermfg=247 guifg=#9e9e9e
hi pandocListItemBullet ctermfg=247 guifg=#9e9e9e
hi pandocUListItemBullet ctermfg=247 guifg=#9e9e9e
hi pandocFootnoteIDHead ctermfg=242 guifg=#6c6c6c
hi pandocFootnoteIDTail ctermfg=242 guifg=#6c6c6c
hi pandocFootnoteID ctermfg=242 guifg=#6c6c6c
hi pandocFootnoteBlock ctermfg=247 guifg=#9e9e9e
hi pandocCiteLocator ctermfg=247 guifg=#9e9e9e
hi pandocCiteAnchor ctermfg=242 guifg=#6c6c6c
hi pandocCiteKey ctermfg=37 guifg=#00afaf
hi pandocPcite ctermfg=247 guifg=#9e9e9e
hi pandocImageIcon ctermfg=220 guifg=#ffd700
hi pandocNoFormatted ctermfg=141 guifg=#af87ff
hi pandocReferenceLabel ctermfg=247 guifg=#9e9e9e
hi pandocReferenceURL cterm=underline ctermfg=33 guifg=#0087ff
hi yamlBlockMappingKey ctermfg=242 guifg=#6c6c6c
hi yamlDocumentStart ctermfg=242 guifg=#6c6c6c
hi yamlFlowStringDelimiter ctermfg=242 guifg=#6c6c6c


" CriticMarkup
nnoremap <leader>a :Critic accept<CR>
nnoremap <leader>r :Critic reject<CR>
nnoremap <leader>c F{df}
" edit syntax highlighing in ~/.vim/vim-criticmarkup/autoload/ ??

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

hi LineNr term=none ctermfg=242 guifg=#6c6c6c
hi SignColumn ctermbg=233 guibg=#121212
hi FoldColumn term=standout ctermfg=242 guifg=#6c6c6c ctermbg=233 guibg=#121212
hi Folded term=standout cterm=bold ctermfg=252 guifg=#d0d0d0 ctermbg=242 guibg=#6c6c6c
hi VertSplit term=reverse cterm=reverse ctermfg=233 guifg=#121212 ctermbg=233 guibg=#121212
hi StatusLineNC term=reverse cterm=reverse ctermfg=233 guifg=#121212 ctermbg=233 guibg=#121212
hi StatusLine term=reverse cterm=none ctermfg=242 guifg=#6c6c6c ctermbg=233 guibg=#121212
"hi TabLine ctermfg=233 guifg=#121212
"hi TabLineFill ctermfg=252 guifg=#d0d0d0 ctermbg=242 guifg=#6c6c6c
"hi TabLineSel cterm

" Status Line
" -----------
set statusline=
set statusline+=%#StatusLineColorToggle#   " switch hi
set statusline+=%2n\        " buffer number
set statusline+=%#FoldColumn#
set statusline+=\ %f        " filepath
set statusline+=%#Function#
set statusline+=%m          " modified flag
set statusline+=%*          " switch back to regular hi
set statusline+=\  
set statusline+=%y          " filetype
set statusline+=[%{GetSyntax()}]
set statusline+=%=          " switch to the right side
set statusline+=%5l         " current line
set statusline+=/
set statusline+=%L          " total lines
set statusline+=\ 
set statusline+=[%{WordCount()}]
hi StatusLineColorToggle ctermfg=252 guifg=#d0d0d0 ctermbg=242 guibg=#6c6c6c
au InsertEnter * hi StatusLineColorToggle ctermfg=233 guifg=#121212 ctermbg=220 guibg=#ffd700
au InsertLeave * hi StatusLineColorToggle ctermfg=252 guifg=#d0d0d0 ctermbg=242 guibg=#6c6c6c

"" Misc
" ----
set hidden

" more natural default splits
set splitright
set splitbelow

"" Syntax Highlight Groups
" -----------------------
hi Normal ctermfg=252 guifg=#d0d0d0 ctermbg=233 guibg=#121212

" default groups and sub-groups specified in :help group-name
hi Comment cterm=none ctermfg=35 guifg=#00af5f

hi Constant ctermfg=99 guifg=#875fff
hi String ctermfg=141 guifg=#af87ff
hi Character ctermfg=247 guifg=#9e9e9e
hi Number ctermfg=37 guifg=#00afaf
hi Boolean ctermfg=37 guifg=#00afaf
hi Float ctermfg=44 guifg=#00afaf

hi Identifier ctermfg=166 guifg=#d75f00
hi Function ctermfg=220 guifg=#ffd700

hi Statement ctermfg=33 guifg=#0087ff
hi link Conditional Statement
hi link Repeat Statement
hi link Label Statement
hi Operator ctermfg=242 guifg=#6c6c6c
hi link Keyword Statement
hi link Keyword Exception

hi PreProc ctermfg=247 guifg=#9e9e9e
hi Include ctermfg=33 guifg=#0087ff
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc

hi Type ctermfg=39 guifg=#00afff
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type

hi Special ctermfg=242 guifg=#6c6c6c
hi link SpecialChar Special
hi link Tag Special
hi link Delimiter Special
hi link SpecialComment Special
hi link Debug Special

hi Underlined ctermfg=99 guifg=#875fff

hi Ignore ctermfg=247 guifg=#9e9e9e

hi Error term=reverse ctermfg=252 guifg=#d0d0d0 ctermbg=197 guibg=#ff005f

hi Todo ctermfg=233 guifg=#121212 ctermbg=166 guibg=#d75f00

" groups I've added
hi SpecialKey ctermfg=33 guifg=#0087ff
hi ErrorMsg term=standout ctermfg=252 guifg=#d0d0d0 ctermbg=197 guibg=#ff005f
hi WarningMsg term=standout ctermfg=252 guifg=#d0d0d0 ctermbg=166 guibg=#d75f00
hi MatchParen ctermfg=247 guifg=#9e9e9e ctermbg=242 guibg=#6c6c6c

" for use in this vimrc file
hi Title ctermfg=35 guifg=#00af5f
hi Italic ctermbg=39 guibg=#00afff ctermfg=233 guifg=#121212
hi Bold ctermfg=33 guifg=#0087ff

" language-specific
"hi link markdownHeadingDelimiter Title
"hi markdownListMarker ctermfg=LightGrey ctermbg=Black
hi link markdownItalic Italic
hi link markdownBold Bold
hi link shFunctionKey Statement
hi link pythonTripleQuotes Comment
hi link matlabDelimiter Operator
hi link rPreProc Include
hi link rAssign Operator
hi link htmlTag Operator
hi link htmlEndTag Operator

" misc
hi NonText term=bold cterm=bold ctermfg=33 guifg=#0087ff
hi Directory term=bold ctermfg=33 guifg=#0087ff
hi IncSearch term=reverse cterm=reverse
hi Search term=reverse ctermfg=233 guifg=#121212 ctermbg=166 guibg=#d75f00
hi MoreMsg term=bold ctermfg=35 guifg=#00af5f
hi ModeMsg term=bold cterm=bold
hi Question term=standout ctermfg=35 guifg=#00af5f
hi Visual term=reverse cterm=reverse
hi VisualNOS term=bold,underline cterm=bold,underline
hi WildMenu term=standout ctermfg=233 guifg=#121212 ctermbg=39 guibg=#00afff
hi DiffAdd ctermfg=42 guifg=#00d787
hi DiffChange ctermbg=220 guibg=#ffd700
hi DiffDelete cterm=bold ctermfg=211 guifg=#ff87af ctermbg=44 guibg=#00d7d7
hi DiffText cterm=bold ctermbg=211 guibg=#ff87af

"colorscheme sumach
" Sumach Colors chosen from xterm 256
" https://jonasjacek.github.io/colors/
" http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
hi SumachBlack          ctermfg=233 guifg=#121212
hi SumachRed            ctermfg=197 guifg=#ff005f
hi SumachGreen          ctermfg=35  guifg=#00af5f
hi SumachYellow         ctermfg=166 guifg=#d75f00
hi SumachBlue           ctermfg=33  guifg=#0087ff
hi SumachMagenta        ctermfg=99  guifg=#875fff
hi SumachCyan           ctermfg=37  guifg=#00afaf
hi SumachWhite          ctermfg=247 guifg=#9e9e9e
hi SumachBrightBlack    ctermfg=242 guifg=#6c6c6c
hi SumachBrightRed      ctermfg=211 guifg=#ff87af
hi SumachBrightGreen    ctermfg=42  guifg=#00d787
hi SumachBrightYellow   ctermfg=220 guifg=#ffd700
hi SumachBrightBlue     ctermfg=39  guifg=#00afff
hi SumachBrightMagenta  ctermfg=141 guifg=#af87ff
hi SumachBrightCyan     ctermfg=44  guifg=#00d7d7
hi SumachBrightWhite    ctermfg=252 guifg=#d0d0d0

" prevent macvim from changing colors after loading this vimrc
let macvim_skip_colorscheme=1

"" xterm 256 color names, codes, hex values, "rgb values
" -----------------------------------------------------
"hi x016_Grey0 ctermfg=16 guifg=#000000 "rgb=0,0,0
"hi x017_NavyBlue ctermfg=17 guifg=#00005f "rgb=0,0,95
"hi x018_DarkBlue ctermfg=18 guifg=#000087 "rgb=0,0,135
"hi x019_Blue3 ctermfg=19 guifg=#0000af "rgb=0,0,175
"hi x020_Blue3 ctermfg=20 guifg=#0000d7 "rgb=0,0,215
"hi x021_Blue1 ctermfg=21 guifg=#0000ff "rgb=0,0,255
"hi x022_DarkGreen ctermfg=22 guifg=#005f00 "rgb=0,95,0
"hi x023_DeepSkyBlue4 ctermfg=23 guifg=#005f5f "rgb=0,95,95
"hi x024_DeepSkyBlue4 ctermfg=24 guifg=#005f87 "rgb=0,95,135
"hi x025_DeepSkyBlue4 ctermfg=25 guifg=#005faf "rgb=0,95,175
"hi x026_DodgerBlue3 ctermfg=26 guifg=#005fd7 "rgb=0,95,215
"hi x027_DodgerBlue2 ctermfg=27 guifg=#005fff "rgb=0,95,255
"hi x028_Green4 ctermfg=28 guifg=#008700 "rgb=0,135,0
"hi x029_SpringGreen4 ctermfg=29 guifg=#00875f "rgb=0,135,95
"hi x030_Turquoise4 ctermfg=30 guifg=#008787 "rgb=0,135,135
"hi x031_DeepSkyBlue3 ctermfg=31 guifg=#0087af "rgb=0,135,175
"hi x032_DeepSkyBlue3 ctermfg=32 guifg=#0087d7 "rgb=0,135,215
"hi x033_DodgerBlue1 ctermfg=33 guifg=#0087ff "rgb=0,135,255
"hi x034_Green3 ctermfg=34 guifg=#00af00 "rgb=0,175,0
"hi x035_SpringGreen3 ctermfg=35 guifg=#00af5f "rgb=0,175,95
"hi x036_DarkCyan ctermfg=36 guifg=#00af87 "rgb=0,175,135
"hi x037_LightSeaGreen ctermfg=37 guifg=#00afaf "rgb=0,175,175
"hi x038_DeepSkyBlue2 ctermfg=38 guifg=#00afd7 "rgb=0,175,215
"hi x039_DeepSkyBlue1 ctermfg=39 guifg=#00afff "rgb=0,175,255
"hi x040_Green3 ctermfg=40 guifg=#00d700 "rgb=0,215,0
"hi x041_SpringGreen3 ctermfg=41 guifg=#00d75f "rgb=0,215,95
"hi x042_SpringGreen2 ctermfg=42 guifg=#00d787 "rgb=0,215,135
"hi x043_Cyan3 ctermfg=43 guifg=#00d7af "rgb=0,215,175
"hi x044_DarkTurquoise ctermfg=44 guifg=#00d7d7 "rgb=0,215,215
"hi x045_Turquoise2 ctermfg=45 guifg=#00d7ff "rgb=0,215,255
"hi x046_Green1 ctermfg=46 guifg=#00ff00 "rgb=0,255,0
"hi x047_SpringGreen2 ctermfg=47 guifg=#00ff5f "rgb=0,255,95
"hi x048_SpringGreen1 ctermfg=48 guifg=#00ff87 "rgb=0,255,135
"hi x049_MediumSpringGreen ctermfg=49 guifg=#00ffaf "rgb=0,255,175
"hi x050_Cyan2 ctermfg=50 guifg=#00ffd7 "rgb=0,255,215
"hi x051_Cyan1 ctermfg=51 guifg=#00ffff "rgb=0,255,255
"hi x052_DarkRed ctermfg=52 guifg=#5f0000 "rgb=95,0,0
"hi x053_DeepPink4 ctermfg=53 guifg=#5f005f "rgb=95,0,95
"hi x054_Purple4 ctermfg=54 guifg=#5f0087 "rgb=95,0,135
"hi x055_Purple4 ctermfg=55 guifg=#5f00af "rgb=95,0,175
"hi x056_Purple3 ctermfg=56 guifg=#5f00d7 "rgb=95,0,215
"hi x057_BlueViolet ctermfg=57 guifg=#5f00ff "rgb=95,0,255
"hi x058_Orange4 ctermfg=58 guifg=#5f5f00 "rgb=95,95,0
"hi x059_Grey37 ctermfg=59 guifg=#5f5f5f "rgb=95,95,95
"hi x060_MediumPurple4 ctermfg=60 guifg=#5f5f87 "rgb=95,95,135
"hi x061_SlateBlue3 ctermfg=61 guifg=#5f5faf "rgb=95,95,175
"hi x062_SlateBlue3 ctermfg=62 guifg=#5f5fd7 "rgb=95,95,215
"hi x063_RoyalBlue1 ctermfg=63 guifg=#5f5fff "rgb=95,95,255
"hi x064_Chartreuse4 ctermfg=64 guifg=#5f8700 "rgb=95,135,0
"hi x065_DarkSeaGreen4 ctermfg=65 guifg=#5f875f "rgb=95,135,95
"hi x066_PaleTurquoise4 ctermfg=66 guifg=#5f8787 "rgb=95,135,135
"hi x067_SteelBlue ctermfg=67 guifg=#5f87af "rgb=95,135,175
"hi x068_SteelBlue3 ctermfg=68 guifg=#5f87d7 "rgb=95,135,215
"hi x069_CornflowerBlue ctermfg=69 guifg=#5f87ff "rgb=95,135,255
"hi x070_Chartreuse3 ctermfg=70 guifg=#5faf00 "rgb=95,175,0
"hi x071_DarkSeaGreen4 ctermfg=71 guifg=#5faf5f "rgb=95,175,95
"hi x072_CadetBlue ctermfg=72 guifg=#5faf87 "rgb=95,175,135
"hi x073_CadetBlue ctermfg=73 guifg=#5fafaf "rgb=95,175,175
"hi x074_SkyBlue3 ctermfg=74 guifg=#5fafd7 "rgb=95,175,215
"hi x075_SteelBlue1 ctermfg=75 guifg=#5fafff "rgb=95,175,255
"hi x076_Chartreuse3 ctermfg=76 guifg=#5fd700 "rgb=95,215,0
"hi x077_PaleGreen3 ctermfg=77 guifg=#5fd75f "rgb=95,215,95
"hi x078_SeaGreen3 ctermfg=78 guifg=#5fd787 "rgb=95,215,135
"hi x079_Aquamarine3 ctermfg=79 guifg=#5fd7af "rgb=95,215,175
"hi x080_MediumTurquoise ctermfg=80 guifg=#5fd7d7 "rgb=95,215,215
"hi x081_SteelBlue1 ctermfg=81 guifg=#5fd7ff "rgb=95,215,255
"hi x082_Chartreuse2 ctermfg=82 guifg=#5fff00 "rgb=95,255,0
"hi x083_SeaGreen2 ctermfg=83 guifg=#5fff5f "rgb=95,255,95
"hi x084_SeaGreen1 ctermfg=84 guifg=#5fff87 "rgb=95,255,135
"hi x085_SeaGreen1 ctermfg=85 guifg=#5fffaf "rgb=95,255,175
"hi x086_Aquamarine1 ctermfg=86 guifg=#5fffd7 "rgb=95,255,215
"hi x087_DarkSlateGray2 ctermfg=87 guifg=#5fffff "rgb=95,255,255
"hi x088_DarkRed ctermfg=88 guifg=#870000 "rgb=135,0,0
"hi x089_DeepPink4 ctermfg=89 guifg=#87005f "rgb=135,0,95
"hi x090_DarkMagenta ctermfg=90 guifg=#870087 "rgb=135,0,135
"hi x091_DarkMagenta ctermfg=91 guifg=#8700af "rgb=135,0,175
"hi x092_DarkViolet ctermfg=92 guifg=#8700d7 "rgb=135,0,215
"hi x093_Purple ctermfg=93 guifg=#8700ff "rgb=135,0,255
"hi x094_Orange4 ctermfg=94 guifg=#875f00 "rgb=135,95,0
"hi x095_LightPink4 ctermfg=95 guifg=#875f5f "rgb=135,95,95
"hi x096_Plum4 ctermfg=96 guifg=#875f87 "rgb=135,95,135
"hi x097_MediumPurple3 ctermfg=97 guifg=#875faf "rgb=135,95,175
"hi x098_MediumPurple3 ctermfg=98 guifg=#875fd7 "rgb=135,95,215
"hi x099_SlateBlue1 ctermfg=99 guifg=#875fff "rgb=135,95,255
"hi x100_Yellow4 ctermfg=100 guifg=#878700 "rgb=135,135,0
"hi x101_Wheat4 ctermfg=101 guifg=#87875f "rgb=135,135,95
"hi x102_Grey53 ctermfg=102 guifg=#878787 "rgb=135,135,135
"hi x103_LightSlateGrey ctermfg=103 guifg=#8787af "rgb=135,135,175
"hi x104_MediumPurple ctermfg=104 guifg=#8787d7 "rgb=135,135,215
"hi x105_LightSlateBlue ctermfg=105 guifg=#8787ff "rgb=135,135,255
"hi x106_Yellow4 ctermfg=106 guifg=#87af00 "rgb=135,175,0
"hi x107_DarkOliveGreen3 ctermfg=107 guifg=#87af5f "rgb=135,175,95
"hi x108_DarkSeaGreen ctermfg=108 guifg=#87af87 "rgb=135,175,135
"hi x109_LightSkyBlue3 ctermfg=109 guifg=#87afaf "rgb=135,175,175
"hi x110_LightSkyBlue3 ctermfg=110 guifg=#87afd7 "rgb=135,175,215
"hi x111_SkyBlue2 ctermfg=111 guifg=#87afff "rgb=135,175,255
"hi x112_Chartreuse2 ctermfg=112 guifg=#87d700 "rgb=135,215,0
"hi x113_DarkOliveGreen3 ctermfg=113 guifg=#87d75f "rgb=135,215,95
"hi x114_PaleGreen3 ctermfg=114 guifg=#87d787 "rgb=135,215,135
"hi x115_DarkSeaGreen3 ctermfg=115 guifg=#87d7af "rgb=135,215,175
"hi x116_DarkSlateGray3 ctermfg=116 guifg=#87d7d7 "rgb=135,215,215
"hi x117_SkyBlue1 ctermfg=117 guifg=#87d7ff "rgb=135,215,255
"hi x118_Chartreuse1 ctermfg=118 guifg=#87ff00 "rgb=135,255,0
"hi x119_LightGreen ctermfg=119 guifg=#87ff5f "rgb=135,255,95
"hi x120_LightGreen ctermfg=120 guifg=#87ff87 "rgb=135,255,135
"hi x121_PaleGreen1 ctermfg=121 guifg=#87ffaf "rgb=135,255,175
"hi x122_Aquamarine1 ctermfg=122 guifg=#87ffd7 "rgb=135,255,215
"hi x123_DarkSlateGray1 ctermfg=123 guifg=#87ffff "rgb=135,255,255
"hi x124_Red3 ctermfg=124 guifg=#af0000 "rgb=175,0,0
"hi x125_DeepPink4 ctermfg=125 guifg=#af005f "rgb=175,0,95
"hi x126_MediumVioletRed ctermfg=126 guifg=#af0087 "rgb=175,0,135
"hi x127_Magenta3 ctermfg=127 guifg=#af00af "rgb=175,0,175
"hi x128_DarkViolet ctermfg=128 guifg=#af00d7 "rgb=175,0,215
"hi x129_Purple ctermfg=129 guifg=#af00ff "rgb=175,0,255
"hi x130_DarkOrange3 ctermfg=130 guifg=#af5f00 "rgb=175,95,0
"hi x131_IndianRed ctermfg=131 guifg=#af5f5f "rgb=175,95,95
"hi x132_HotPink3 ctermfg=132 guifg=#af5f87 "rgb=175,95,135
"hi x133_MediumOrchid3 ctermfg=133 guifg=#af5faf "rgb=175,95,175
"hi x134_MediumOrchid ctermfg=134 guifg=#af5fd7 "rgb=175,95,215
"hi x135_MediumPurple2 ctermfg=135 guifg=#af5fff "rgb=175,95,255
"hi x136_DarkGoldenrod ctermfg=136 guifg=#af8700 "rgb=175,135,0
"hi x137_LightSalmon3 ctermfg=137 guifg=#af875f "rgb=175,135,95
"hi x138_RosyBrown ctermfg=138 guifg=#af8787 "rgb=175,135,135
"hi x139_Grey63 ctermfg=139 guifg=#af87af "rgb=175,135,175
"hi x140_MediumPurple2 ctermfg=140 guifg=#af87d7 "rgb=175,135,215
"hi x141_MediumPurple1 ctermfg=141 guifg=#af87ff "rgb=175,135,255
"hi x142_Gold3 ctermfg=142 guifg=#afaf00 "rgb=175,175,0
"hi x143_DarkKhaki ctermfg=143 guifg=#afaf5f "rgb=175,175,95
"hi x144_NavajoWhite3 ctermfg=144 guifg=#afaf87 "rgb=175,175,135
"hi x145_Grey69 ctermfg=145 guifg=#afafaf "rgb=175,175,175
"hi x146_LightSteelBlue3 ctermfg=146 guifg=#afafd7 "rgb=175,175,215
"hi x147_LightSteelBlue ctermfg=147 guifg=#afafff "rgb=175,175,255
"hi x148_Yellow3 ctermfg=148 guifg=#afd700 "rgb=175,215,0
"hi x149_DarkOliveGreen3 ctermfg=149 guifg=#afd75f "rgb=175,215,95
"hi x150_DarkSeaGreen3 ctermfg=150 guifg=#afd787 "rgb=175,215,135
"hi x151_DarkSeaGreen2 ctermfg=151 guifg=#afd7af "rgb=175,215,175
"hi x152_LightCyan3 ctermfg=152 guifg=#afd7d7 "rgb=175,215,215
"hi x153_LightSkyBlue1 ctermfg=153 guifg=#afd7ff "rgb=175,215,255
"hi x154_GreenYellow ctermfg=154 guifg=#afff00 "rgb=175,255,0
"hi x155_DarkOliveGreen2 ctermfg=155 guifg=#afff5f "rgb=175,255,95
"hi x156_PaleGreen1 ctermfg=156 guifg=#afff87 "rgb=175,255,135
"hi x157_DarkSeaGreen2 ctermfg=157 guifg=#afffaf "rgb=175,255,175
"hi x158_DarkSeaGreen1 ctermfg=158 guifg=#afffd7 "rgb=175,255,215
"hi x159_PaleTurquoise1 ctermfg=159 guifg=#afffff "rgb=175,255,255
"hi x160_Red3 ctermfg=160 guifg=#d70000 "rgb=215,0,0
"hi x161_DeepPink3 ctermfg=161 guifg=#d7005f "rgb=215,0,95
"hi x162_DeepPink3 ctermfg=162 guifg=#d70087 "rgb=215,0,135
"hi x163_Magenta3 ctermfg=163 guifg=#d700af "rgb=215,0,175
"hi x164_Magenta3 ctermfg=164 guifg=#d700d7 "rgb=215,0,215
"hi x165_Magenta2 ctermfg=165 guifg=#d700ff "rgb=215,0,255
"hi x166_DarkOrange3 ctermfg=166 guifg=#d75f00 "rgb=215,95,0
"hi x167_IndianRed ctermfg=167 guifg=#d75f5f "rgb=215,95,95
"hi x168_HotPink3 ctermfg=168 guifg=#d75f87 "rgb=215,95,135
"hi x169_HotPink2 ctermfg=169 guifg=#d75faf "rgb=215,95,175
"hi x170_Orchid ctermfg=170 guifg=#d75fd7 "rgb=215,95,215
"hi x171_MediumOrchid1 ctermfg=171 guifg=#d75fff "rgb=215,95,255
"hi x172_Orange3 ctermfg=172 guifg=#d78700 "rgb=215,135,0
"hi x173_LightSalmon3 ctermfg=173 guifg=#d7875f "rgb=215,135,95
"hi x174_LightPink3 ctermfg=174 guifg=#d78787 "rgb=215,135,135
"hi x175_Pink3 ctermfg=175 guifg=#d787af "rgb=215,135,175
"hi x176_Plum3 ctermfg=176 guifg=#d787d7 "rgb=215,135,215
"hi x177_Violet ctermfg=177 guifg=#d787ff "rgb=215,135,255
"hi x178_Gold3 ctermfg=178 guifg=#d7af00 "rgb=215,175,0
"hi x179_LightGoldenrod3 ctermfg=179 guifg=#d7af5f "rgb=215,175,95
"hi x180_Tan ctermfg=180 guifg=#d7af87 "rgb=215,175,135
"hi x181_MistyRose3 ctermfg=181 guifg=#d7afaf "rgb=215,175,175
"hi x182_Thistle3 ctermfg=182 guifg=#d7afd7 "rgb=215,175,215
"hi x183_Plum2 ctermfg=183 guifg=#d7afff "rgb=215,175,255
"hi x184_Yellow3 ctermfg=184 guifg=#d7d700 "rgb=215,215,0
"hi x185_Khaki3 ctermfg=185 guifg=#d7d75f "rgb=215,215,95
"hi x186_LightGoldenrod2 ctermfg=186 guifg=#d7d787 "rgb=215,215,135
"hi x187_LightYellow3 ctermfg=187 guifg=#d7d7af "rgb=215,215,175
"hi x188_Grey84 ctermfg=188 guifg=#d7d7d7 "rgb=215,215,215
"hi x189_LightSteelBlue1 ctermfg=189 guifg=#d7d7ff "rgb=215,215,255
"hi x190_Yellow2 ctermfg=190 guifg=#d7ff00 "rgb=215,255,0
"hi x191_DarkOliveGreen1 ctermfg=191 guifg=#d7ff5f "rgb=215,255,95
"hi x192_DarkOliveGreen1 ctermfg=192 guifg=#d7ff87 "rgb=215,255,135
"hi x193_DarkSeaGreen1 ctermfg=193 guifg=#d7ffaf "rgb=215,255,175
"hi x194_Honeydew2 ctermfg=194 guifg=#d7ffd7 "rgb=215,255,215
"hi x195_LightCyan1 ctermfg=195 guifg=#d7ffff "rgb=215,255,255
"hi x196_Red1 ctermfg=196 guifg=#ff0000 "rgb=255,0,0
"hi x197_DeepPink2 ctermfg=197 guifg=#ff005f "rgb=255,0,95
"hi x198_DeepPink1 ctermfg=198 guifg=#ff0087 "rgb=255,0,135
"hi x199_DeepPink1 ctermfg=199 guifg=#ff00af "rgb=255,0,175
"hi x200_Magenta2 ctermfg=200 guifg=#ff00d7 "rgb=255,0,215
"hi x201_Magenta1 ctermfg=201 guifg=#ff00ff "rgb=255,0,255
"hi x202_OrangeRed1 ctermfg=202 guifg=#ff5f00 "rgb=255,95,0
"hi x203_IndianRed1 ctermfg=203 guifg=#ff5f5f "rgb=255,95,95
"hi x204_IndianRed1 ctermfg=204 guifg=#ff5f87 "rgb=255,95,135
"hi x205_HotPink ctermfg=205 guifg=#ff5faf "rgb=255,95,175
"hi x206_HotPink ctermfg=206 guifg=#ff5fd7 "rgb=255,95,215
"hi x207_MediumOrchid1 ctermfg=207 guifg=#ff5fff "rgb=255,95,255
"hi x208_DarkOrange ctermfg=208 guifg=#ff8700 "rgb=255,135,0
"hi x209_Salmon1 ctermfg=209 guifg=#ff875f "rgb=255,135,95
"hi x210_LightCoral ctermfg=210 guifg=#ff8787 "rgb=255,135,135
"hi x211_PaleVioletRed1 ctermfg=211 guifg=#ff87af "rgb=255,135,175
"hi x212_Orchid2 ctermfg=212 guifg=#ff87d7 "rgb=255,135,215
"hi x213_Orchid1 ctermfg=213 guifg=#ff87ff "rgb=255,135,255
"hi x214_Orange1 ctermfg=214 guifg=#ffaf00 "rgb=255,175,0
"hi x215_SandyBrown ctermfg=215 guifg=#ffaf5f "rgb=255,175,95
"hi x216_LightSalmon1 ctermfg=216 guifg=#ffaf87 "rgb=255,175,135
"hi x217_LightPink1 ctermfg=217 guifg=#ffafaf "rgb=255,175,175
"hi x218_Pink1 ctermfg=218 guifg=#ffafd7 "rgb=255,175,215
"hi x219_Plum1 ctermfg=219 guifg=#ffafff "rgb=255,175,255
"hi x220_Gold1 ctermfg=220 guifg=#ffd700 "rgb=255,215,0
"hi x221_LightGoldenrod2 ctermfg=221 guifg=#ffd75f "rgb=255,215,95
"hi x222_LightGoldenrod2 ctermfg=222 guifg=#ffd787 "rgb=255,215,135
"hi x223_NavajoWhite1 ctermfg=223 guifg=#ffd7af "rgb=255,215,175
"hi x224_MistyRose1 ctermfg=224 guifg=#ffd7d7 "rgb=255,215,215
"hi x225_Thistle1 ctermfg=225 guifg=#ffd7ff "rgb=255,215,255
"hi x226_Yellow1 ctermfg=226 guifg=#ffff00 "rgb=255,255,0
"hi x227_LightGoldenrod1 ctermfg=227 guifg=#ffff5f "rgb=255,255,95
"hi x228_Khaki1 ctermfg=228 guifg=#ffff87 "rgb=255,255,135
"hi x229_Wheat1 ctermfg=229 guifg=#ffffaf "rgb=255,255,175
"hi x230_Cornsilk1 ctermfg=230 guifg=#ffffd7 "rgb=255,255,215
"hi x231_Grey100 ctermfg=231 guifg=#ffffff "rgb=255,255,255
"hi x232_Grey3 ctermfg=232 guifg=#080808 "rgb=8,8,8
"hi x233_Grey7 ctermfg=233 guifg=#121212 "rgb=18,18,18
"hi x234_Grey11 ctermfg=234 guifg=#1c1c1c "rgb=28,28,28
"hi x235_Grey15 ctermfg=235 guifg=#262626 "rgb=38,38,38
"hi x236_Grey19 ctermfg=236 guifg=#303030 "rgb=48,48,48
"hi x237_Grey23 ctermfg=237 guifg=#3a3a3a "rgb=58,58,58
"hi x238_Grey27 ctermfg=238 guifg=#444444 "rgb=68,68,68
"hi x239_Grey30 ctermfg=239 guifg=#4e4e4e "rgb=78,78,78
"hi x240_Grey35 ctermfg=240 guifg=#585858 "rgb=88,88,88
"hi x241_Grey39 ctermfg=241 guifg=#626262 "rgb=98,98,98
"hi x242_Grey42 ctermfg=242 guifg=#6c6c6c "rgb=108,108,108
"hi x243_Grey46 ctermfg=243 guifg=#767676 "rgb=118,118,118
"hi x244_Grey50 ctermfg=244 guifg=#808080 "rgb=128,128,128
"hi x245_Grey54 ctermfg=245 guifg=#8a8a8a "rgb=138,138,138
"hi x246_Grey58 ctermfg=246 guifg=#949494 "rgb=148,148,148
"hi x247_Grey62 ctermfg=247 guifg=#9e9e9e "rgb=158,158,158
"hi x248_Grey66 ctermfg=248 guifg=#a8a8a8 "rgb=168,168,168
"hi x249_Grey70 ctermfg=249 guifg=#b2b2b2 "rgb=178,178,178
"hi x250_Grey74 ctermfg=250 guifg=#bcbcbc "rgb=188,188,188
"hi x251_Grey78 ctermfg=251 guifg=#c6c6c6 "rgb=198,198,198
"hi x252_Grey82 ctermfg=252 guifg=#d0d0d0 "rgb=208,208,208
"hi x253_Grey85 ctermfg=253 guifg=#dadada "rgb=218,218,218
"hi x254_Grey89 ctermfg=254 guifg=#e4e4e4 "rgb=228,228,228
"hi x255_Grey93 ctermfg=255 guifg=#eeeeee "rgb=238,238,238
