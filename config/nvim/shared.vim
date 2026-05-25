" Author: Gabe Nespoli
" Email: gabenespoli@gmail.com
" File: shared.vim - settings shared between nvim (init.lua) and macvim (.vimrc)
set encoding=utf-8
scriptencoding utf-8

" General  {{{1
if has('mac') | set fileformats=unix,dos | endif
set updatetime=300
set hidden laststatus=2
set nomodeline
set cursorline
set splitright splitbelow
set nowrap linebreak breakindent whichwrap+=h,l
set expandtab tabstop=2 softtabstop=2 shiftwidth=2
set showmatch ignorecase smartcase nohlsearch
set formatoptions-=t
set foldlevel=99
set foldmethod=marker
set foldtext=getline(v:foldstart)
let g:vimsyn_folding='af'
set wildignorecase
set completeopt=menuone
set shortmess+=c
set diffopt+=context:3
set suffixesadd+=.m,.r,.R,.py
set clipboard=unnamed
set guicursor=n-v-sm:block-blinkon0,i-ci-c:ver25-blinkon0,r-cr-o:hor20-blinkon0

" Colors
set notermguicolors
colorscheme snooker

" Autocommands  {{{1
augroup general
  autocmd!

  " open help in a vertical split
  autocmd FileType help wincmd L
  autocmd BufNew fugitive.txt wincmd L

  " open qf window after qf search
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow

  " line return (https://hg.stevelosh.com/dotfiles/file/tip/vim/vimrc)
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif

  " set cursor shape to beam on exit
  autocmd VimLeave * set guicursor=a:ver25-blinkon0

augroup END

" Keybindings  {{{1
set notimeout ttimeout
let maplocalleader = "\<Space>"
nnoremap <Space><Esc> <nop>
inoremap jk <Esc>
nmap <C-j> <CR>
nnoremap <C-w><CR> <C-w>j
nnoremap Y y$
nnoremap ! :!
nnoremap <silent> <M-s> :silent w<CR>
inoremap <silent> <M-s> <C-o>:silent w<CR>

" adjust command line up/down
cnoremap <expr> <C-p> pumvisible() ? "\<C-p>" : "\<up>"
cnoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<down>"

" q to quit, C-q for macros, q macro: <C-q>q to record, Q to replay
nnoremap q <C-w>q
nnoremap <C-q> q
nnoremap Q @q

" select last paste selection
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" popup menu: esc to exit, enter to select
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" resize windows
nnoremap + <C-w>+
nnoremap _ <C-w>>

