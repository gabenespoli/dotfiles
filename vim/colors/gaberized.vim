"" Gaberized Colorschme for Vim
" source solorized and force colorscheme name to be gaberized
so ~/.vim/colors/solarized.vim
let g:colors_name='gaberized'

"" Solarized customizations
hi Title                ctermfg=15      ctermbg=none    cterm=none
"hi Operator             ctermfg=7       ctermbg=none    cterm=none
hi WarningMsg           ctermfg=9       ctermbg=8       cterm=reverse
hi ErrorMsg             ctermfg=1       ctermbg=7       cterm=reverse

hi StatusLine           ctermfg=0       ctermbg=14      cterm=reverse
hi StatusLineNC         ctermfg=0       ctermbg=10      cterm=reverse
hi StatusLineFill       ctermfg=8       ctermbg=10      cterm=reverse
hi TabLineFill          ctermfg=10      ctermbg=8       cterm=none
hi TabLine              ctermfg=10      ctermbg=0       cterm=none
hi TabNum               ctermfg=10      ctermbg=0       cterm=none
hi TabWinNum            ctermfg=10      ctermbg=0       cterm=none
hi TabMod               ctermfg=3       ctermbg=0       cterm=none
hi TabLineSel           ctermfg=7       ctermbg=0       cterm=none
hi TabNumSel            ctermfg=7       ctermbg=0       cterm=none
hi TabWinNumSel         ctermfg=7       ctermbg=0       cterm=none
hi TabModSel            ctermfg=3       ctermbg=0       cterm=none
hi Pmenu                ctermfg=0       ctermbg=12      cterm=reverse
hi PmenuSel             ctermfg=12      ctermbg=8       cterm=reverse

hi LineNr               ctermfg=10      ctermbg=8       cterm=none
hi FoldColumn           ctermfg=8       ctermbg=12      cterm=reverse
hi Folded               ctermfg=11      ctermbg=0       cterm=none
hi VertSplit            ctermfg=8       ctermbg=0       cterm=reverse
hi MatchParen           ctermfg=8       ctermbg=10      cterm=none
hi NonText              ctermfg=10      ctermbg=8       cterm=none
hi SpecialKey           ctermfg=10      ctermbg=0       cterm=none

hi Search               ctermfg=15      ctermbg=1       cterm=none
hi IncSearch            ctermfg=15      ctermbg=1       cterm=none
hi Visual               ctermfg=12      ctermbg=8       cterm=reverse

hi DiffAdd              ctermfg=2       ctermbg=0
hi DiffChange           ctermfg=12      ctermbg=0
hi DiffDelete           ctermfg=1       ctermbg=0
hi DiffText             ctermfg=9       ctermbg=0

"" Custom
hi StatusMod            ctermfg=3       ctermbg=0       cterm=none
hi StatusFlag           ctermfg=1       ctermbg=0       cterm=none
hi CommentHeading       ctermfg=11      ctermbg=0       cterm=none
hi FoldHeading          ctermfg=11      ctermbg=0       cterm=none

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
hi link matlabCellComment CommentHeading

"" Plugin color customizations

""" CapitalL
hi LmarkdownH1          ctermbg=8
hi LmarkdownH2          ctermbg=8
hi LmarkdownH3          ctermbg=8
hi LmarkdownH4          ctermbg=8
hi LmarkdownH5          ctermbg=8
hi LmarkdownH6          ctermbg=8

""" Linters / Syntax checking
hi link ALEErrorSign ErrorMsg
hi link ALEWarningSign WarningMsg
" hi link SyntasticErrorSign ErrorMsg
" hi link SyntasticWarningSign WarningMsg

""" NERDTree
hi NERDTreeExecFile     ctermfg=5
hi NERDTreeLinkDir      ctermfg=6
hi NERDTreeLinkFile     ctermfg=6
hi NERDTreeLinkTarget   ctermfg=12
" hi NERDTreeOpenable     ctermfg=12
" hi NERDTreeCloseable    ctermfg=12

""" Buffergator
hi BuffergatorBufferNr  ctermfg=10      ctermbg=8       cterm=none

""" Tagbar
hi TagbarType           ctermfg=10
hi TagbarScope          ctermfg=12

""" DiffChar
hi _DiffDelPos          ctermfg=1       ctermbg=0       cterm=underline

""" CenWin
hi CenWinOutlineHeader1 ctermfg=4       ctermbg=8       cterm=reverse 
hi CenWinOutlineHeader2 ctermfg=4       ctermbg=8       cterm=none 
hi CenWinOutlineHeader3 ctermfg=6       ctermbg=8       cterm=none
hi CenWinTodo           ctermfg=5       ctermbg=8       cterm=none

""" Todo and Todo.txt plugin
hi Todo                 ctermfg=13                      cterm=reverse 
hi TodoPriorityA        ctermfg=1
hi TodoPriorityB        ctermfg=2
hi TodoPriorityC        ctermfg=12
hi TodoProject          ctermfg=4
hi TodoContext          ctermfg=13
hi TodoDone             ctermfg=10
hi TodoTag              ctermfg=10
hi TodoPointsTag        ctermfg=10
hi TodoPoints           ctermfg=13
hi TodoDate             ctermfg=2

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

