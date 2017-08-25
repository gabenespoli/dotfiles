"" .vimrc file for Gabriel A. Nespoli
" gabenespoli@gmail.com

"" Vundle Plugin Manager
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" my plugins
" Plugin 'file:///Users/gmac/bin/vim/capitalL.vim'
" Plugin 'file:///Users/gmac/bin/vim/vim-cenwin'

" vim and git
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
" Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
" Plugin 'rickhowe/diffchar.vim'
" Plugin 'kana/vim-submode'
Plugin 'gcmt/taboo.vim'
" Plugin 'ervandew/supertab'
"Plugin 'Valloric/YouCompleteMe'
" Plugin 'vim-scripts/Rename'

" files
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'francoiscabrol/ranger.vim'
Plugin 'scrooloose/NERDTree'
" Plugin 'miyakogi/sidepanel.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'majutsushi/tagbar'
Plugin 'jszakmeister/markdown2ctags'
" Plugin 'sjl/gundo.vim'

" programs
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jpalardy/vim-slime'
"Plugin 'ivanov/vim-ipython'

" syntax
Plugin 'w0rp/ale'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-criticmarkup'
Plugin 'jvirtanen/vim-octave'
"Plugin 'hrother/offlineimaprc.vim'
"Plugin 'vim-scripts/todo-txt.vim'
"Plugin 'toyamarinyon/vim-swift'
" Plugin 'dhruvasagar/vim-table-mode'

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
set updatetime=750
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
set breakindent         " auto indent soft wrap line breaks
set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set shiftwidth=4
set expandtab           " tabs are spaces
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set nolist              " show invisibles
set backspace=indent,eol,start " enable backspacing text that was inserted previously
set ignorecase
set smartcase           " if [search terms] has uppercase, then case sensitive


"" UI Config
set number
set relativenumber
set showcmd              " show command in bottom bar
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
let loaded_matchparen = 1 " don't match parentheses, use % instead