" open current file in new tab (uses the x mark)
nnoremap <C-w><C-t> mx:tabnew %<CR>`x

" open file/tag under cursor in vertical split
nnoremap <C-w><C-f> <C-w><C-v>gf
nnoremap <C-w><C-]> <C-w><C-v><C-]>zt

" change pwd to that of current file or git repo
nnoremap <expr> cd exists(":Gcd") == 2 ? ':Gcd<CR>:pwd<CR>' : ':cd %:p:h<CR>:pwd<CR>'

" fix spelling with first suggestion
nnoremap <leader>s 1z=

" zz but 3/4 ish instead of half
nnoremap z<Space> zz25<C-e>
vnoremap z<Space> zz25<C-e>

" open with mac system
if has('mac')
  nnoremap <silent> <buffer> gx :execute "!open " . shellescape("<C-r><C-l>")<CR><CR>
endif

" search for conflict markers
nnoremap <silent> cx /^<<<<<<< .*$\\|^=======\\|^\|\|\|\|\|\|\|\\|^>>>>>>> .*$<CR>:set hlsearch<CR>

" open ~/notes/todo.txt
nnoremap <C-k><C-t> :e ~/notes/todo.txt<CR>
" open ~/notes/YYYYQX.txt to archive todos based on current quarter
nnoremap <C-k><C-a> :e ~/notes/<C-R>=system('echo $(/bin/date +%YQ)$(($(/bin/date +%m)/4+1))')<CR><BS>.txt<CR>
" open ~/notes/YYYY-mm-dd.txt
nnoremap <C-k><C-n> :e ~/notes/<C-R>=strftime("%Y-%m-%d")<CR>.txt<CR>

" quickfix & location list {{{2
" add last search to location list
nnoremap z/ :lvimgrep // %<CR>:botright lopen<CR>

" toggle with leader q/l
nnoremap <silent> <expr> <leader>q
      \ empty(filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')) ?
      \ ':botright copen<CR>' : ':cclose<CR>'
nmap <silent> dq <leader>q
nnoremap <silent> <expr> <leader>l
      \ empty(filter(getwininfo(), 'v:val.quickfix && v:val.loclist')) ?
      \ ':botright lopen<CR>' : ':lclose<CR>'

" map down and up to c/lnext and c/lprevious
nnoremap <silent> <expr> <down>
      \ empty(filter(getwininfo(), 'v:val.loclist')) ?
      \ ':cnext<CR>' : ':lnext<CR>'
nnoremap <silent> <expr> <up>
      \ empty(filter(getwininfo(), 'v:val.loclist')) ?
      \ ':cprevious<CR>' : ':lprevious<CR>'

" vim diff view mappings
nnoremap <C-k>D :windo diffthis<CR>zR
nnoremap <expr> <Left><Left> &diff ? ':diffput<CR>' : '<Left><Left>'
nnoremap <expr> <Right><Right> &diff ? ':diffput<CR>' : '<Right><Right>'
nnoremap <expr> <Left><Right> &diff ? ':diffget<CR>' : '<Left><Right>'
nnoremap <expr> <Right><Left> &diff ? ':diffget<CR>' : '<Right><Left>'
vnoremap <expr> <Left><Left> &diff ? ':diffput<CR>' : '<Left><Left>'
vnoremap <expr> <Right><Right> &diff ? ':diffput<CR>' : '<Right><Right>'
vnoremap <expr> <Left><Right> &diff ? ':diffget<CR>' : '<Left><Right>'
vnoremap <expr> <Right><Left> &diff ? ':diffget<CR>' : '<Right><Left>'

" option mappings (co)  {{{2
nnoremap coc :set cursorline!<CR>
nnoremap cof :set foldcolumn=<C-R>=&foldcolumn ? 0 : 2<CR><CR>
nnoremap coh :set hlsearch!<CR>
nnoremap con :set number!<CR>
nnoremap cor :set relativenumber!<CR>
nnoremap cos :set spell!<CR>
nnoremap <expr> cot
      \ &softtabstop==2 ?
      \ ':set tabstop=4 softtabstop=4 shiftwidth=4<CR>:echo 4<CR>' :
      \ ':set tabstop=2 softtabstop=2 shiftwidth=2<CR>:echo 2<CR>'
nnoremap cou :set cursorcolumn!<CR>
nnoremap cow :set colorcolumn=<C-R>=&colorcolumn ? 0 : &textwidth<CR><CR>
nnoremap coS :set laststatus=<C-R>=&laststatus ? 0 : 2<CR><CR>
nnoremap coT :set showtabline=<C-R>=&showtabline==2 ? 1 : 2<CR><CR>
nnoremap coW :set wrap!<CR>
nnoremap coX set winfixwidth!<CR>

" move lines up and down (modified from tpope/vim-unimpaired)  {{{2
function! s:ExecMove(cmd) abort
  normal! m`
  silent! exe a:cmd
  norm! ``
endfunction

function! s:Move(cmd, count, map) abort
  call s:ExecMove('move'.a:cmd.a:count)
  silent! call repeat#set("\<Plug>unimpairedMove".a:map, a:count)
endfunction

function! s:MoveSelectionUp(count) abort
  call s:ExecMove("'<,'>move'<--".a:count)
  silent! call repeat#set("\<Plug>unimpairedMoveSelectionUp", a:count)
endfunction

function! s:MoveSelectionDown(count) abort
  call s:ExecMove("'<,'>move'>+".a:count)
  silent! call repeat#set("\<Plug>unimpairedMoveSelectionDown", a:count)
endfunction

nnoremap <silent> [e :<C-U>call <SID>Move('--',v:count1,'Up')<CR>
nnoremap <silent> ]e :<C-U>call <SID>Move('+',v:count1,'Down')<CR>
xnoremap <silent> [e :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
xnoremap <silent> ]e :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>

