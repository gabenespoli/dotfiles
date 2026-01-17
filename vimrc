" Author: Gabe Nespoli
" Email: gabenespoli@gmail.com
" File: init.vim/vimrc
set encoding=utf-8
scriptencoding utf-8

" Plugins  {{{1
" Install vim-plugged if it isn't already
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Helper function to conditionally load plugins
" https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin()

" Editing
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dotenv'
Plug 'machakann/vim-sandwich'
Plug 'github/copilot.vim'
Plug 'neovim/nvim-lspconfig', Cond(has('nvim'))
Plug 'nvim-treesitter/nvim-treesitter', Cond(has('nvim'), {'do': ':TSUpdate'})

" Git & Files
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'justinmk/vim-dirvish'
Plug 'brianhuster/dirvish-git.nvim'
Plug 'lewis6991/gitsigns.nvim', Cond(has('nvim'))
Plug 'kyazdani42/nvim-web-devicons', Cond(has('nvim'))
Plug 'ibhagwan/fzf-lua', Cond(has('nvim'))
Plug 'junegunn/fzf', Cond(!has('nvim'))
Plug 'junegunn/fzf.vim', Cond(!has('nvim'))

" Python
Plug 'Vimjas/vim-python-pep8-indent', {'for': ['python']}
Plug 'kalekundert/vim-coiled-snake', {'for': ['python']}
Plug 'gabenespoli/vim-pythonsense', {'for': ['python']}
Plug 'psf/black', {'for': ['python']}
Plug 'fisadev/vim-isort', {'for': ['python']}

" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'

" My Plugins
Plug 'gabenespoli/vim-mutton'
Plug 'gabenespoli/vim-tabsms'
Plug 'gabenespoli/vim-jupycent'

call plug#end()

" General  {{{1
if has('mac') | set fileformats=unix,dos | endif
set updatetime=300
if has('nvim')
  set undofile
  set undodir=~/.config/nvim/undo/
  set backupdir=~/.config/nvim/backup/
  set directory=~/.config/nvim/swap/
endif
if isdirectory(expand('~').'/.pyenv/versions/neovim')
  let g:python3_host_prog = expand('~').'/.pyenv/versions/neovim/bin/python'
elseif isdirectory(expand('~').'/.pyenv/neovim3')
  let g:python3_host_prog = expand('~').'/.pyenv/neovim3/bin/python'
endif
set hidden laststatus=2
if has('gui')
  set nonumber
  set mouse=a
else
  set number
  set mouse=
endif
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
if !exists('g:gui_vimr')
  set guifont=MonoLisaWSLiga\ Nerd\ Font:h13,DankMono\ Nerd\ Font:h13,BlexMono\ Nerd\ Font:h13,IBMPlexMono:h13,Menlo:h13,Consolas:h13,Courier:h13
endif

" Colors
set background=dark
if has('nvim') && exists('$TMUX') | set termguicolors | endif
colorscheme snooker

" Some autocommands
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

  " set cursor shape to beam on exit (https://github.com/alacritty/alacritty/issues/2839)
  autocmd VimLeave * set guicursor=a:ver25-blinkon0

augroup END

" Statusline  {{{1
set statusline=
set statusline+=%#PmenuSel#%h%w%*
set statusline+=%#PmenuSel#%w%*
set statusline+=%#WarningMsg#%m%*
set statusline+=%#ErrorMsg#%r%*
set statusline+=%#StatusGit#%{GitStatusline()}%*%{GitStatuslineEnd()}
set statusline+=\ %#StatusFilename#%{Devicon()}%f%*\ %<
set statusline+=%#StatusPywhere#%{PywhereStatusline()}%*%{PywhereStatuslineEnd()}
set statusline+=%=
set statusline+=\ \ %{GetFiletype()}
set statusline+=\ \ %P
set statusline+=\ \ %l%L:%c
set statusline+=\ 

" Statusline git functions  {{{2
function! GetFiletype() abort
  return &filetype
endfunction

