" Author: Gabe Nespoli
" Email: gabenespoli@gmail.com
" File: vimrc/init.vim for vim/nvim
set encoding=utf-8
scriptencoding utf-8

" Plugins: {{{1
call plug#begin('~/.vim/plugged')

" Editing:
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-fold'
Plug 'romainl/vim-qf'
Plug 'junegunn/vim-peekaboo'

" General:
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug '~/bin/vim/gv.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'justinmk/vim-dirvish'
Plug 'roginfarrer/vim-dirvish-dovish', {'branch': 'main'}
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'sjl/gundo.vim'
Plug 'overcache/NeoSolarized'

" Coding:
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'nathunsmitty/nvim-ale-diagnostic', {'branch': 'main'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'liuchengxu/vista.vim'
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-dadbod'
Plug 'Vimjas/vim-python-pep8-indent',  {'for': ['python']}
Plug 'kalekundert/vim-coiled-snake'
Plug 'Konfekt/FastFold'
Plug 'jeetsukumaran/vim-pythonsense',  {'for': ['python']}
Plug 'psf/black', {'branch': 'main', 'tag': '19.10b0'}
Plug 'fisadev/vim-isort'

" Writing:
Plug 'junegunn/vim-easy-align'
Plug 'rickhowe/diffchar.vim',          {'for': ['markdown', 'pandoc']}
Plug 'gabenespoli/vim-criticmarkup',   {'for': ['markdown', 'pandoc']}
Plug 'jszakmeister/markdown2ctags',    {'for': ['markdown', 'pandoc']}

" Tmux:
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'

" My Plugins:
Plug 'gabenespoli/vim-mutton'
Plug 'gabenespoli/vim-tabsms'
Plug 'gabenespoli/vim-neovim-defaults'
Plug 'gabenespoli/vim-jupycent'

call plug#end()

" General: {{{1
if has('mac') | set fileformats=unix,dos | endif
set updatetime=300
set undofile
set undodir=~/.config/nvim/undo/
set backupdir=~/.config/nvim/backup/
set directory=~/.config/nvim/swap/
if has('macunix')
  let g:python_host_prog = expand('~').'/miniconda/envs/neovim2/bin/python'
  let g:python3_host_prog = expand('~').'/miniconda/envs/neovim3/bin/python'
else
  let g:python3_host_prog = expand('~').'/.pyenv/neovim3/bin/python'
endif
set hidden
set nomodeline
set number
set equalalways splitright splitbelow
set nowrap linebreak breakindent whichwrap+=h,l
set expandtab tabstop=2 softtabstop=2 shiftwidth=2
set listchars+=extends:>,precedes:<
set formatoptions-=t
set cursorline
set showmatch
set ignorecase smartcase nohlsearch
set foldlevel=99
set foldmethod=marker
set foldtext=getline(v:foldstart)
let g:vimsyn_folding='af'
set wildignorecase
set completeopt=menuone
set shortmess+=c
set tags^=.git/tags;~
set diffopt+=context:3
set suffixesadd+=.m,.r,.R,.py
set clipboard=unnamed
set mouse=n
set guioptions=g
set guicursor=n-v-sm:block-blinkon0,i-ci-c:ver25-blinkon0,r-cr-o:hor20-blinkon0
set guifont=IBMPlexMono:h16,Menlo:h16,Consolas:h16,Courier:h16
let g:snooker_terminal_italics = 1
set background=dark
set termguicolors
if has('gui')
  colorscheme NeoSolarized
else
  colorscheme snooker
endif

" Status Line: {{{1
function! SSHIndicator() abort
  if !empty($SSH_CLIENT) || !empty($SSH_TTY) | return '^' | else | return '' | endif
endfunction
set statusline=
set statusline+=%{SSHIndicator()}
set statusline+=[%n]
set statusline+=\ (%{FugitiveHead(12)})
set statusline+=\ %{Devicon()}
set statusline+=[%<%.99f]
set statusline+=%h%w%#Modified#%m%*%#ErrorStatus#%r%*
set statusline+=%=
set statusline+=%{LinterStatus()}
set statusline+=[%l/%L\,%c\ (%P)]

function! Devicon() abort
  if stridx(expand('%:p'), '.git') != -1
    return ''
  else
    let l:icon = execute('lua print(require("nvim-web-devicons").get_icon('
          \ . '"' . expand('%:t') . '", "' . expand('%:e') . '"))')
    return l:icon[1:3]
  endif
endfunction

" display errors from Ale in statusline (https://kadekillary.work/post/statusline-vim/)
function! LinterStatus() abort
   let l:counts = ale#statusline#Count(bufnr(''))
   let l:all_errors = l:counts.error + l:counts.style_error
   let l:all_non_errors = l:counts.total - l:all_errors
   return l:counts.total == 0 ? '' : printf(
   \ '[E:%d W:%d]',
   \ l:all_errors,
   \ l:all_non_errors
   \)
endfunction

" Line Return (https://bitbucket.org/sjl/dotfiles/): {{{2
augroup line_return
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END

" Keybindings: {{{1
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

" close preview window (alternative to builtin <C-w>z)
nnoremap <silent> <leader>z :pclose<CR>

" echo syntax under cursor
nnoremap <silent> zS :echo synIDattr(synID(line("."),col("."),1),"name")<CR>
nnoremap zS :TSHighlightCapturesUnderCursor<CR>

" change pwd to that of current file or git repo
nnoremap <expr> cd exists(":Gcd") == 2 ? ':Gcd<CR>:pwd<CR>' : ':cd %:p:h<CR>:pwd<CR>'

" add last search to location list
nnoremap z/ :lvimgrep // %<CR>:botright lopen<CR>

" grep [git] folder for todos
nnoremap <expr> zT 
      \ exists(':Ggrep') == 2 ?
      \ ':Ggrep! "TODO\\|FIXME\\|XXX"<CR><CR>:botright copen<CR>' :
      \ ':vimgrep /TODO\|FIXME\|XXX/j *<CR><CR>:botright copen<CR>'

" quick text file in ~/notes folder
nnoremap <C-k><C-j> execute 'edit '.expand('~').'/notes/'.strftime("%Y-%m-%d").'.txt'

" quickfix
nnoremap <silent> <expr> <leader>q
      \ empty(filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')) ?
      \ ':botright copen<CR>' : ':cclose<CR>'
nnoremap <silent> <expr> <leader>l
      \ empty(filter(getwininfo(), 'v:val.quickfix && v:val.loclist')) ?
      \ ':botright lopen<CR>' : ':lclose<CR>'

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END

nnoremap <leader>s 1z=

" visual star (asterisk) search  {{{2
" https://github.com/bronson/vim-visual-star-search/blob/master/plugin/visual-star-search.vim
" Makes * and # work on visual mode too.  global function so user mappings can call it.
" specifying 'raw' for the second argument prevents escaping the result for vimgrep
" TODO: there's a bug with raw mode.  since we're using @/ to return an unescaped
" search string, vim's search highlight will be wrong.  Refactor plz.
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

" replace vim's built-in visual * and # behavior
xnoremap * :<C-u>call VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>

" bracket mappings (unimpaired)  {{{2
nnoremap [l :lprevious<CR>
nnoremap ]l :lnext<CR>
nnoremap [L :lfirst<CR>
nnoremap ]L :llast<CR>
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>

" map down and up to c/lnext and c/lprevious
" lnext/lprevious if location list is open, else cnext/cprevious
nnoremap <silent> <expr> <down>
      \ empty(filter(getwininfo(), 'v:val.loclist')) ?
      \ ':cnext<CR>' : ':lnext<CR>'
nnoremap <silent> <expr> <up>
      \ empty(filter(getwininfo(), 'v:val.loclist')) ?
      \ ':cprevious<CR>' : ':lprevious<CR>'

" move lines up and down (modified from tpope/vim-unimpaired)  {{{2
function! s:ExecMove(cmd) abort
  " let old_fdm = &foldmethod
  " if old_fdm !=# 'manual'
  "   let &foldmethod = 'manual'
  " endif
  normal! m`
  silent! exe a:cmd
  norm! ``
  " if old_fdm !=# 'manual'
  "   let &foldmethod = old_fdm
  " endif
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

nnoremap <silent> <Plug>unimpairedMoveUp            :<C-U>call <SID>Move('--',v:count1,'Up')<CR>
nnoremap <silent> <Plug>unimpairedMoveDown          :<C-U>call <SID>Move('+',v:count1,'Down')<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionUp   :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionDown :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>

nmap [e <Plug>unimpairedMoveUp
nmap ]e <Plug>unimpairedMoveDown
xmap [e <Plug>unimpairedMoveSelectionUp
xmap ]e <Plug>unimpairedMoveSelectionDown

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
nnoremap <silent> cow :set colorcolumn=<C-R>=&colorcolumn ? 0 : &textwidth<CR><CR>

nnoremap <silent> coS :set laststatus=<C-R>=&laststatus ? 0 : 2<CR><CR>
nnoremap <silent> coW :set wrap!<CR>
nnoremap <silent> coT :set showtabline=<C-R>=&showtabline==2 ? 1 : 2<CR><CR>
nnoremap <silent><expr> coX &winfixwidth ? ':set nowinfixwidth<CR>' : ':set winfixwidth<CR>'

" Plugin Settings: {{{1
" tpope/vim-rsi: {{{2
cnoremap <expr> <C-p> pumvisible() ? "\<C-p>" : "\<up>"
cnoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<down>"

" tpope/vim-surround: {{{2
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%' ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" romainl/vim-qf: {{{2
let g:qf_shorten_path = 0
let g:qf_mapping_ack_style = 1

" tpope/vim-fugitive: {{{2
nnoremap gs :Gedit :<CR>
nnoremap gZ :Gdiffsplit<CR>
nnoremap gC :Git commit<CR>
xnoremap zp :diffput<CR>
xnoremap zo :diffget<CR>
nnoremap <C-k>g :Ggrep!<Space>
nnoremap co<Space> :Git checkout<Space>

" airblade/gitgutter: {{{2
nmap ga <Plug>(GitGutterStageHunk)
xmap ga :GitGutterStageHunk<CR>
nmap ghu <Plug>(GitGutterUndoHunk)
nmap =  <Plug>(GitGutterPreviewHunk)
nnoremap <silent> cog :GitGutterToggle<CR>:echo g:gitgutter_enabled<CR>
nnoremap <silent> coG :GitGutterLineHighlightsToggle<CR>:echo g:gitgutter_highlight_lines<CR>
let g:gitgutter_override_sign_column_highlight = 0

nnoremap coz :call GitGutterFoldToggle()<CR>
function! GitGutterFoldToggle()
  if gitgutter#utility#getbufvar(bufnr(''), 'folded')
    GitGutterFold
    let l:buffoldexpr = gitgutter#utility#getbufvar(bufnr(''), 'foldexpr')
    if l:buffoldexpr != 0
      let &foldexpr = l:buffoldexpr
    endif
  else
    call gitgutter#utility#setbufvar(bufnr(''), 'foldexpr', &foldexpr)
    GitGutterFold
  endif
endfunction

" junegunn/gv.vim: {{{2
nnoremap gL :GV --all<CR>
xnoremap gL :GV --all<CR>
nnoremap gl :GV <CR>
xnoremap gl :GV <CR>

" telescope.nvim  {{2
nnoremap <C-k><Space>   :Telescope<Space>
nnoremap <C-k><C-Space> :Telescope<Space>
nnoremap <C-p>          :Telescope git_files<CR>
nnoremap <C-k><C-b>     :Telescope buffers<CR>
nnoremap <C-k><C-f>     :lua require('telescope.builtin').file_browser({dir_icon = ''})<CR>
nnoremap <C-k><C-g>     :Telescope live_grep<CR>
nnoremap <C-k><C-h>     :Telescope oldfiles<CR>
nnoremap <C-k><C-p>     :Telescope find_files<CR>
nnoremap <C-k><C-r>     :Telescope registers<CR>
nnoremap <C-k><C-t>     :Telescope lsp_document_symbols<CR>
nnoremap <C-k>gs        :Telescope git_status<CR>
nnoremap <C-k>gl        :Telescope git_commits<CR>

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      },
      n = {
        ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      },
    },
  }
}
EOF

" kyazdani42/nvim-web-devicons:  {{{2
lua << EOF
require("nvim-web-devicons").setup{
  override = {
    cfg = {icon = ""},
    vimrc = {icon = ""},
    bashrc = {icon = ""},
    bash_profile = {icon = ""},
    sql  =  {icon = "", color = "#a57230", name = "sql"},
  },
}
EOF

" justinmk/vim-dirvish: {{{2
let g:dirvish_mode = ':sort ,^.*[\/],'
if has('mac')
  let g:loaded_netrwPlugin = 1
  nnoremap gx :execute '!open ' . shellescape(expand('<cfile>'), 1)<CR><CR>
endif

" sjl/gundo.vim:  {{{2
nnoremap <C-k><C-u> :GundoToggle<CR>

" dense-analysis/ale: {{{2
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_set_loclist = 0
" let g:ale_hover_to_floating_window = 1
" let g:ale_hover_to_floating_preview = 1
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {
      \ '*': ['trim_whitespace'],
      \ 'python': ['black', 'isort'],
      \ 'sql': ['sqlformat'],
      \ }
let g:ale_sql_sqlformat_options = '-rs -k upper'
nnoremap [d :ALEPrevious<CR>
nnoremap ]d :ALENext<CR>
nnoremap cod :ALEToggle<CR>
augroup ale
  autocmd!
  autocmd FileType python nnoremap <buffer> gqq :Isort<CR>:Black<CR>
  autocmd FileType sql nnoremap <buffer> gqq :ALEFix<CR>
augroup END

" neovim/nvim-lspconfig:  {{{2
lua << EOF

require('vim.lsp.protocol').CompletionItemKind = {
  '', -- Text 
  '', -- Method 
  '', -- Function
  '', -- Constructor
  '', -- Field ﰠ
  '', -- Variable
  'פּ', -- Class ﴯפּ
  'ﰮ', -- Interface ﰮ
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword 
  '﬌', -- Snippet ﬌
  '', -- Color
  '', -- File 
  '', -- Reference 
  '', -- Folder 
  '', -- EnumMember
  '', -- Constant
  '', -- Struct 
  '', -- Event
  '', -- Operator
  '', -- TypeParameter
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

require('lspconfig').pyright.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      }
    }
  }
}

require("nvim-ale-diagnostic")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = false,
    update_in_insert = false,
    virtual_text = false,
  }
)

EOF

nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <C-k><C-d> <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap [D <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]D <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

augroup nvimlsp
  autocmd!
  autocmd FileType python nmap <buffer> <C-w><C-d> <C-w><C-v>gdzt
augroup END

" nvim-treesitter:  {{{2
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

" nvim-treesitter/playground:  {{{2
lua <<EOF
require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
EOF

" liuchengxu/vista.vim:  {{{2
let g:vista_executive_for = {'python': 'nvim_lsp'}
let g:vista_sidebar_width = 40
nnoremap <C-k><C-v> :Vista!!<CR>

" jeetsukumaran/vim-pythonsense
let g:is_pythonsense_suppress_object_keymaps = 1

augroup pythonsense
  autocmd!
  autocmd FileType python vmap <buffer> aC <Plug>(PythonsenseOuterClassTextObject)
  autocmd FileType python omap <buffer> aC <Plug>(PythonsenseOuterClassTextObject)
  autocmd FileType python sunmap <buffer> aC
  autocmd FileType python vmap <buffer> iC <Plug>(PythonsenseInnerClassTextObject)
  autocmd FileType python omap <buffer> iC <Plug>(PythonsenseInnerClassTextObject)
  autocmd FileType python sunmap <buffer> iC
  autocmd FileType python vmap <buffer> af <Plug>(PythonsenseOuterFunctionTextObject)
  autocmd FileType python omap <buffer> af <Plug>(PythonsenseOuterFunctionTextObject)
  autocmd FileType python sunmap <buffer> af
  autocmd FileType python vmap <buffer> if <Plug>(PythonsenseInnerFunctionTextObject)
  autocmd FileType python omap <buffer> if <Plug>(PythonsenseInnerFunctionTextObject)
  autocmd FileType python sunmap <buffer> if
  autocmd FileType python omap <buffer> ad <Plug>(PythonsenseOuterDocStringTextObject)
  autocmd FileType python vmap <buffer> ad <Plug>(PythonsenseOuterDocStringTextObject)
  autocmd FileType python sunmap <buffer> ad
  autocmd FileType python omap <buffer> id <Plug>(PythonsenseInnerDocStringTextObject)
  autocmd FileType python vmap <buffer> id <Plug>(PythonsenseInnerDocStringTextObject)
  autocmd FileType python sunmap <buffer> id
augroup END

" Writing: {{{2
" tpope/vim-markdown (built-in): {{{2
let g:markdown_fenced_languages = ['bash=sh', 'matlab', 'python', 'vim', 'r']
let g:markdown_folding = 1

" junegunn/vim-easy-align: {{{2
nmap cg <Plug>(EasyAlign)

" rickhowe/diffchar: {{{2
let g:DiffPairVisible = 0
let g:DiffUpdate = 0
let g:DiffModeSync = 0
nmap coD    <Plug>ToggleDiffCharAllLines
nmap <Plug> <Plug>ToggleDiffCharCurrentLine
nmap <Plug> <Plug>JumpDiffCharPrevStart
nmap <Plug> <Plug>JumpDiffCharNextStart
nmap <Plug> <Plug>JumpDiffCharPrevEnd
nmap <Plug> <Plug>JumpDiffCharNextEnd
nmap dO     <Plug>GetDiffCharPair
nmap dP     <Plug>PutDiffCharPair

" gabenespoli/vim-criticmarkup: {{{2
let g:criticmarkup#disable#highlighting = 1

" jszakmeister/markdown2ctags: {{{2
let g:tagbar_type_markdown = {
  \ 'ctagstype': 'markdown',
  \ 'ctagsbin' : '~/.vim/plugged/markdown2ctags/markdown2ctags.py',
  \ 'ctagsargs' : '-f - --sort=yes',
  \ 'kinds' : ['s:sections', 'i:images'],
  \ 'sro' : '|',
  \ 'kind2scope' : {'s' : 'section',},
  \ 'sort': 0,
\ }

" christoomey/vim-tmux-navigator: {{{2
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

" jpalardy/vim-slime: {{{2
let g:slime_no_mappings = 1
xmap <C-l>      <Plug>SlimeRegionSend
nmap <C-l>      <Plug>SlimeMotionSend
nmap <C-l><C-l> <Plug>SlimeLineSend
nmap <C-l><CR> <C-l>ip}j
nmap <C-l><C-j> <C-l><CR>
nmap <C-l><C-k> <C-l>ip
let g:slime_target = 'tmux'
let g:slime_dont_ask_default = 1
if exists('$TMUX')
  let g:slime_default_config = {'socket_name': split($TMUX, ',')[0], 'target_pane': ':.2'}
endif
nnoremap g<C-l> <C-l>

" gabenespoli/vim-mutton: {{{2
let g:mutton_min_center_width = 88
let g:mutton_min_side_width = 25

" Lilypond: {{{2
filetype off
set runtimepath+=/Users/gmac/.lyp/lilyponds/2.18.2/share/lilypond/current/vim
filetype on

" local vimrc {{{2
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    execute 'source' a:file
  endif
endfunction
call SourceIfExists("~/.vimrc_local")
