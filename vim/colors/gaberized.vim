" source solorized and force colorscheme name to be gaberized
so ~/.vim/colors/solarized.vim
let g:colors_name='gaberized'

" Solarized customizations
hi StatusLine           ctermfg=0   ctermbg=14  cterm=reverse
hi StatusLineNC         ctermfg=0   ctermbg=10  cterm=reverse
hi LineNr               ctermfg=8   ctermbg=10  cterm=reverse
hi FoldColumn           ctermfg=8   ctermbg=12  cterm=reverse
hi VertSplit            ctermfg=8   ctermbg=0   cterm=reverse
hi Search               ctermfg=12  ctermbg=8   cterm=reverse
hi NonText              ctermfg=0   ctermbg=8   cterm=none

hi DiffText             ctermfg=9   ctermbg=0
hi DiffChange           ctermfg=12  ctermbg=0
hi DiffAdd              ctermfg=2   ctermbg=0
hi DiffDelete           ctermfg=1   ctermbg=0

" Mail compose colors
hi mailHeader           ctermfg=10
hi mailHeaderKey        ctermfg=4
hi mailHeaderEmail      ctermfg=6
hi mailSubject          ctermfg=3

" Markdown
hi markdownItalic       ctermfg=7   ctermbg=8   cterm=none
hi markdownBold         ctermfg=15  ctermbg=8   cterm=none
hi markdownHeadingDelimiter ctermfg=15  ctermbg=8   cterm=none
hi markdownH1           ctermfg=15  ctermbg=8   cterm=none
hi markdownH2           ctermfg=15  ctermbg=8   cterm=none
hi markdownH3           ctermfg=15  ctermbg=8   cterm=none
hi markdownH4           ctermfg=15  ctermbg=8   cterm=none
hi markdownH5           ctermfg=15  ctermbg=8   cterm=none
hi markdownH6           ctermfg=15  ctermbg=8   cterm=none

" Plugin color customizations
" DiffChar
hi _DiffDelPos          ctermfg=1   ctermbg=0   cterm=underline

" CenWin
hi CenWinOutlineHeader1 ctermfg=4   ctermbg=8   cterm=reverse 
hi CenWinOutlineHeader2 ctermfg=4   ctermbg=8   cterm=none 
hi CenWinOutlineHeader3 ctermfg=6   ctermbg=8   cterm=none
hi CenWinTodo           ctermfg=5   ctermbg=8   cterm=none

" Todo and Todo.txt plugin
hi Todo                 ctermfg=13              cterm=reverse 
hi TodoPriorityA        ctermfg=1
hi TodoPriorityB        ctermfg=5
hi TodoPriorityC        ctermfg=13
hi TodoProject          ctermfg=6   ctermbg=0
hi TodoContext          ctermfg=4   ctermbg=0
hi TodoDone             ctermfg=11
hi TodoKey              ctermfg=10  ctermbg=0
hi TodoDate             ctermfg=9   ctermbg=0

" Custom statusline highlight groups
hi FilepathStatusColor  ctermfg=12  ctermbg=0
hi ModifiedFlagColor    ctermfg=1   ctermbg=0

" solarized color codes reference
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