function! GitStatusline() abort
  let l:branch = FugitiveHead(12)
  if l:branch == ''
    return ''
  else
    return '  ' . l:branch . ' '
  endif
endfunction

function! GitStatuslineEnd() abort
  let l:branch = FugitiveHead(12)
  if l:branch == ''
    return ''
  else
    return ''
  endif
endfunction
"}}}

" Statusline devicon fucnctions  {{{2
function! Devicon() abort
  if !has('nvim')
    return ''
  endif
  let l:icon = execute('lua print(require("nvim-web-devicons").get_icon('
        \ . '"' . expand('%:t') . '", "' . expand('%:e') . '"))')
  if l:icon[1:3] == ''
    return ''
  else
    return l:icon[1:3] . ' '
  endif
endfunction
"}}}

" Statusline python functions  {{{2
" Copy of pythonsense#echo_python_location() that returns the result
" instead of echoing it
function! s:pythonsense_get_python_location()
    let indent_char = pythonsense#get_indent_char()
    let pyloc = []
    let current_line = line('.')
    let obj_pattern = '\(class\|def\|async def\)'
    while current_line > 0
        if getline(current_line) !~ '^\s*$'
            break
        endif
        let current_line = current_line - 1
    endwhile
    if current_line == 0
        return
    endif
    let target_line_indent = pythonsense#get_line_indent_count(current_line)
    if target_line_indent < 0
        break
    endif
    let previous_line = current_line
    while current_line > 0
        let pattern = '^' . indent_char . '\{0,' . target_line_indent . '}' . obj_pattern
        let current_line_text = getline(current_line)
        if current_line_text =~# pattern
            let obj_name = matchstr(current_line_text, '^\s*\(class\|def\|async def\)\s\+\zs\k\+')
            if get(g:, "pythonsense_extended_location_info", 1)
                let obj_type = matchstr(current_line_text, '^\s*\zs\(class\|def\|async def\)')
                call add(pyloc, "(" . obj_type . ":)" . obj_name)
            else
                call add(pyloc, obj_name)
            endif
            let target_line_indent = pythonsense#get_line_indent_count(current_line) - 1
        endif
        if target_line_indent < 0
            break
        endif
        let previous_line = current_line
        let current_line = current_line - 1
    endwhile
    if get(g:, "pythonsense_extended_location_info", 1)
        let joiner = " > "
    else
        let joiner = "."
    endif
    return join(reverse(pyloc), joiner)
endfunction

function! PywhereStatusline() abort
  if &filetype != 'python'
    return ''
  endif
  let l:loc = s:pythonsense_get_python_location()
  if l:loc == ''
    return ''
  else
    let l:loc = substitute(l:loc, '(def:)', ' ', '')
    let l:loc = substitute(l:loc, '(class:)', ' ', '')
    return ' ' . l:loc . '() '
  endif
endfunction

function! PywhereStatuslineEnd() abort
  if &filetype != 'python'
    return ''
  endif
  let l:loc = s:pythonsense_get_python_location()
  if l:loc == ''
    return ''
  else
    return ''
  endif
endfunction
"}}}

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

" echo syntax under cursor
nnoremap <expr> zS 
      \ has('nvim') ? 
      \ ':Inspect<CR>' :
      \ ':echo synIDattr(synID(line("."),col("."),1),"name")<CR>'

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
" lnext/lprevious if location list is open, else cnext/cprevious
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
" https://github.com/bronson/vim-visual-star-search/blob/master/plugin/visual-star-search.vim
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

" neovim/nvim-lspconfig  {{{2
if has('nvim')
lua << EOF
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#completion-kinds
require('vim.lsp.protocol').CompletionItemKind = {
  ' Class',
  ' Color',
  ' Constant',
  ' Constructor',
  ' Enum',
  ' EnumMember',
  '󰄶 Field',
  ' File',
  ' Folder',
  ' Function',
  '󰜰 Interface',
  '󰌆 Keyword',
  'ƒ Method',
  '󰏗 Module',
  ' Property',
  '󰘍 Snippet',
  ' Struct',
  ' Text',
  ' Unit',
  '󰎠 Value',
  ' Variable',
}

