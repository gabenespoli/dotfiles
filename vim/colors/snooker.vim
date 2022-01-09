" Setup {{{1
hi clear

if exists('syntax on')
    syntax reset
endif

set background=dark
let g:colors_name='snooker'

if !exists('g:snooker_terminal_italics')
  let g:snooker_terminal_italics = 1
endif

if !exists('g:snooker_spell_undercurl')
  let g:snooker_spell_undercurl = 0
endif

if !exists('g:snooker_gui_color_undercurl')
  let g:snooker_gui_color_undercurl = 0
endif

" Colors {{{1
let s:bg              = { 'gui': '#0f111b', 'cterm': 'NONE' }
let s:fg              = { 'gui': '#adad9b', 'cterm': 'NONE' }
let s:none            = { 'gui': 'NONE',    'cterm': 'NONE' }

let s:bg_light        = { 'gui': '#2b302b', 'cterm': '0'    }
let s:red             = { 'gui': '#e52e1a', 'cterm': '1'    }
let s:green           = { 'gui': '#1c9c20', 'cterm': '2'    }
let s:brown           = { 'gui': '#a57230', 'cterm': '3'    }
let s:blue            = { 'gui': '#0094cf', 'cterm': '4'    }
let s:purple          = { 'gui': '#5e72d5', 'cterm': '5'    }
let s:cyan            = { 'gui': '#1dae87', 'cterm': '6'    }
let s:fg_light        = { 'gui': '#cdc08b', 'cterm': '7'    }

let s:fg_com          = { 'gui': '#6a6a5b', 'cterm': '8'    }
let s:orange          = { 'gui': '#e5941a', 'cterm': '9'    }
let s:green_light     = { 'gui': '#25c528', 'cterm': '10'   }
let s:yellow          = { 'gui': '#c89b13', 'cterm': '11'   }
let s:blue_light      = { 'gui': '#00a3cc', 'cterm': '12'   }
let s:pink            = { 'gui': '#df7376', 'cterm': '13'   }
let s:cyan_light      = { 'gui': '#5ccc96', 'cterm': '14'   }
let s:fg_bright       = { 'gui': '#e5e5d2', 'cterm': '15'   }

if g:snooker_spell_undercurl == 1
  let s:sp_un      = 'undercurl'
else
  let s:sp_un      = 'underline'
endif

" https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  " Not all terminals support italics properly. If yours does, opt-in.
  if g:snooker_terminal_italics == 0 && has_key(a:style, 'cterm') && a:style['cterm'] ==? 'italic'
    unlet a:style.cterm
  endif
  execute 'highlight' a:group
    \ 'guifg='   (has_key(a:style, 'fg')    ? a:style.fg.gui   : 'NONE')
    \ 'guibg='   (has_key(a:style, 'bg')    ? a:style.bg.gui   : 'NONE')
    \ 'guisp='   (has_key(a:style, 'sp')    ? a:style.sp.gui   : 'NONE')
    \ 'gui='     (has_key(a:style, 'gui')   ? a:style.gui      : 'NONE')
    \ 'ctermfg=' (has_key(a:style, 'fg')    ? a:style.fg.cterm : 'NONE')
    \ 'ctermbg=' (has_key(a:style, 'bg')    ? a:style.bg.cterm : 'NONE')
    \ 'cterm='   (has_key(a:style, 'cterm') ? a:style.cterm    : 'NONE')
endfunction

" Main Groups {{{1
" (see `:h w18`)

call s:h('Normal',        {'fg': s:fg})
call s:h('Cursor',        {'fg': s:bg, 'bg': s:fg_light})
call s:h('Comment',       {'fg': s:fg_com, 'gui': 'italic', 'cterm': 'italic'})

call s:h('Constant',      {'fg': s:cyan_light})
call s:h('String',        {'fg': s:cyan})
hi! link Character        String
hi! link Number           String
hi! link Boolean          Constant
hi! link Float            String

call s:h('Identifier',    {'fg': s:blue})
call s:h('Function',      {'fg': s:blue_light})

call s:h('Statement',     {'fg': s:green})
call s:h('Conditional',   {'fg': s:green})
hi! link Repeat           Conditional
hi! link Label            Conditional
hi! link Operator         Normal
hi! link Keyword          Statement
call s:h('Exception',     {'fg': s:orange})