" visual star (asterisk) search  {{{2
function! VisualStarSearchSet(cmdtype,...)
  let temp = @"
  normal! gvy
  if !a:0 || a:1 != 'raw'
    let @" = escape(@", a:cmdtype.'\*')
  endif
  let @/ = substitute(@", '\n', '\\n', 'g')
  let @/ = substitute(@/, '\[', '\\[', 'g')
  let @/ = substitute(@/, '\~', '\\~', 'g')
  let @/ = substitute(@/, '\.', '\\.', 'g')
  let @" = temp
endfunction
xnoremap * :<C-u>call VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>

" use tab for omni completion  {{{2
function! TabOmniCompletion()
  let col = col('.') - 1
  if pumvisible()
    return "\<C-n>"
  elseif !col || getline('.')[col - 1]  =~ '\s'
    " if cursor is at bol or in front of whitespace
    return "\<Tab>"
  else
    return "\<C-x>\<C-o>"
  endif
endfunction
inoremap <Tab> <C-r>=TabOmniCompletion()<CR>

" Plugin Settings  {{{1
" tpope/vim-markdown (built-in)  {{{2
let g:markdown_fenced_languages = ['bash=sh', 'matlab', 'python', 'vim', 'r']
let g:markdown_folding = 1

" machakann/vim-sandwich  {{{2
runtime macros/sandwich/keymap/surround.vim
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%' ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" tpope/vim-fugitive  {{{2
nnoremap git :Git
nnoremap gs :let g:fugitive_last_bufnr = bufnr()<CR>:Gedit :<CR>:let w:fugitive_last_bufnr = g:fugitive_last_bufnr<CR>
nnoremap gZ :Gdiffsplit<CR>zR
nnoremap gC :Git commit<CR>
nnoremap gB :Git blame<CR>
nnoremap <C-k>G :Ggrep!<Space>
nnoremap co<Space> :Git checkout<Space>

" rbong/vim_flog  {{{2
let g:flog_default_opts = {'date': 'short'}
nmap gl :Flog<CR>

" justinmk/vim-dirvish  {{{2
let g:dirvish_mode = ':sort ,^.*[\/],'
if has('mac')
  let g:loaded_netrwPlugin = 1
  nnoremap gx :execute '!open ' . shellescape(expand('<cfile>'), 1)<CR><CR>
endif

" brianhuster/dirvish-git.nvim  {{{2
let g:dirvish_git_icons = {
    \ 'modified': '-M ',
    \ 'staged': '-S ',
    \ 'renamed': '-R ',
    \ 'unmerged': '-X ',
    \ 'ignored': '-I ',
    \ 'untracked': '-N ',
    \ 'file': '-- ',
    \ 'directory': '-- ',
    \ }

" christoomey/vim-tmux-navigator  {{{2
let g:tmux_navigator_no_mappings = 1

" jpalardy/vim-slime  {{{2
let g:slime_no_mappings = 1
xmap <C-l>      <Plug>SlimeRegionSend
nmap <C-l>      <Plug>SlimeMotionSend
nmap <C-l><C-l> <Plug>SlimeLineSend
nmap <C-l><CR>  <C-l>ip}j
nmap <C-l><C-j> <C-l><CR>
nmap <C-l><C-]> <C-l><CR>
nmap <C-l><C-k> <C-l>ip
nmap <C-l><C-n> }j
let g:slime_target = 'tmux'
let g:slime_dont_ask_default = 1
if exists('$TMUX')
  let g:slime_default_config = {'socket_name': split($TMUX, ',')[0], 'target_pane': ':.2'}
endif
nnoremap g<C-l> <C-l>

" gabenespoli/vim-mutton  {{{2
let g:mutton_min_center_width = 94
let g:mutton_min_side_width = 25

" gabenespoli/vim-tabsms  {{{2
highlight! link TabMod WarningMsg
highlight! link TabModSel TabMod

" gabenespoli/vim-jupycent  {{{2
let g:jupycent_command = expand('~').'/.pyenv/versions/neovim/bin/jupytext'

" jeetsukumaran/vim-pythonsense  {{{2
let g:is_pythonsense_suppress_object_keymaps = 1
augroup pythonsense
  autocmd!
  autocmd FileType python vmap <buffer> aC <Plug>(PythonsenseOuterClassTextObject)
  autocmd FileType python omap <buffer> aC <Plug>(PythonsenseOuterClassTextObject)
  autocmd FileType python sunmap <buffer> aC
  autocmd FileType python vmap <buffer> iC <Plug>(PythonsenseInnerClassTextObject)
  autocmd FileType python omap <buffer> iC <Plug>(PythonsenseInnerClassTextObject)
  autocmd FileType python sunmap <buffer> iC
  autocmd FileType python vmap <buffer> am <Plug>(PythonsenseOuterFunctionTextObject)
  autocmd FileType python omap <buffer> am <Plug>(PythonsenseOuterFunctionTextObject)
  autocmd FileType python sunmap <buffer> am
  autocmd FileType python vmap <buffer> im <Plug>(PythonsenseInnerFunctionTextObject)
  autocmd FileType python omap <buffer> im <Plug>(PythonsenseInnerFunctionTextObject)
  autocmd FileType python sunmap <buffer> im
  autocmd FileType python omap <buffer> ad <Plug>(PythonsenseOuterDocStringTextObject)
  autocmd FileType python vmap <buffer> ad <Plug>(PythonsenseOuterDocStringTextObject)
  autocmd FileType python sunmap <buffer> ad
  autocmd FileType python omap <buffer> id <Plug>(PythonsenseInnerDocStringTextObject)
  autocmd FileType python vmap <buffer> id <Plug>(PythonsenseInnerDocStringTextObject)
  autocmd FileType python sunmap <buffer> id
augroup END

" psf/black and fisadev/vim-isort  {{{2
let g:vim_isort_config_overrides = {
  \ 'line_length': 88,
  \ 'use_parentheses': 0,
  \ 'force_single_line': 1
  \ }
let g:vim_isort_map = ''
augroup pythonformat
  autocmd!
  autocmd FileType python nmap <buffer> gqq :Isort<CR>:Black<CR>
augroup END

" vim:foldmethod=marker
