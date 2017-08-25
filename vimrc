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
Plugin 'vim-scripts/Rename'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
" Plugin 'rickhowe/diffchar.vim'
" Plugin 'kana/vim-submode'
Plugin 'gcmt/taboo.vim'
Plugin 'ervandew/supertab'
"Plugin 'Valloric/YouCompleteMe'

" files
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'scrooloose/NERDTree'
" Plugin 'miyakogi/sidepanel.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'majutsushi/tagbar'
Plugin 'sjl/gundo.vim'

" programs
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jpalardy/vim-slime'
"Plugin 'ivanov/vim-ipython'

" syntax
Plugin 'w0rp/ale'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-criticmarkup'
"Plugin 'vim-scripts/todo-txt.vim'
Plugin 'jvirtanen/vim-octave'
"Plugin 'hrother/offlineimaprc.vim'
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
"set digraph             " use <BS> for accents (e.g., e<BS>' for é; e<BS>! for è; o<BS>: for ö)

"" Folding
set foldenable          " turn on folding by default
set foldlevel=1         " set a high fold level so that folds are open by default
set foldminlines=0

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
" add word count for markdown files (on the far right)
augroup filetype_markdown
    autocmd FileType markdown set statusline=
    autocmd FileType markdown set statusline+=%{mode()}
    autocmd FileType markdown set statusline+=%#StatusMod#%m%*%#StatusFlag#%r%*\"%t\"\ %y
    autocmd FileType markdown set statusline+=%{fugitive#statusline()}
    autocmd FileType markdown set statusline+=%#StatusLineFill#%=%*                      
    autocmd FileType markdown set statusline+=%#ErrorMsg#%{LinterStatus('Errors')}%*
    autocmd FileType markdown set statusline+=%#WarningMsg#%{LinterStatus('Warnings')}%*
    autocmd FileType markdown set statusline+=%l/%L\,%c\ (%P)                           
    autocmd FileType markdown set statusline+=\ {%{WordCount()}}
augroup END

" tpope's statusline:
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%{SL('CapsLockStatusline')}%y%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P

"" Keybindings
let mapleader = "\<Space>"
set notimeout
set ttimeout
set timeoutlen=500
inoremap jk <Esc>

""" common actions
"<leader>o opens ctrlp plugin
"<leader>O opens ranger
" nnoremap <leader>n :tabnew<CR>
nnoremap <leader>N :tabnew %<CR>
nnoremap <leader>s :w<CR>
nnoremap q :q<CR>
nnoremap Q :qa<CR>
nnoremap <leader>q q
nnoremap <leader>Q Q

""" tabs, windows/panes, buffers
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>[ gT
nnoremap <leader>] gt
" call submode#enter_with('TABS', 'n', '', '<leader>[', ':tabprevious<CR>')
" call submode#enter_with('TABS', 'n', '', '<leader>]', ':tabnext<CR>') 
" call submode#map('TABS', 'n', '', '[', ':tabprevious<CR>') 
" call submode#map('TABS', 'n', '', ']', ':tabnext<CR>')
" call submode#leave_with('TABS', 'n', '', '<Esc>') 

""" resizing window widths based on terminal width
" this requires $COLS and $LINES environment vars which are set to `tput cols` and `tput lines`
let g:centerwidth = 100
let g:width = ($COLS - g:centerwidth) / 2
let g:height = $LINES / 4
au VimEnter,BufEnter * if !exists('g:width') | let g:width = ($COLS - g:centerwidth) / 2 | endif
au VimEnter,BufEnter * if !exists('g:height') | let g:height = $LINES / 4 | end
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

""" split with next or previous file
nnoremap <leader>H <C-w>v:bprevious<CR>
nnoremap <leader>J <C-w>s:bnext<CR>
nnoremap <leader>K <C-w>s:bprevious<CR>
nnoremap <leader>L <C-w>v:bnext<CR>

" copy/paste with system clipboard
" vnoremap <leader>y "+y
" nnoremap <leader>y V"+y
" nnoremap <leader>p "+p
nnoremap Y y$
" for tmux https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
set clipboard=unnamed

" nnoremap <leader>d :r! date "+\%Y-\%m-\%d \%H:\%M:\%S"<CR>
nnoremap <leader>d "=strftime("%Y-%m-%d")<CR>p
nnoremap <leader>D "=strftime("%Y-%m-%d %H:%M:%S")<CR>p

"vimdiff
nnoremap du :diffupdate<CR>

" emacs movement
"nnoremap <C-h> X " this one seems to already work, no need to remap
inoremap <C-d> <Del>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" Spell checking
nnoremap <localleader>s 1z=

"" Plugin settings
""" gabenespoli/capitalL.vim
" nnoremap <localleader>l :Ltoggle<CR>
" nnoremap <localleader>q :Ctoggle<CR>
" nnoremap <localleader>r :Lrefresh<CR>
" let g:CapitalL_qf_position = "right"
" let g:CapitalL_qf_width = 40
" nnoremap <leader>e :call CenwinToggle()<CR>

""" vim-scripts/YankRing.vim
"let g:yankring_history_dir = '$HOME/.vim'
"let g:yankring_replace_n_pkey = '<leader>p'
"let g:yankring_replace_n_nkey = '<leader>P'

""" tpope/vim-commentary
autocmd FileType octave setlocal commentstring=%\ %s

""" tpope/vim-unimpaired
" my own macro binding of the default ones
nnoremap coN :set relativenumber!<CR>:set number!<CR>
nnoremap coH :call SearchHighlightToggle()<CR>
nnoremap <C-n> :lnext<CR>zt
nnoremap <C-p> :lprevious<CR>zt

function! SearchHighlightToggle()
    let bgcolor=synIDattr(hlID('Search'), 'bg#')
    if bgcolor == 1
        execute "hi Search ctermbg=0 ctermfg=none cterm=none"
    elseif bgcolor == 0
        execute "hi Search ctermbg=8 ctermfg=none cterm=none"
    elseif bgcolor == 12
        execute "hi Search ctermbg=1 ctermfg=15 cterm=none"
    endif
endfunction!

""" tpope/vim-repeat
silent! call repeat#set("\<Plug>unimpairedANext", v:count)
silent! call repeat#set("\<Plug>unimpairedAPrevious", v:count)
silent! call repeat#set("\<Plug>unimpairedBNext", v:count)
silent! call repeat#set("\<Plug>unimpairedBPrevious", v:count)
silent! call repeat#set("\<Plug>unimpairedLNext", v:count)
silent! call repeat#set("\<Plug>unimpairedLPrevious", v:count)
silent! call repeat#set("\<Plug>unimpairedQNext", v:count)
silent! call repeat#set("\<Plug>unimpairedQPrevious", v:count)
silent! call repeat#set("\<Plug>unimpairedTNext", v:count)
silent! call repeat#set("\<Plug>unimpairedTPrevious", v:count)
silent! call repeat#set("\<Plug>unimpairedMoveDown", v:count)
silent! call repeat#set("\<Plug>unimpairedMoveUp", v:count)
silent! call repeat#set("\<Plug>unimpairedDirectoryNext", v:count)
silent! call repeat#set("\<Plug>unimpairedDirectoryPrevious", v:count)
silent! call repeat#set("\<Plug>unimpairedContextNext", v:count)
silent! call repeat#set("\<Plug>unimpairedContextPrevious", v:count)

silent! call repeat#set("\<Plug>GitGutterNextHunk", v:count)
silent! call repeat#set("\<Plug>GitGutterPreviousHunk", v:count)

""" Git (tpope/vim-fugitive & airblade/vim-gitgutter)
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

""" diffchar
" I've commented out the keymaps in plugin/diffchar.vim

""" submode
" let g:submode_timeout = 0
" let g:submode_tiemoutlen = 1500
" let g:submode_keep_leaving_key = 1

""" taboo.vim
let g:taboo_tabline = 0
"let g:taboo_tab_format = ' %f%m '
"let g:taboo_renamed_tab_format = ' [%l]%m'

""" supertab
let g:SuperTabMappingForward = '<S-Tab>'

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
let g:ranger_map_keys = 0
nnoremap <leader>O :RangerNewTab<CR>

""" NERDTree
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

""" gundo
let g:gundo_right = 0
let g:gundo_width = g:width
let g:gundo_preview_height = 15

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
function! GetSyntaxUnderCursor() 
    let g:SyntaxUnderCursor = synIDattr(synID(line("."),col("."),1),"name")
    return g:SyntaxUnderCursor
endfunction
nnoremap <leader>x :echo GetSyntaxUnderCursor()<CR>

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
nnoremap <leader>S :call ToggleStatusBar()<CR>

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

" from tpope's vimrc
" make sure a function exists before trying to put it in the statusline
function! SL(function)
  if exists('*'.a:function)
    return call(a:function,[])
  else
    return ''
  endif
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

function! Cmd_Shell(...)
" https://github.com/vim-scripts/cmd.vim
	let Cmd_Cmd = ''
	for s in a:000
		let Cmd_Cmd .= s . ' '
	endfor
	echo Cmd_Cmd
	let Cmd_Output = system(Cmd_Cmd)
	"let Cmd_Output = iconv(Cmd_Output, "utf8", "cp936")
	echo Cmd_Output
endfunction
command! -nargs=* -range=0 -complete=file Cmd call Cmd_Shell(<q-args>)

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

""" Sidebar Toggles
" nerdtree, buffergator, tagbar, gundo, loclist, (qf list)
" TODO choose left or right for each; only close if is same side
" TODO blank

nmap <leader>f :call SidebarToggle('nerdtree')<CR>
nmap <leader>b :call SidebarToggle('buffergator')<CR>
nmap <leader>t :call SidebarToggle('tagbar')<CR>
nmap <leader>u :call SidebarToggle('gundo')<CR>

function! SidebarToggle(name)
    if !exists('g:sidebar') || empty(g:sidebar)
        execute "call SidebarOpen('".a:name."')"
    elseif g:sidebar != a:name
        execute "call SidebarClose('".g:sidebar."')"
        execute "call SidebarOpen('".a:name."')"
    elseif g:sidebar == a:name
        execute "call SidebarClose('".a:name."')"
    endif
endfunction

function! SidebarOpen(name)
    if a:name == 'nerdtree'
        let dir = expand('%:p:h')
        execute 'NERDTree '.dir
        let g:sidebar = 'nerdtree'
    elseif a:name == 'buffergator'
        execute 'BuffergatorOpen'
        let g:sidebar = 'buffergator'
    elseif a:name == 'tagbar'
        execute 'TagbarOpen'
        let g:sidebar = 'tagbar'
    elseif a:name == 'gundo'
        execute 'GundoToggle'
        let g:sidebar = 'gundo'
    endif
endfunction

function! SidebarClose(name)
    if a:name == 'nerdtree'
        execute 'NERDTreeClose'
    elseif a:name == 'buffergator'
        execute 'BuffergatorClose'
    elseif a:name == 'tagbar'
        execute 'TagbarClose'
    elseif a:name == 'gundo'
        execute 'GundoToggle'
    endif
    let g:sidebar = ''
    if exists('g:Lbufnr')
        execute 'call Lresize()'
    endif
endfunction

function! ResetWindowSizes()
    let current_bufwinnr = bufwinnr('%')
    if exists('g:sidebar') && !empty(g:sidebar)
        execute 'SidePanelWidth(g:width)'
    endif
    if exists('g:Lbufnr') && g:Lbufnr > 0
        execute 'call Lresize()'
    endif
    execute current_bufwinnr . ' wincmd w'
endfunction
