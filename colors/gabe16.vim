" Vim color file
" By Gabriel A. Nespoli (gabenespoli@gmail.com)
set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="gabe16"

" Default Groups
" --------------
hi Normal ctermfg=none guifg=#d0d0d0 ctermbg=none guibg=#121212

" default groups and sub-groups specified in :help group-name
hi Comment cterm=none ctermfg=darkgreen guifg=#00af5f

hi Constant ctermfg=darkmagenta guifg=#875fff
hi String ctermfg=magenta guifg=#af87ff
hi Character ctermfg=lightgrey guifg=#9e9e9e
hi Number ctermfg=darkcyan guifg=#00afaf
hi Boolean ctermfg=darkcyan guifg=#00afaf
hi Float ctermfg=cyan guifg=#00afaf

hi Identifier ctermfg=darkyellow guifg=#d75f00
hi Function ctermfg=yellow guifg=#ffd700

hi Statement ctermfg=darkblue guifg=#0087ff
hi link Conditional Statement
hi link Repeat Statement
hi link Label Statement
hi Operator ctermfg=darkgrey guifg=#6c6c6c
hi link Keyword Statement
hi link Keyword Exception

hi PreProc ctermfg=lightgrey guifg=#9e9e9e
hi Include ctermfg=darkblue guifg=#0087ff
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc

"hi Type ctermfg=blue guifg=#00afff " made darkblue for solarized dark
hi Type ctermfg=darkblue
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type

hi Special ctermfg=darkgrey guifg=#6c6c6c
hi link SpecialChar Special
hi link Tag Special
hi link Delimiter Special
hi link SpecialComment Special
hi link Debug Special

hi Underlined ctermfg=darkmagenta guifg=#875fff

hi Ignore ctermfg=lightgrey guifg=#9e9e9e

hi Error term=reverse ctermfg=white guifg=#d0d0d0 ctermbg=darkred guibg=#ff005f

hi Todo ctermfg=black guifg=#121212 ctermbg=darkyellow guibg=#d75f00

" groups I've added
hi SpecialKey ctermfg=darkblue guifg=#0087ff
hi ErrorMsg term=standout ctermfg=white guifg=#d0d0d0 ctermbg=darkred guibg=#ff005f
hi WarningMsg term=standout ctermfg=white guifg=#d0d0d0 ctermbg=darkyellow guibg=#d75f00
hi MatchParen ctermfg=lightgrey guifg=#9e9e9e ctermbg=darkgrey guibg=#6c6c6c

" for use in this vimrc file
hi Title ctermfg=darkgreen guifg=#00af5f
hi Italic ctermbg=blue guibg=#00afff ctermfg=black guifg=#121212
hi Bold ctermfg=darkblue guifg=#0087ff

" Settings specific to certain plugins

" Pandoc
"hi pandocAtxStart ctermfg=darkgreen guifg=#00af5f
"hi pandocEmphasis ctermbg=blue guibg=#00afff ctermfg=black guifg=#121212
hi pandocEmphasis cterm=none ctermfg=blue
hi pandocStrong cterm=bold ctermfg=darkblue
"hi pandocListItemBulletId ctermfg=lightgrey guifg=#9e9e9e
"hi pandocListItemBullet ctermfg=lightgrey guifg=#9e9e9e
"hi pandocUListItemBullet ctermfg=lightgrey guifg=#9e9e9e
"hi pandocFootnoteIDHead ctermfg=darkgrey guifg=#6c6c6c
"hi pandocFootnoteIDTail ctermfg=darkgrey guifg=#6c6c6c
"hi pandocFootnoteID ctermfg=darkgrey guifg=#6c6c6c
"hi pandocFootnoteBlock ctermfg=lightgrey guifg=#9e9e9e
"hi pandocCiteLocator ctermfg=lightgrey guifg=#9e9e9e
"hi pandocCiteAnchor ctermfg=darkgrey guifg=#6c6c6c
"hi pandocCiteKey ctermfg=darkcyan guifg=#00afaf
"hi pandocPcite ctermfg=lightgrey guifg=#9e9e9e
"hi pandocImageIcon ctermfg=yellow guifg=#ffd700
"hi pandocNoFormatted ctermfg=magenta guifg=#af87ff
"hi pandocReferenceLabel ctermfg=lightgrey guifg=#9e9e9e
"hi pandocReferenceURL cterm=underline ctermfg=darkblue guifg=#0087ff
"hi yamlBlockMappingKey ctermfg=darkgrey guifg=#6c6c6c
"hi yamlDocumentStart ctermfg=darkgrey guifg=#6c6c6c
"hi yamlFlowStringDelimiter ctermfg=darkgrey guifg=#6c6c6c
"
hi LineNr term=none ctermfg=darkgrey
hi SignColumn ctermbg=black
hi FoldColumn term=standout ctermfg=darkgrey guifg=#6c6c6c ctermbg=black guibg=#121212
hi Folded term=standout cterm=bold ctermfg=white guifg=#d0d0d0 ctermbg=darkgrey guibg=#6c6c6c
hi VertSplit term=reverse cterm=reverse ctermfg=black guifg=#121212 ctermbg=black guibg=#121212
hi StatusLineNC term=reverse cterm=reverse ctermfg=black guifg=#121212 ctermbg=black guibg=#121212
hi StatusLine term=reverse cterm=none ctermfg=darkgrey guifg=#6c6c6c ctermbg=black guibg=#121212
"hi TabLine ctermfg=black guifg=#121212
"hi TabLineFill ctermfg=white guifg=#d0d0d0 ctermbg=darkgrey guifg=#6c6c6c
"hi TabLineSel cterm