-- Setup lsp diagnostics
vim.diagnostic.config {
  underline=false,
  virtual_text=false,
  severity_sort=true,
  float={border="rounded"},
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  }
}

-- Setup language servers
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {border="rounded"})
  vim.lsp.handlers['textDocument/signature_help'] = vim.lsp.with(vim.lsp.handlers.signature_help, {border="rounded"})
end

vim.lsp.config.efm = {on_attach=on_attach}
vim.lsp.config.sqlls = {
    on_attach=function(client, bufnr)
        require('sqlls').on_attach(client, bufnr)
    end,
}
vim.lsp.config.terraformls = {on_attach=on_attach}
vim.lsp.config.pyright = {
  on_attach=on_attach,
  --flags={debounce_text_changes = 150},
  settings={
    python={analysis={typeCheckingMode = 'off'}}
  },
}
EOF

nmap gd :lua vim.lsp.buf.definition()<CR>
nmap gr :lua vim.lsp.buf.references()<CR>
nmap K :lua vim.lsp.buf.hover()<CR>
nmap <silent> [d :lua vim.diagnostic.goto_prev()<CR>
nmap <silent> ]d :lua vim.diagnostic.goto_next()<CR>
nmap <C-k>d :lua vim.diagnostic.setloclist()<CR>
nmap <C-k>r :lua vim.lsp.buf.rename()<CR>

nmap cod :lua vim.diagnostic.disable()<CR>
nmap coD :lua vim.diagnostic.enable()<CR>

augroup nvimlsp
  autocmd!
  autocmd FileType python nmap <buffer> <C-w><C-d> <C-w><C-v>gdzt
  autocmd FileType python nmap <buffer> <C-]> gdzt
augroup END

endif

" nvim-treesitter  {{{2
if has('nvim')
augroup treesitter
  autocmd!
  autocmd FileType python :lua vim.treesitter.start()
  autocmd FileType vim :lua vim.treesitter.start()
  autocmd FileType sql :lua vim.treesitter.start()
  autocmd FileType zsh :lua vim.treesitter.start()
  autocmd FileType bash :lua vim.treesitter.start()
  autocmd FileType yaml :lua vim.treesitter.start()
  autocmd FileType html :lua vim.treesitter.start()
  autocmd FileType gitconfig :lua vim.treesitter.start()
  autocmd FileType json :lua vim.treesitter.start()
augroup END
endif

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

