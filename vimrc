" .vimrc file for gabenespoli@gmail.com
"" vim-plug plugin manager {{{1
call plug#begin('~/.vim/plugged')
""" vim {{{2
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'gcmt/taboo.vim'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'francoiscabrol/ranger.vim'
if has('nvim')
    Plug 'Shougo/neco-vim'
    Plug 'roxma/nvim-completion-manager'
" else
    " Plug 'roxma/vim-hug-neovim-rpc'
endif

""" sidebar-type plugins {{{2
Plug 'scrooloose/NERDTree'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'majutsushi/tagbar'
Plug 'jszakmeister/markdown2ctags'
Plug 'sjl/gundo.vim'

""" git {{{2
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

""" tmux & external programs {{{2
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'
" Plug 'ivanov/vim-ipython'

""" syntax checker & syntaxes {{{2
Plug 'w0rp/ale'
Plug 'tmux-plugins/vim-tmux'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-criticmarkup'
Plug 'jvirtanen/vim-octave'
Plug 'guanqun/vim-mutt-aliases-plugin'

""" my plugins {{{2
Plug '~/bin/vim/vim-capitalL'
Plug '~/bin/vim/vim-sidebar'
call plug#end()

"" General {{{1
""" Colorscheme {{{2
if has("gui_running")
    colorscheme solarizedSumach
    set guicursor=n-v-c-i:blinkon0
else
    colorscheme gaberized
endif
syntax enable
set background=dark

""" File stuff {{{2
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

""" Spaces & Tabs {{{2
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

""" UI Config {{{2
set number relativenumber
set showcmd                     " show command in bottom bar
set laststatus=2                " 0 = no status bar, 2 = show status bar
set showtabline=1               " 0 = no tabline, 1 = show if > 1 tab, 2 = always
set tabpagemax=8
set wildmenu                    " visual autocomplete for command menu
set wildmode=longest,list,full
set visualbell                  " no sound
set hidden
set splitright splitbelow
set incsearch                   " highlight search results as you type
set showmatch                   " hi matching [{()}]
let loaded_matchparen = 1       " don't match parentheses, use % instead
set noequalalways

" TODO make this foldheading highlighting work
" autocmd BufReadPost * :syntax match FoldHeading '^.*{{{.*$'
set fillchars="vert:|,fold:' '"
set foldminlines=0              " 0 means we can close a 1-line fold
set foldmethod=marker
set foldtext=GetFoldText()
function! GetFoldText()
    if &foldmethod == 'marker'
        set foldtext=FoldTextMarker()
    endif
endfunction

function! FoldTextMarker()
    let line = getline(v:foldstart)
    let line = substitute(line, '{{{\d\=', '', 'g')
    let cstr = substitute(&commentstring, '%s', '', 'g')
    let line = substitute(line, '^\s*'.cstr.'\+\s*', ' ', 'g')
    let lines = v:foldend-v:foldstart + 1
    let linesdigits = 4
    if strlen(lines) < linesdigits + 1
        let lines = repeat(' ', linesdigits-strlen(lines)) . lines
    endif
    let prefix = '+-' . repeat('-', &foldlevel)
    let offset = 24
    let midfix = repeat(' ', winwidth(0)-strlen(prefix . line)-offset)
    return prefix . line . midfix . ' ('. lines .' lines)'
endfunction

""" Status Line {{{2
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

""" neovim specific stuff
if has('nvim')
    autocmd BufWinEnter,WinEnter term://* startinsert
endif

"" Keybindings {{{1
""" General {{{2
let mapleader = "\<Space>"
set notimeout
set ttimeout
inoremap jk <Esc>

""" emacs-style command line (cmap) {{{2
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>b <S-Left>
cnoremap <C-d> <Del>
cnoremap <C-i> <C-d>

""" opening and saving {{{2
"<leader>o opens ctrlp plugin
nnoremap <leader>N :e <C-r>=expand('%:p:h')<CR><CR>
nnoremap <leader>T :tabnew<CR>:e <C-r>=expand('%:p:h')<CR><CR>
nnoremap <leader>s :w<CR>

""" tab switching {{{2
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>[ gT
nnoremap <leader>] gt

""" swap q/Q for <leader>q/Q, so q/Q can be used for quitting {{{2
nnoremap q :q<CR>
nnoremap Q :qa<CR>

""" status/info toggles {{{2
nmap <leader>W :echo WordCount()<CR>
nmap <leader>S :call ToggleStatusBar()<CR>
nmap <leader>F :call ToggleTabline()<CR>
nmap <leader>Y :echo GetSyntaxUnderCursor()<CR>

""" misc {{{2
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

""" resizing windows based on terminal size {{{2
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

"" Plugin settings {{{1
""" Vim General {{{2
"""" tpope/vim-unimpaired {{{3
nnoremap coN :set relativenumber!<CR>:set number!<CR>
nnoremap coH :call SearchHighlightToggle()<CR>

" folding
nnoremap cofl :set foldmethod=manual<CR>
nnoremap cofi :set foldmethod=indent<CR>
nnoremap cofe :set foldmethod=expr<CR>
nnoremap cofm :set foldmethod=marker<CR>
nnoremap cofs :set foldmethod=syntax<CR>
nnoremap cofd :set foldmethod=diff<CR>

" syntax
nnoremap coYm :set syntax=markdown<CR>
nnoremap coYp :set syntax=pandoc<CR>

"""" tpope/vim-commentary {{{3
autocmd FileType octave setlocal commentstring=%\ %s

"""" gcmt/taboo.vim {{{3
let g:taboo_tabline = 0

"""" fzf {{{3
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~25%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
let g:fzf_command_prefix = 'Fzf'
nnoremap <leader>p :call fzf#run({'source': 'find ~/Dropbox ~/dotfiles ~/local -type f', 'sink':  'edit'})<CR>

"""" ctrlp {{{3
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

"""" ranger {{{3
let g:ranger_map_keys = 0

"""" nvim-completion-manager
let g:cm_complete_start_delay = 750
inoremap <expr> <CR> (pumvisible() ? "\<C-y>\<CR>" : "\<CR>")
inoremap <expr> <Esc> (pumvisible() ? "\<CR>" : "\<Esc>")

""" Sidebar Plugins (files, buffers, tags, undo, lists) {{{2
"""" vim-sidebar {{{3
let g:SidebarStatusLine = '%#StatusLineFill#%=%*'
let g:SidebarTogglePrefix = '<leader>'
let g:SidebarMovePrefix = '<leader>m'
let g:SidebarEmptyPrefix = '<leader>e'
let g:SidebarEmptyStickyKey = 'e'
let g:SidebarToggleKeys = [
    \ ['capitalL',      'l'],
    \ ['nerdtree',      'n'],
    \ ['buffergator',   'b'],
    \ ['tagbar',        't'],
    \ ['gundo',         'u'],
    \ ]

"""" capitalL {{{3
let g:Lposition = 'right'
nnoremap <leader>L :Lcycle<CR>

"""" NERDTree {{{3
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeDirArrowExpandable='+'
let g:NERDTreeDirArrowCollapsible='-'
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeWinPos = 'left'
let g:NERDTreeBookmarksFile = '$HOME/bin/vim/NERDTreeBookmarks'
let g:NERDTreeMapToggleHidden = 'zh'
let g:NERDTreeMapPreview = 'i'
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapPreviewSplit = 'gs'
let g:NERDTreeMapPreviewVSplit = 'gv'
let g:NERDTreeMapJumpNextSibling = '<C-n>'
let g:NERDTreeMapJumpPrevSibling = '<C-p>'

"""" buffergator {{{3
let g:buffergator_viewport_split_policy = "B"
let g:buffergator_suppress_keymaps = 1
" nnoremap <leader>B :let g:buffergator_viewport_split_policy="N"<CR>:BuffergatorOpen<CR>:let g:buffergator_viewport_split_policy="T"<CR>

"""" tagbar{{{3
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

"""" markdown2ctags {{{3
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

"""" gundo {{{3
let g:gundo_right = 0
let g:gundo_preview_bottom = 1

""" git {{{2
"""" fugitive {{{3
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gwc :Gwrite<CR>:Gcommit<CR>

"""" gitgutter {{{3
nmap <leader>ghd <Plug>GitGutterPreviewHunk
nmap <leader>gha <Plug>GitGutterStageHunk
nmap <leader>ghu <Plug>GitGutterUndoHunk
nnoremap <leader>ghc :GitGutterStageHunk<CR>:Gcommit<CR>
nnoremap cog :GitGutterSignsToggle<CR>
let g:gitgutter_eager = 0
let g:gitgutter_override_sign_column_highlight = 0

""" tmux {{{2
"""" vim-tmux-navigator {{{3
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

"""" vim-slime {{{3
let g:slime_target = "tmux"
let g:slime_dont_ask_default = 1
nnoremap <C-c><C-d> :SlimeSendCurrentLine<CR>
if exists('$TMUX')
    let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.1"}
endif

""" syntax {{{2
"""" w0rp/ale {{{3
nnoremap coy :ALEToggle<CR>
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

"""" pandoc {{{3
" vim-pandoc
" see other settings in .vim/ftplugin/markdown.vim
let g:pandoc#modules#enabled = ["command", "bibliographies", "completion", "keyboard"]
let g:pandoc#keyboard#enabled_submodules = ["sections"]
let g:pandoc#biblio#sources = "g"
let g:pandoc#biblio#bibs = ["/Users/gmac/dotfiles/pandoc/library.bib", "/home/efgh/dotfiles/pandoc/library.bib"]
let g:pandoc#command#autoexec_on_writes = 0
let g:pandoc#command#autoexec_command = "Pandoc docx --reference-docx=~/dotfiles/pandoc/apa.docx"

" vim-pandoc-syntax
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#codeblocks#embeds#langs = ["vim", "bash=sh", "python", "matlab", "octave"]
let g:markdown_fenced_languages = g:pandoc#syntax#codeblocks#embeds#langs

"""" CriticMarkup Plugin {{{3
let g:criticmarkup#disable#highlighting = 1

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

"""" mutt-aliases integrate with nvim-completion-manager
" ncm's filtering is based on word, so it's better to convert results of
" muttaliases#CompleteMuttAliases into snippet expension
func! g:MuttOmniWrap(findstart, base)
     let ret = muttaliases#CompleteMuttAliases(a:findstart, a:base)
     if type(ret) == type([])
         let i=0
         while i<len(ret)
             let ret[i]['snippet'] = ret[i]['word']
             let ret[i]['word'] = ret[i]['abbr']
             let i+=1
         endwhile
     endif
     return ret
endfunc

au User CmSetup call cm#register_source({'name' : 'mutt',
            \ 'priority': 9, 
            \ 'cm_refresh_length': -1,
            \ 'cm_refresh_patterns': ['^\w+:\s+'],
            \ 'cm_refresh': {'omnifunc': 'g:MuttOmniWrap'},
            \ })
""" Lilypond {{{2
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
"set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
filetype on

"" Functions {{{1
""" Toggle Tabline {{{2
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

""" Toggle Status Bar {{{2
function! ToggleStatusBar()
    if &laststatus == 2
        set laststatus=0
    elseif &laststatus == 0
        set laststatus=2
    endif
endfunction

""" Get Syntax Under Cursor {{{2
function! GetSyntaxUnderCursor() 
    let g:SyntaxUnderCursor = synIDattr(synID(line("."),col("."),1),"name")
    return g:SyntaxUnderCursor
endfunction
""" Word Count {{{2
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

""" Toggle Search Highlight Colour {{{2
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

""" Toggle csv tsv {{{2
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

""" Line Return {{{2
" from Steve Losh's (sjl) vimrc
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

""" Tab names {{{2
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

""" tmux make cursor line when in insert mode {{{2
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

""" Mutt Mail Mode {{{2
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