"hi clear SpellBad
hi SpellBad ctermfg=white ctermbg=darkred
hi SpellCap ctermfg=white ctermbg=darkblue
"hi SpellLocal
hi SpellRare ctermfg=white ctermbg=magenta


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
hi NonText term=bold cterm=bold ctermfg=darkblue guifg=#0087ff
hi Directory term=bold ctermfg=darkblue guifg=#0087ff
hi IncSearch term=reverse cterm=reverse
hi Search term=reverse ctermfg=black guifg=#121212 ctermbg=darkyellow guibg=#d75f00
hi MoreMsg term=bold ctermfg=darkgreen guifg=#00af5f
hi ModeMsg term=bold cterm=bold
hi Question term=standout ctermfg=darkgreen guifg=#00af5f
hi Visual term=reverse cterm=reverse
hi VisualNOS term=bold,underline cterm=bold,underline
hi WildMenu term=standout ctermfg=black guifg=#121212 ctermbg=blue guibg=#00afff
hi DiffAdd ctermfg=green guifg=#00d787
hi DiffChange ctermbg=yellow guibg=#ffd700
hi DiffDelete cterm=bold ctermfg=red guifg=#ff87af ctermbg=cyan guibg=#00d7d7
hi DiffText cterm=bold ctermbg=red guibg=#ff87af

" status line change color for insert mode
hi StatusLineColorToggle ctermfg=white ctermbg=darkgrey 
au InsertEnter * hi StatusLineColorToggle ctermfg=black ctermbg=yellow
au InsertLeave * hi StatusLineColorToggle ctermfg=white ctermbg=darkgrey


"colorscheme sumach
" Sumach Colors chosen from xterm 256
" https://jonasjacek.github.io/colors/
" http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
hi SumachBlack          ctermfg=black guifg=#121212
hi SumachRed            ctermfg=darkred guifg=#ff005f
hi SumachGreen          ctermfg=darkgreen  guifg=#00af5f
hi SumachYellow         ctermfg=darkyellow guifg=#d75f00
hi SumachBlue           ctermfg=darkblue  guifg=#0087ff
hi SumachMagenta        ctermfg=darkmagenta  guifg=#875fff
hi SumachCyan           ctermfg=darkcyan  guifg=#00afaf
hi SumachWhite          ctermfg=lightgrey guifg=#9e9e9e
hi SumachBrightBlack    ctermfg=darkgrey guifg=#6c6c6c
hi SumachBrightRed      ctermfg=red guifg=#ff87af
hi SumachBrightGreen    ctermfg=green  guifg=#00d787
hi SumachBrightYellow   ctermfg=yellow guifg=#ffd700
hi SumachBrightBlue     ctermfg=blue  guifg=#00afff
hi SumachBrightMagenta  ctermfg=magenta guifg=#af87ff
hi SumachBrightCyan     ctermfg=cyan  guifg=#00d7d7
hi SumachBrightWhite    ctermfg=white guifg=#d0d0d0