"" Status Line
" ale [+][RO] 'filename' [type][fugitive] ... line/lines,col (pct)
" use this to add [tab#|win#] ... [%{tabpagenr()}\|%{winnr()}]
set statusline=
set statusline+=%#ErrorMsg#%{LinterStatus('Errors')}%*
set statusline+=%#WarningMsg#%{LinterStatus('Warnings')}%*
" set statusline+=%{mode()}
set statusline+=\ %#StatusMod#%m%*%#StatusFlag#%r%*\"%t\"\ %y
set statusline+=%{fugitive#statusline()}
set statusline+=%#StatusLineFill#%=%*                      
set statusline+=%l/%L\,%c\ (%P)                           

"" Keybindings
let mapleader = "\<Space>"
set notimeout
set ttimeout
inoremap jk <Esc>

""" emacs-style command line (cmap)
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>b <S-Left>
cnoremap <C-d> <Del>
cnoremap <C-i> <C-d>

""" opening and saving
"<leader>o opens ctrlp plugin
noremap <leader>O :e <C-r>=expand('%:p:h')<CR><CR>
nnoremap <leader>N :tabnew 
nnoremap <leader>s :w<CR>

""" tab switching
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>[ gT
nnoremap <leader>] gt

""" swap q/Q for <leader>q/Q, so q/Q can be used for quitting
nnoremap q :q<CR>
nnoremap Q :qa<CR>

""" status/info toggles
nmap <leader>W :echo WordCount()<CR>
nmap <leader>S :call ToggleStatusBar()<CR>
nmap <leader>F :call ToggleTabline()<CR>
nmap <leader>X :echo GetSyntaxUnderCursor()<CR>

""" misc
" copy/paste
nnoremap Y y$
" for tmux https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
set clipboard=unnamed

nnoremap <leader>d "=strftime("%Y-%m-%d")<CR>p
nnoremap <leader>D "=strftime("%Y-%m-%d %H:%M:%S")<CR>p

"vimdiff
nnoremap du :diffupdate<CR>

" emacs movement
inoremap <C-d> <Del>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" Spell checking
nnoremap <localleader>s 1z=

""" resizing windows based on terminal size
" this requires $COLS and $LINES environment vars which are set to `tput cols` and `tput lines`
let g:centerwidth = 100
let g:width = $COLS / 4
let g:height = $LINES / 4
au VimEnter,BufEnter * if !exists('g:width')  | let g:width  = $COLS  / 2 | endif
au VimEnter,BufEnter * if !exists('g:height') | let g:height = $LINES / 4 | endif
function! ResizeCenterWidth()
    execute 'vertical resize '.g:centerwidth
endfunction
function! ResizeSideWidth()
    execute 'vertical resize '.g:width
endfunction
function! ResizeSideHeight()
    execute 'resize '.g:height
endfunction
nnoremap <leader>rc :call ResizeCenterWidth()<CR>
nnoremap <leader>rw :call ResizeSideWidth()<CR>
nnoremap <leader>rh :call ResizeSideHeight()<CR>

"" Plugin settings
""" tpope/vim-commentary
autocmd FileType octave setlocal commentstring=%\ %s

""" tpope/vim-unimpaired
" my own macro binding of the default ones
nnoremap coN :set relativenumber!<CR>:set number!<CR>
nnoremap coH :call SearchHighlightToggle()<CR>
nnoremap <C-n> :lnext<CR>zt
nnoremap <C-p> :lprevious<CR>zt

""" Git (tpope/vim-fugitive & airblade/vim-gitgutter)
let g:gitgutter_eager = 0
nmap cog :GitGutterSignsToggle<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>ga :Gwrite<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gwc :Gwrite<CR>:Gcommit<CR>i
nmap <leader>ghd <Plug>GitGutterPreviewHunk
nmap <leader>gha <Plug>GitGutterStageHunk
nmap <leader>ghu <Plug>GitGutterUndoHunk
nmap <leader>ghc :GitGutterStageHunk<CR>:Gcommit<CR>i

""" taboo.vim
let g:taboo_tabline = 0

""" ctrlp
let g:ctrlp_map = '<leader>o'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_prompt_mappings = { 
            \ 'PrtSelectMove("j")':     ['<C-n>','<down>'],
            \ 'PrtSelectMove("k")':     ['<C-p>','<up>'],
            \ 'PrtHistory(-1)':         [],
            \ 'PrtHistory(1)':          [],
            \ 'AcceptSelection("e")':   [],
            \ 'AcceptSelection("t")':   ['<C-m>', '<C-j>', '<CR>', '<2-LeftMouse>'],
            \ 'ToggleType(-1)':         ['<C-b>', '<C-down>'],
            \ 'ToggleType(1)':          ['<C-f>', '<C-up>'],
            \ }

""" ranger
" let g:ranger_map_keys = 0
" nnoremap <leader>O :RangerNewTab<CR>

""" NERDTree
let g:NERDTreeDirArrowExpandable='+'
let g:NERDTreeDirArrowCollapsible='-'
let NERDTreeWinPos = 'left'
let NERDTreeWinSize = g:width
let NERDTreeMapUpdir = 'h'
let NERDTreeMapChangeRoot = 'l'
let NERDTreeMapJumpNextSibling = '<C-n>'
let NERDTreeMapJumpPrevSibling = '<C-p>'
let NERDTreeMapPreview = 'i'
let NERDTreeMapOpenSplit = 's'
let NERDTreeMapOpenVSplit = 'v'
let NERDTreeMapPreviewSplit = 'gs'
let NERDTreeMapPreviewVSplit = 'gv'
let NERDTreeShowLineNumbers = 1
let NERDTreeHijackNetrw = 0

""" buffergator
let g:buffergator_viewport_split_policy = "L"
let g:buffergator_vsplit_size = g:width
let g:buffergator_hsplit_size = g:height
let g:buffergator_suppress_keymaps = 1

""" tagbar
let g:tagbar_left = 1
let g:tagbar_width = g:width
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

""" markdown2ctags
let g:tagbar_type_pandoc = {
    \ 'ctagstype': 'pandoc',
    \ 'ctagsbin' : '~/.vim/bundle/markdown2ctags/markdown2ctags.py',
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

""" gundo
let g:gundo_right = 0
let g:gundo_width = g:width
let g:gundo_preview_height = 15

""" sidebars.vim
source ~/dotfiles/vim/sidebars.vim

""" vim-tmux-navigator
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
let g:tmux_navigator_no_mappings = 1
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

""" vim-slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.1"}
let g:slime_dont_ask_default = 1
nnoremap <C-c><C-d> :SlimeSendCurrentLine<CR>

""" w0rp/ale
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_linter_aliases = {'octave': 'matlab',}
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '??'
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

""" vim-pandoc/vim-pandoc, vim-pandoc/vim-pandoc-syntax, vim-criticmarkup
" see settings in .vim/ftplugin/markdown.vim

""" Critic Markdown Plugin
" insert tags (comments and highlights)
nnoremap <leader>cc i{>>Gabe Nespoli: <<}<Esc>hhi
nnoremap <leader>chi i{==<Esc>
nnoremap <leader>cha a==}<Esc>
nnoremap <leader>chh I{==<Esc>A==}<Esc>
nnoremap <leader>chs )i==}<Esc>((i{==<Esc>
nnoremap <leader>chw ea==}<Esc>bbi{==<Esc>
" nnoremap <leader>cdh :call search('{==','cb',line('.'))<CR>d3l:call search('==}','c',line('.'))<CR>d3l

" remove tags (highlights, whole tags, accept/reject)
nnoremap <leader>chd F{xxxf}XXx
nnoremap <leader>cd F{df}
nnoremap <leader>ca :Critic accept<CR>
nnoremap <leader>cr :Critic reject<CR>

" search and highlight
nnoremap <leader>cf /{==\\|{>>\\|{++\\|{--<CR>
nnoremap <leader>cF ?{==\\|{>>\\|{++\\|{--<CR>
nnoremap <leader>cH :call criticmarkup#InjectHighlighting()<CR>

" cite.py (include here because of similar keybindings)
nnoremap <leader>cb :execute "!python $HOME/bin/cite/cite.py -b <C-r><C-w>"<CR>
nnoremap <leader>cN :execute "!python $HOME/bin/cite/cite.py -n <C-r><C-w>"<CR>
nnoremap <leader>cn :vs ~/papernotes/<C-r><C-w>.md<CR>
nnoremap <leader>co :silent execute "!python $HOME/bin/cite/cite.py <C-r><C-w>"<CR><C-l>
nnoremap <leader>cp :python $HOME/bin/cite/cite.py 

""" todo-txt.vim
" let g:Todo_txt_do_not_map = 1

""" Lilypond
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
"set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
filetype on

"" Functions
""" Toggles and showing info
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

function! ToggleStatusBar()
    if &laststatus == 2
        set laststatus=0
    elseif &laststatus == 0
        set laststatus=2
    endif
endfunction

function! GetSyntaxUnderCursor() 
    let g:SyntaxUnderCursor = synIDattr(synID(line("."),col("."),1),"name")
    return g:SyntaxUnderCursor
endfunction

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

function! SearchHighlightToggle()
    let bgcolor=synIDattr(hlID('Search'), 'bg#')
    if bgcolor == 1
        execute "hi Search ctermbg=12 ctermfg=8 cterm=none"
    elseif bgcolor == 12
        execute "hi Search ctermbg=0 ctermfg=none cterm=none"
    elseif bgcolor == 0
        execute "hi Search ctermbg=8 ctermfg=none cterm=none"
    elseif bgcolor == 8
        execute "hi Search ctermbg=1 ctermfg=15 cterm=none"
    endif
endfunction!

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

""" Tab names
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

""" tmux make cursor line when in insert mode
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

""" Mutt Mail Mode
" settings for proper formatting of emails function! ToggleMailMode()
function! MuttMailMode()
    "exe ':call CenWinToggle(80)'
    setlocal textwidth=0 wrapmargin=0 wrap linebreak 
    hi StatusLine ctermfg=8
    hi StatusLineNC ctermfg=8
    setlocal statusline=%*%#StatusFlag#%m%r%*
    set norelativenumber nonumber
    set spell
    set laststatus=2 showtabline=0
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
