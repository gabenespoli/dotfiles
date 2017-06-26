" source solorized and force colorscheme name to be gaberized
so ~/.vim/colors/solarized.vim
let g:colors_name='gaberized'

"" Solarized customizations
hi Title                ctermfg=15      ctermbg=none    cterm=none
"hi Operator             ctermfg=7       ctermbg=none    cterm=none
hi WarningMsg           ctermfg=1       ctermbg=0       cterm=none
hi ErrorMsg             ctermfg=7       ctermbg=1       cterm=none

hi StatusLine           ctermfg=0       ctermbg=14      cterm=reverse
hi StatusLineNC         ctermfg=0       ctermbg=10      cterm=reverse
hi StatusLineFill       ctermfg=8       ctermbg=10      cterm=reverse
hi TabLineFill          ctermfg=10      ctermbg=8       cterm=none
hi TabLine              ctermfg=10      ctermbg=0       cterm=none
hi TabNum               ctermfg=10      ctermbg=0       cterm=none
hi TabWinNum            ctermfg=10      ctermbg=0       cterm=none
hi TabMod               ctermfg=1       ctermbg=0       cterm=none
hi TabLineSel           ctermfg=7       ctermbg=0       cterm=none
hi TabNumSel            ctermfg=7       ctermbg=0       cterm=none
hi TabWinNumSel         ctermfg=7       ctermbg=0       cterm=none
hi TabModSel            ctermfg=1       ctermbg=0       cterm=none
hi Pmenu                ctermfg=0       ctermbg=12      cterm=reverse
hi PmenuSel             ctermfg=12      ctermbg=8       cterm=reverse

hi LineNr               ctermfg=10      ctermbg=8       cterm=none
hi FoldColumn           ctermfg=8       ctermbg=12      cterm=reverse
hi VertSplit            ctermfg=8       ctermbg=0       cterm=reverse
hi MatchParen           ctermfg=8       ctermbg=10      cterm=none
hi NonText              ctermfg=10      ctermbg=8       cterm=none
hi SpecialKey           ctermfg=10      ctermbg=0       cterm=none

hi Search               ctermfg=11      ctermbg=8       cterm=reverse
hi IncSearch            ctermfg=11      ctermbg=8       cterm=reverse
hi Visual               ctermfg=12      ctermbg=8       cterm=reverse

hi DiffAdd              ctermfg=2       ctermbg=0
hi DiffChange           ctermfg=12      ctermbg=0
hi DiffDelete           ctermfg=1       ctermbg=0
hi DiffText             ctermfg=9       ctermbg=0

"" Syntax-specific
""" Mail compose colors
hi mailHeader           ctermfg=10
hi mailHeaderKey        ctermfg=4
hi mailHeaderEmail      ctermfg=6
hi mailSubject          ctermfg=3

""" Markdown
hi markdownItalic       ctermfg=7       ctermbg=8       cterm=none
hi markdownBold         ctermfg=15      ctermbg=8       cterm=bold
hi markdownHeadingDelimiter ctermfg=7   ctermbg=0       cterm=none
hi markdownH1           ctermfg=7       ctermbg=0       cterm=none
hi markdownH2           ctermfg=7       ctermbg=0       cterm=none
hi markdownH3           ctermfg=7       ctermbg=0       cterm=none
hi markdownH4           ctermfg=7       ctermbg=0       cterm=none
hi markdownH5           ctermfg=7       ctermbg=0       cterm=none
hi markdownH6           ctermfg=7       ctermbg=0       cterm=none

""" MATLAB
hi matlabCellComment    ctermfg=11      ctermbg=0

"" Plugin color customizations

""" Syntastic
hi SyntasticErrorSign   ctermfg=1       ctermbg=8       cterm=none
hi SyntasticWarningSign ctermfg=9       ctermbg=8       cterm=none
"hi SyntasticErrorLine   ctermfg=1       ctermbg=8       cterm=none
"hi SyntasticWarningLine ctermfg=1       ctermbg=8       cterm=none

""" Buffergator
hi BuffergatorBufferNr  ctermfg=10      ctermbg=8       cterm=none

""" DiffChar
hi _DiffDelPos          ctermfg=1       ctermbg=0       cterm=underline

""" CenWin
hi CenWinOutlineHeader1 ctermfg=4       ctermbg=8       cterm=reverse 
hi CenWinOutlineHeader2 ctermfg=4       ctermbg=8       cterm=none 
hi CenWinOutlineHeader3 ctermfg=6       ctermbg=8       cterm=none
hi CenWinTodo           ctermfg=5       ctermbg=8       cterm=none

""" Todo and Todo.txt plugin
hi Todo                 ctermfg=13                      cterm=reverse 
hi TodoPriorityA        ctermfg=9
hi TodoPriorityB        ctermfg=2
hi TodoPriorityC        ctermfg=2
hi TodoProject          ctermfg=4
hi TodoContext          ctermfg=6
hi TodoDone             ctermfg=11
hi TodoKey              ctermfg=10      ctermbg=0
hi TodoDate             ctermfg=11      ctermbg=8
"hi TodoTaskPoints       ctermfg=2

"" solarized color codes reference
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