call s:h('PreProc',       {'fg': s:purple})
hi! link Include          PreProc
hi! link Define           PreProc
hi! link Macro            PreProc
hi! link PreCondit        PreProc

call s:h('Type',          {'fg': s:yellow})
call s:h('Structure',     {'fg': s:green})
hi! link StorageClass     Type
hi! link Typedef          Type

call s:h('Special',       {'fg': s:orange})
hi! link SpecialChar      Special
hi! link Tag              Special
call s:h('Delimiter',     {'fg': s:brown})
hi! link SpecialComment   Special
hi! link Debug            Special

call s:h('Underlined',    {'gui': 'underline', 'cterm': 'underline'})
call s:h('Ignore',        {'fg': s:bg_light})
call s:h('Error',         {'fg': s:red})
call s:h('Todo',          {'fg': s:pink})

" Extra Groups {{{1
" ordered according to `:help hitest.vim`
call s:h('SpecialKey',    {'fg': s:fg})
call s:h('NonText',       {'fg': s:bg_light, 'gui': 'bold', 'cterm': 'bold'})
call s:h('Whitespace',    {'fg': s:bg_light})
call s:h('EndOfBuffer',   {'fg': s:bg_light})
call s:h('NonText',       {'fg': s:bg_light})
call s:h('Directory',     {'fg': s:blue})
call s:h('ErrorMsg',      {'fg': s:fg_bright, 'bg': s:red})
call s:h('IncSearch',     {'fg': s:pink, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('Search',        {'fg': s:pink, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('MoreMsg',       {'fg': s:fg_com})
hi! link ModeMsg          MoreMsg

call s:h('LineNr',        {'fg': s:fg_com})
call s:h('CursorLineNr',  {'fg': s:fg, 'bg': s:bg_light})
call s:h('Question',      {'fg': s:green})
call s:h('StatusLine',    {'fg': s:fg_com, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('Conceal',       {'fg': s:fg})
call s:h('StatusLineNC',  {'fg': s:fg_com, 'bg': s:bg_light})
call s:h('VertSplit',     {'fg': s:bg_light, 'bg': s:bg})
call s:h('Title',         {'fg': s:fg_bright, 'gui': 'bold,italic', 'cterm': 'bold,italic'})
call s:h('Visual',        {'fg': s:fg_bright, 'bg': s:fg_com})
call s:h('VisualNOS',     {'fg': s:fg_bright, 'bg': s:fg_com})
call s:h('WarningMsg',    {'fg': s:bg, 'bg': s:orange})
call s:h('WildMenu',      {'fg': s:bg_light, 'bg': s:fg_bright})
call s:h('Folded',        {'fg': s:fg, 'bg': s:bg_light, 'gui': 'italic', 'cterm': 'italic'})
call s:h('FoldColumn',    {'fg': s:fg_light, 'bg': s:bg_light})
call s:h('SignColumn',    {'fg': s:fg})

call s:h('DiffAdd',       {'fg': s:bg, 'bg': s:green})
call s:h('DiffChange',    {'fg': s:bg, 'bg': s:blue})
call s:h('DiffDelete',    {'fg': s:bg, 'bg': s:red})
call s:h('DiffText',      {'fg': s:bg, 'bg': s:yellow})

if has('gui_running') && g:snooker_gui_color_undercurl
  call s:h('SpellBad',    {'gui': s:sp_un, 'sp': s:red})
  call s:h('SpellCap',    {'gui': s:sp_un, 'sp': s:pink})
  call s:h('SpellRare',   {'gui': s:sp_un, 'sp': s:cyan})
  call s:h('SpellLocal',  {'gui': s:sp_un, 'sp': s:yellow})
else
  call s:h('SpellBad',    {'cterm': s:sp_un, 'gui': s:sp_un})
  call s:h('SpellCap',    {'cterm': s:sp_un, 'gui': s:sp_un})
  call s:h('SpellRare',   {'cterm': s:sp_un, 'gui': s:sp_un})
  call s:h('SpellLocal',  {'cterm': s:sp_un, 'gui': s:sp_un})
endif

call s:h('Pmenu',         {'fg': s:fg, 'bg': s:bg_light})
call s:h('PmenuSel',      {'fg': s:blue_light, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('PmenuSbar',     {'fg': s:fg, 'bg': s:bg_light})
call s:h('PmenuThumb',    {'fg': s:fg, 'bg': s:bg_light})
call s:h('TabLine',       {'fg': s:fg_com, 'bg': s:bg_light})
call s:h('TabLineSel',    {'fg': s:fg_com, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('TabLineFill',   {'fg': s:fg, 'bg': s:bg})
call s:h('CursorColumn',  {'bg': s:bg_light})
call s:h('CursorLine',    {'bg': s:bg_light})
call s:h('ColorColumn',   {'bg': s:bg_light})

" remainder of syntax highlighting
call s:h('MatchParen',    {'fg': s:fg_com, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('qfLineNr',      {'fg': s:fg})

" nvim-only groups
hi! link TermCursor     DiffText
hi! link TermCursorNC   DiffChange

" Treesitter {{{1
" hi! link TSNone                 guifg=foreground
" hi! link TSPunctDelimiter       links to Delimiter
" hi! link TSPunctBracket         links to Delimiter

" hi! link TSPunctSpecial         links to Delimiter
hi! link TSPunctSpecial         Special

" hi! link TSConstant             links to Constant

" hi! link TSConstBuiltin         links to Special
hi! link TSConstBuiltin         Constant

" hi! link TSConstMacro           links to Define
" hi! link TSString               links to String
" hi! link TSStringRegex          links to String
" hi! link TSStringEscape         links to SpecialChar
" hi! link TSCharacter            links to Character
" hi! link TSNumber               links to Number
" hi! link TSBoolean              links to Boolean
" hi! link TSFloat                links to Float
" hi! link TSFunction             links to Function

" hi! link TSFuncBuiltin          links to Special
hi! link TSFuncBuiltin          Function

" hi! link TSFuncMacro            links to Macro

" hi! link TSParameter            links to Identifier
hi! link TSParameter            PreProc

" hi! link TSParameterReference   links to TSParameter
" hi! link TSMethod               links to Function
" hi! link TSField                links to Identifier
" hi! link TSProperty             links to Identifier

" hi! link TSConstructor          links to Special
hi! link TSConstructor          Type

" hi! link TSAnnotation           links to PreProc
" hi! link TSAttribute            links to PreProc
" hi! link TSNamespace            links to Include
" hi! link TSConditional          links to Conditional
" hi! link TSRepeat               links to Repeat
" hi! link TSLabel                links to Label
" hi! link TSOperator             links to Operator
" hi! link TSKeyword              links to Keyword
" hi! link TSKeywordFunction      links to Keyword
" hi! link TSKeywordOperator      links to TSOperator
" hi! link TSException            links to Exception
" hi! link TSType                 links to Type
" hi! link TSTypeBuiltin          links to Type
" hi! link TSInclude              links to Include

" hi! link TSVariableBuiltin      links to Special
hi! link TSVariableBuiltin      Type

" hi! link TSText                 links to TSNone
" hi! link TSStrong               cterm=bold gui=bold
" hi! link TSEmphasis             cterm=italic gui=italic
" hi! link TSUnderline            cterm=underline gui=underline
" hi! link TSTitle                links to Title
" hi! link TSLiteral              links to String
" hi! link TSURI                  links to Underlined
" hi! link TSTag                  links to Label
" hi! link TSTagDelimiter         links to Delimiter

" my own extras {{{1
call s:h('Modified',      {'fg': s:yellow, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('ReadOnly',      {'fg': s:brown,  'bg': s:fg_com, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('StatusTodo',    {'fg': s:pink,   'bg': s:bg_light, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('StatusError',   {'fg': s:red,    'bg': s:bg_light, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('StatusPreview', {'fg': s:blue,   'bg': s:bg_light, 'gui': 'reverse', 'cterm': 'reverse'})
" call s:h('StatusFunction',{'fg': s:fg_com, 'bg': s:fg_light, 'gui': 'reverse', 'cterm': 'reverse'})
hi! link TabMod           Modified
hi! link TabModSel        TabMod
hi! link markdownPandocCitation pandocCiteKey
call s:h('Italic',        {'fg': s:fg_light, 'gui': 'italic', 'cterm': 'italic'})
call s:h('Bold',          {'fg': s:fg_light, 'gui': 'bold', 'cterm': 'bold'})
call s:h('BoldItalic',    {'fg': s:fg_light, 'gui': 'bold,italic', 'cterm': 'bold,italic'})

" Syntaxes {{{1

" Shell {{{2
hi! link shQuote String
hi! link zshVariableDef Identifier
hi! link zshOperator Operator

" Markdown {{{2
hi! link markdownHeadingDelimiter   Title
" call s:h('markdownItalic',          {'fg': s:fg_light, 'gui': 'italic', 'cterm': 'italic'})
" call s:h('markdownBold',            {'fg': s:fg_light, 'gui': 'bold', 'cterm': 'bold'})
" call s:h('markdownBoldItalic',      {'fg': s:fg_light, 'gui': 'bold,italic', 'cterm': 'bold,italic'})
hi! link markdownItalic             Italic
hi! link markdownBold               Bold
hi! link markdownBoldItalic         BoldItalic
hi! link markdownItalicDelimiter    Comment
hi! link markdownBoldDelimiter      Comment
hi! link markdownBoldItalicDelimiter Comment
hi! link markdownLinkDelimiter      Comment
hi! link markdownLinkTextDelimiter  Comment
call s:h('markdownLinkText',        {'fg': s:blue, 'gui': 'italic', 'cterm': 'italic'})
call s:h('markdownUrl',             {'fg': s:brown, 'gui': 'italic', 'cterm': 'italic'})
" hi! link markdownUrlTitle           pandocLinkTip
hi! link markdownUrlTitleDelimiter  markdownUrlTitle
hi! link markdownCode               Constant
call s:h('markdownCodeDelimiter',   {'fg': s:fg_light})

" Pandoc Markdown {{{2
hi! link pandocAtxStart             markdownHeadingDelimiter
hi! link pandocEmphasis             markdownItalic
hi! link pandocStrong               markdownBold
hi! link pandocStrongEmphasis       markdownBoldItalic
hi! link pandocEmphasisInStrong     markdownBoldItalic

hi! link pandocOperator             Comment
hi! link pandocReferenceLabel       markdownLinkText
hi! link pandocReferenceURL         markdownUrl
hi! link pandocLinkTip              markdownUrlTitle

hi! link pandocImageIcon            Delimiter
hi! link pandocCiteLocator          Delimiter
hi! link pandocFootnoteIDHead       Delimiter
hi! link pandocFootnoteIDTail       Delimiter

call s:h('pandocCiteKey',           {'fg': s:blue, 'gui': 'italic', 'cterm': 'italic'})
hi! link pandocCiteAnchor           pandocCiteKey
hi! link pandocPCite                pandocCiteKey
hi! link pandocICite                pandocCiteKey
hi! link pandocFootnoteID           pandocCiteKey
" code
hi! link pandocNoFormatted          pandocCiteKey

" Critic Markup {{{2
hi! link criticAdd                  DiffAdd
hi! link criticDel                  DiffDelete
hi! link criticHighlighter          DiffText
hi! link criticsMeta                DiffChange

" Octave/Matlab {{{2
hi! link octaveDelimiter            Delimiter
hi! link octaveSemicolon            Normal
hi! link octaveBlockComment         Title
hi! link octaveVariable             Identifier
hi! link octaveOperator             Operator
hi! link octaveIdentifier           Identifier
hi! link octaveTab                  Error
hi! link matlabDelimiter            Delimiter
hi! link matlabCellComment          Title
hi! link matlabCellCommentIndented  Title

" vim {{{2
hi! link vimCommentTitle            Title
hi! link vimScriptDelim             Todo

" python {{{2
hi! link pythonAttribute            Type
" hi! link pythonBuiltin              Type

" javascript {{{2
hi! link jsBrackets                 Delimiter
hi! link jsObjectBraces             Delimiter
hi! link jsFuncBraces               Delimiter
hi! link jsIfElseBraces             Statement
hi! link jsObjectKey                Identifier

" go {{{2
hi! link goPackage                  Include
hi! link goImport                   Include

" vim-json {{{2
call s:h('jsonKeyword',             {'fg': s:blue})
call s:h('jsonNull',                {'fg': s:brown})
call s:h('jsonBraces',              {'fg': s:fg})

" sql {{{2
hi! link sqlStatement PreProc
hi! link sqlKeyword PreProc
hi! link sqlOperator Special
hi! link sqlFunction Statement
hi! link Quote String

" Plugins {{{1
" Fugitive {{{2
call s:h('fugitiveUnstagedModifier',  {'fg': s:red})
call s:h('fugitiveStagedModifier',    {'fg': s:green})
hi! link fugitiveHeading              PreProc
hi! link fugitiveHeader               PreProc
hi! link fugitiveSymbolicRef          Conditional
hi! link fugitiveCount                Todo
hi! link diffSubName                  Identifier
call s:h('diffAdded',                 {'fg': s:green})
call s:h('diffRemoved',               {'fg': s:red})
call s:h('diffChanged',               {'fg': s:blue})
call s:h('diffLine',                  {'fg': s:yellow, 'gui': 'reverse', 'cterm': 'reverse'})

" GV.vim {{{2
" hi! link gvSha                      Delimiter
hi! link gvAuthor                   Comment
hi! link gvTag                      Tag
hi! link gvGitHub                   PreProc
hi! link gvJira                     PreProc
call s:h('gvHead',                  {'fg': s:pink})
call s:h('gvOrigin',                {'fg': s:blue_light})

" flog {{{2
hi! link flogAuthor                 Comment
hi! link flogHash                   Comment
hi! link flogRefTag                 Tag
call s:h('flogRefHead',             {'fg': s:pink})
hi! link flogRefHeadBranch          flogRefHead
call s:h('flogGraphEdge1',          {'fg': s:blue_light})
call s:h('flogGraphEdge2',          {'fg': s:pink})
call s:h('flogGraphEdge3',          {'fg': s:purple})
call s:h('flogGraphEdge4',          {'fg': s:yellow})
call s:h('flogGraphEdge5',          {'fg': s:green_light})

" GitGutter / Signify {{{2
call s:h('GitGutterAdd',            {'fg': s:green_light})
call s:h('GitGutterChange',         {'fg': s:blue_light})
call s:h('GitGutterDelete',         {'fg': s:red})
call s:h('GitGutterChangeDelete',   {'fg': s:orange})
call s:h('GitGutterAddLine',        {'fg': s:bg, 'bg': s:green})
call s:h('GitGutterChangeLine',     {'fg': s:bg, 'bg': s:blue})
call s:h('GitGutterDeleteLine',     {'fg': s:bg, 'bg': s:red})
call s:h('GitGutterChangeDeleteLine', {'fg': s:bg, 'bg': s:orange})

" gitsigns.nvim
call s:h('GitSignsAdd',             {'fg': s:green_light})
call s:h('GitSignsChange',          {'fg': s:blue_light})
call s:h('GitSignsDelete',          {'fg': s:red})
call s:h('GitSignsChangeDelete',    {'fg': s:orange})

" netrw {{{2
call s:h('netrwClassify',           {'fg': s:fg_com})
call s:h('netrwSymLink',            {'fg': s:cyan})
call s:h('netrwExe',                {'fg': s:pink})

" vim-dirvish-git
hi link DirvishGitModified Type
hi link DirvishGitStaged Statement
hi link DirvishGitRenamed Identifier
hi link DirvishGitUnmerged Debug
hi link DirvishGitIgnored Comment
hi link DirvishGitUntracked Operator

" telescope.nvim {{{2
hi! link TelescopeMatching          Todo
hi! link TelescopeSelection         PmenuSel

" nvim-lspconfig {{{2
hi! link DiagnosticSignErrorNr            ErrorMsg
hi! link DiagnosticSignWarnNr             WarningMsg
call s:h('DiagnosticSignHintNr',          {'fg': s:blue, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})

" nvim-tree.lua {{{2
call s:h('NvimTreeSymlink',       {'fg': s:cyan})
call s:h('NvimTreeFolderIcon',    {'fg': s:blue})
call s:h('NvimTreeRootFolder',    {'fg': s:blue_light})
call s:h('NvimTreeExecFile',      {'fg': s:purple})
hi! link NvimTreeSpecialFile      Special
call s:h('NvimTreeWindowPicker',  {'fg': s:bg, 'bg': s:pink})
call s:h('NvimTreeImageFile',     {'fg': s:purple})
call s:h('NvimTreeOpenedFile',    {'fg': s:yellow})
call s:h('NvimTreeGitDirty',      {'fg': s:red})
call s:h('NvimTreeGitDeleted',    {'fg': s:red})
call s:h('NvimTreeGitStaged',     {'fg': s:green})
call s:h('NvimTreeGitMerge',      {'fg': s:orange})
call s:h('NvimTreeGitRenamed',    {'fg': s:yellow})
call s:h('NvimTreeIndentMarker',  {'fg': s:fg_com})
call s:h('NvimTreeGitNew',        {'fg': s:fg_light})