" lewis6991/gitsigns.nvim  {{{2
if has('nvim')
lua << EOF
require('gitsigns').setup{
  signs_staged_enable = true,
  signs = {
    add          = {text = '┃'},
    change       = {text = '┃'},
    delete       = {text = '_'},
    topdelete    = {text = '‾'},
    changedelete = {text = '┃'},
  },
  signs_staged = {
    add          = {  text = '┋ '},
    change       = {  text = '┋ '},
    delete       = {  text = '﹍'},
    topdelete    = {  text = '﹉'},
    changedelete = {  text = '┋ '},
  },
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('v', 'ga', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', 'ghu', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)

  end
}
EOF

nmap ga :Gitsigns stage_hunk<CR>
nmap ghu :Gitsigns reset_hunk<CR>
" vmaps for stage/reset defined above in lua
nmap cogg :Gitsigns toggle_signs<CR>
nmap cogl :Gitsigns toggle_linehl<CR>
nmap cogn :Gitsigns toggle_numhl<CR>
nmap ghu :Gitsigns reset_hunk<CR>
vmap ac :<C-U>Gitsigns select_hunk<CR>
omap ac :<C-U>Gitsigns select_hunk<CR>
nmap dac :<C-U>Gitsigns select_hunk<CR>d
nmap cac :<C-U>Gitsigns select_hunk<CR>c

endif

" kyazdani42/nvim-web-devicons  {{{2
if has('nvim')
lua << EOF
require('nvim-web-devicons').setup{
 override_by_extension = {
  ["txt"] = {
    icon = "󰈙",
    color = "#89e051",
    cterm_color = "113",
    name = "Txt"
  }
 };
}
EOF
endif

" ibhagwan/fzf-lua & junegunn/fzf.vim  {{{2
if has('nvim')
lua << EOF
local actions = require('fzf-lua.actions')
require 'fzf-lua'.setup{
  actions = {
    files = {
      -- instead of the default action 'actions.file_edit_or_qf'
      -- it's important to define all other actions here as this
      -- table does not get merged with the global defaults
      ["default"]       = actions.file_edit,
      ["ctrl-s"]        = actions.file_split,
      ["ctrl-v"]        = actions.file_vsplit,
      ["ctrl-t"]        = actions.file_tabedit,
      ["ctrl-q"]        = actions.file_sel_to_qf,
    },
  },
}
EOF

nmap <C-p>        :FzfLua git_files<CR>
nmap <C-k><C-b>   :FzfLua buffers<CR>
nmap <C-k><C-d>   :FzfLua lsp_document_diagnostics<CR>
nmap <C-k><C-g>   :FzfLua live_grep<CR>
nmap <C-k><C-f>   :FzfLua files<CR>
nmap <C-k><C-k>   :FzfLua resume<CR>
nmap <C-k><C-l>   :FzfLua git_commits<CR>
nmap <C-k><C-o>   :FzfLua oldfiles<CR>
nmap <C-k><C-r>   :FzfLua registers<CR>
nmap <C-k><C-s>   :FzfLua git_status<CR>
nmap <C-k><Space> :FzfLua<Space>
nmap <C-k>gr      :FzfLua lsp_references<CR>
else
nmap <C-p>        :GFiles<CR>
nmap <C-k><C-b>   :Buffers<CR>
nmap <C-k><C-g>   :Rg<CR>
nmap <C-k><C-f>   :Files<CR>
nmap <C-k><C-l>   :Commits<CR>
nmap <C-k><C-o>   :History<CR>
nmap <C-k><C-s>   :GFiles?<CR>
endif

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

" christoomey/vim-tmux-navigator  {{{2
let g:tmux_navigator_no_mappings = 1

if !has('nvim')
  if has('mac')
    execute "set <M-h>=\eh"
    execute "set <M-j>=\ej"
    execute "set <M-k>=\ek"
    execute "set <M-l>=\el"
    execute "set <M-s>=\es"
    execute "set <M-t>=\et"
  else
    execute 'set <M-h>=h'
    execute 'set <M-j>=j'
    execute 'set <M-k>=k'
    execute 'set <M-l>=l'
    execute 'set <M-s>=s'
    execute 'set <M-t>=t'
  endif
endif

if has('gui') || !exists('$TMUX')
  map <D-h> <C-w>h
  map <D-j> <C-w>j
  map <D-k> <C-w>k
  map <D-l> <C-w>l
else
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
  if has('nvim')
    tnoremap <silent> <M-h> <C-\><C-N>:TmuxNavigateLeft<CR>
    tnoremap <silent> <M-j> <C-\><C-N>:TmuxNavigateDown<CR>
    tnoremap <silent> <M-k> <C-\><C-N>:TmuxNavigateUp<CR>
    tnoremap <silent> <M-l> <C-\><C-N>:TmuxNavigateRight<CR>
  endif
endif

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

" map combining nvim lsp diagnostics with GitSigns preview  {{{2
if has('nvim')
lua << EOF
function _G.has_line_diagnostic(bufnr, line_nr)
  local line_diagnostics = vim.diagnostic.get(bufnr, {lnum=line_nr})
  return not vim.tbl_isempty(line_diagnostics)
end
EOF
nnoremap <expr> =
      \ v:lua.has_line_diagnostic(bufnr('%'), line('.') - 1) ?
      \ ':lua vim.diagnostic.open_float()<CR>' :
      \ ':Gitsigns preview_hunk<CR>'
else
  nnoremap = :Gitsigns preview_hunk<CR>
endif
