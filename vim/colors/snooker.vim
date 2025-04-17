" Setup {{{1
hi clear

if exists('syntax on')
    syntax reset
endif

set background=dark
let g:colors_name='snooker'

if !exists('g:snooker_diff_high_contrast')
  let g:snooker_diff_high_contrast = 0
endif

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
let s:bg              = { 'gui': '#0f171b', 'cterm': 'NONE' }
let s:fg              = { 'gui': '#adad9b', 'cterm': 'NONE' }
let s:none            = { 'gui': 'NONE',    'cterm': 'NONE' }

let s:bg_light        = { 'gui': '#2b302b', 'cterm': '0'    }
let s:red             = { 'gui': '#e52e1a', 'cterm': '1'    }
let s:green           = { 'gui': '#1c9c40', 'cterm': '2'    }  " 1c9c20
let s:brown           = { 'gui': '#a57230', 'cterm': '3'    }
let s:blue            = { 'gui': '#0094cf', 'cterm': '4'    }
let s:purple          = { 'gui': '#8b72da', 'cterm': '5'    }  " 5e72d5
let s:cyan            = { 'gui': '#1dae87', 'cterm': '6'    }
let s:fg_light        = { 'gui': '#cdc08b', 'cterm': '7'    }

let s:fg_com          = { 'gui': '#6a6a5b', 'cterm': '8'    }
let s:orange          = { 'gui': '#ea901a', 'cterm': '9'    }  " e5941a
let s:green_light     = { 'gui': '#22bd4e', 'cterm': '10'   }  " 25c528
let s:yellow          = { 'gui': '#c89b13', 'cterm': '11'   }
let s:blue_light      = { 'gui': '#00a3cc', 'cterm': '12'   }
let s:pink            = { 'gui': '#df7376', 'cterm': '13'   }
let s:cyan_light      = { 'gui': '#4abe65', 'cterm': '14'   }
let s:fg_bright       = { 'gui': '#e5e5d2', 'cterm': '15'   }

let s:green_bg        = { 'gui': '#0b3e0c', 'cterm': '2'    }
let s:blue_bg         = { 'gui': '#003b52', 'cterm': '4'    }
let s:red_bg          = { 'gui': '#5b120a', 'cterm': '1'    }
let s:yellow_bg       = { 'gui': '#503e07', 'cterm': '11'   }

" let s:green_bg      = { 'gui': '#12261e', 'cterm': '2'    }
" let s:red_bg        = { 'gui': '#301a1f', 'cterm': '1'    }

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
if has('gui') || exists('g:gui_vimr')
  call s:h('Normal',         {'fg': s:fg, 'bg': s:bg})
else
  call s:h('Normal',         {'fg': s:fg})
endif
call s:h('Cursor',           {'fg': s:fg_light, 'cterm': 'reverse', 'gui': 'reverse'})
call s:h('Comment',          {'fg': s:fg_com, 'gui': 'italic', 'cterm': 'italic'})

call s:h('Constant',         {'fg': s:cyan_light})
call s:h('String',           {'fg': s:cyan})
hi! link Character           String
hi! link Number              String
hi! link Boolean             Constant
hi! link Float               String

call s:h('Identifier',       {'fg': s:blue})
hi! link Function            Identifier

call s:h('Statement',        {'fg': s:green})
hi! link Conditional         Statement
hi! link Repeat              Conditional
hi! link Label               Conditional
hi! link Operator            Normal
hi! link Keyword             Statement
call s:h('Exception',        {'fg': s:orange})

call s:h('PreProc',          {'fg': s:purple})
hi! link Include             PreProc
hi! link Define              PreProc
hi! link Macro               PreProc
hi! link PreCondit           PreProc

call s:h('Type',             {'fg': s:yellow})
call s:h('Structure',        {'fg': s:green})
hi! link StorageClass        Type
hi! link Typedef             Type

call s:h('Special',          {'fg': s:brown})
call s:h('SpecialChar',      {'fg': s:orange})
hi! link Tag                 SpecialChar
call s:h('Delimiter',        {'fg': s:fg_com})
hi! link SpecialComment      SpecialChar
hi! link Debug               SpecialChar

call s:h('Underlined',       {'gui': 'underline', 'cterm': 'underline'})
call s:h('Ignore',           {'fg': s:bg_light})
call s:h('Error',            {'fg': s:red})
call s:h('Todo',             {'fg': s:pink})

" Extra Groups {{{1
" ordered according to `:help hitest.vim`
call s:h('SpecialKey',       {'fg': s:fg})
call s:h('Whitespace',       {'fg': s:bg_light})
call s:h('EndOfBuffer',      {'fg': s:bg_light})
call s:h('NonText',          {'fg': s:bg_light})
call s:h('Directory',        {'fg': s:blue})
call s:h('ErrorMsg',         {'fg': s:fg_bright, 'bg': s:red})
call s:h('IncSearch',        {'fg': s:pink, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('Search',           {'fg': s:pink, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('MoreMsg',          {'fg': s:fg_com})
hi! link ModeMsg             MoreMsg

call s:h('LineNr',           {'fg': s:fg_com})
call s:h('CursorLineNr',     {'fg': s:fg, 'bg': s:bg_light})
call s:h('Question',         {'fg': s:green})
call s:h('StatusLine',       {'fg': s:bg_light, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('Conceal',          {'fg': s:fg})
call s:h('StatusLineNC',     {'fg': s:bg_light, 'bg': s:bg_light, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('VertSplit',        {'fg': s:bg_light, 'bg': s:bg})
call s:h('Title',            {'fg': s:fg_bright, 'bg': s:bg_light, 'gui': 'bold,italic', 'cterm': 'bold,italic'})
call s:h('Visual',           {'fg': s:fg_bright, 'bg': s:fg_com})
call s:h('VisualNOS',        {'fg': s:fg_bright, 'bg': s:fg_com})
call s:h('WarningMsg',       {'fg': s:orange, 'cterm': 'reverse', 'gui': 'reverse'})
call s:h('WildMenu',         {'fg': s:bg_light, 'bg': s:fg_bright})
call s:h('Folded',           {'bg': s:bg_light})
call s:h('FoldColumn',       {'fg': s:fg_light, 'bg': s:bg_light})
call s:h('SignColumn',       {'fg': s:fg})

if g:snooker_diff_high_contrast
  call s:h('DiffAdd',        {'fg': s:green, 'cterm': 'reverse', 'gui': 'reverse'})
  call s:h('DiffChange',     {'fg': s:blue, 'cterm': 'reverse', 'gui': 'reverse'})
  call s:h('DiffDelete',     {'fg': s:red, 'cterm': 'reverse', 'gui': 'reverse'})
  call s:h('DiffText',       {'fg': s:yellow, 'cterm': 'reverse', 'gui': 'reverse'})
else
  call s:h('DiffAdd',        {'bg': s:green_bg})
  call s:h('DiffChange',     {'bg': s:blue_bg})
  call s:h('DiffDelete',     {'bg': s:red_bg})
  call s:h('DiffText',       {'bg': s:yellow_bg})
endif

call s:h('Added',            {'fg': s:green_light})
call s:h('Changed',          {'fg': s:blue_light})
call s:h('Removed',          {'fg': s:red})

if has('gui_running') && g:snooker_gui_color_undercurl
  call s:h('SpellBad',       {'gui': s:sp_un, 'sp': s:red})
  call s:h('SpellCap',       {'gui': s:sp_un, 'sp': s:pink})
  call s:h('SpellRare',      {'gui': s:sp_un, 'sp': s:cyan})
  call s:h('SpellLocal',     {'gui': s:sp_un, 'sp': s:yellow})
else
  call s:h('SpellBad',       {'cterm': s:sp_un, 'gui': s:sp_un})
  call s:h('SpellCap',       {'cterm': s:sp_un, 'gui': s:sp_un})
  call s:h('SpellRare',      {'cterm': s:sp_un, 'gui': s:sp_un})
  call s:h('SpellLocal',     {'cterm': s:sp_un, 'gui': s:sp_un})
endif

call s:h('Pmenu',            {'fg': s:fg, 'bg': s:bg_light})
call s:h('PmenuSel',         {'fg': s:blue_light, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('PmenuSbar',        {'fg': s:fg, 'bg': s:bg_light})
call s:h('PmenuThumb',       {'fg': s:fg, 'bg': s:bg_light})
call s:h('TabLine',          {'fg': s:fg_com, 'bg': s:bg_light})
call s:h('TabLineSel',       {'fg': s:fg_com, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('TabLineFill',      {'fg': s:fg, 'bg': s:bg})
call s:h('CursorColumn',     {'bg': s:bg_light})
call s:h('CursorLine',       {'bg': s:bg_light})
call s:h('ColorColumn',      {'bg': s:bg_light})

" remainder of syntax highlighting
call s:h('MatchParen',       {'fg': s:fg_com, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('qfLineNr',         {'fg': s:fg})

" Treesitter {{{1
" hi! link @annotation
" hi! link @attribute
" hi! link @attribute.typescript
" hi! link @boolean               Boolean
" hi! link @character             Character
" hi! link @character.special     SpecialChar
" hi! link @comment               Comment
" hi! link @conditional           Conditional
" hi! link @constant              Constant
" hi! link @constant.builtin      Constant
" hi! link @constant.macro
hi! link @constructor           Type
" hi! link @danger
" hi! link @debug
" hi! link @define                Define
" hi! link @error                 Error
" hi! link @exception             Exception
" hi! link @field
" hi! link @float                 Float
" hi! link @function              Function
" hi! link @function.builtin      Function
" hi! link @function.call
" hi! link @function.macro
" hi! link @include               Include
" hi! link @keyword               Keyword
" hi! link @keyword.import
" hi! link @keyword.function
" hi! link @keyword.operator
" hi! link @keyword.return
" hi! link @label
" hi! link @method
" hi! link @method.call
call s:h('@module',             {'fg': s:fg})
" hi! link @namespace
" hi! link @none
" hi! link @note
" hi! link @number                Number
" hi! link @operator              Operator
hi! link @parameter             Special
" hi! link @parameter.reference
" hi! link @preproc               PreProc
" hi! link @property
" hi! link @punctuation.bracket
" hi! link @punctuation.delimiter
" hi! link @punctuation.special
" hi! link @repeat
" hi! link @storageclass          StorageClass
" hi! link @string                String
" hi! link @string.escape
" hi! link @string.regex
" hi! link @string.special
" hi! link @symbol
" hi! link @tag
" hi! link @tag.attribute
" hi! link @tag.delimiter
" hi! link @text
" hi! link @text.danger
" hi! link @text.diff.add
" hi! link @text.diff.delete
" hi! link @text.emphasis
" hi! link @text.environment
" hi! link @text.environment.name
" hi! link @text.literal
" hi! link @text.math
" hi! link @text.note
" hi! link @text.reference
" hi! link @text.strike
" hi! link @text.strong
" hi! link @text.title
" hi! link @text.todo
" hi! link @text.underline
" hi! link @text.uri
" hi! link @text.warning
" hi! link @type                  Type
call s:h('@type.builtin',       {'fg': s:brown})
" hi! link @type.definition
" hi! link @type.qualifier
hi! link @variable              Normal
hi! link @variable.builtin      Normal
hi! link @variable.parameter    PreProc
hi! link @warning               WarningMsg

" my own extras {{{1
" call s:h('Modified',      {'fg': s:yellow, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
" call s:h('ReadOnly',      {'fg': s:brown,  'bg': s:fg_com, 'gui': 'reverse', 'cterm': 'reverse'})
" call s:h('StatusTodo',    {'fg': s:pink,   'bg': s:bg_light, 'gui': 'reverse', 'cterm': 'reverse'})
" call s:h('StatusError',   {'fg': s:red,    'bg': s:bg_light, 'gui': 'reverse', 'cterm': 'reverse'})
" call s:h('StatusPreview', {'fg': s:blue,   'bg': s:bg_light, 'gui': 'reverse', 'cterm': 'reverse'})
" call s:h('StatusFunction',{'fg': s:fg_com, 'bg': s:fg_light, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('StatusGit',       {'fg': s:bg_light, 'bg': s:green_light, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('StatusFilename',  {'fg': s:bg_light, 'bg': s:blue_light, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('StatusPywhere',   {'fg': s:bg_light, 'bg': s:purple, 'gui': 'reverse', 'cterm': 'reverse'})
" hi! link TabMod           Modified
" hi! link TabModSel        TabMod
hi! link markdownPandocCitation pandocCiteKey
call s:h('Italic',        {'fg': s:fg_light, 'gui': 'italic', 'cterm': 'italic'})
call s:h('Bold',          {'fg': s:fg_light, 'gui': 'bold', 'cterm': 'bold'})
call s:h('BoldItalic',    {'fg': s:fg_light, 'gui': 'bold,italic', 'cterm': 'bold,italic'})
call s:h('FloatBorder',   {'fg': s:fg_com})

" Syntaxes {{{1

" Shell {{{2
hi! link shQuote                       String
hi! link zshVariableDef                Identifier
hi! link zshOperator                   Operator

" Markdown {{{2
hi! link markdownHeadingDelimiter      Title
" call s:h('markdownItalic',             {'fg': s:fg_light, 'gui': 'italic', 'cterm': 'italic'})
" call s:h('markdownBold',               {'fg': s:fg_light, 'gui': 'bold', 'cterm': 'bold'})
" call s:h('markdownBoldItalic',         {'fg': s:fg_light, 'gui': 'bold,italic', 'cterm': 'bold,italic'})
hi! link markdownItalic                Italic
hi! link markdownBold                  Bold
hi! link markdownBoldItalic            BoldItalic
hi! link markdownItalicDelimiter       Comment
hi! link markdownBoldDelimiter         Comment
hi! link markdownBoldItalicDelimiter   Comment
hi! link markdownLinkDelimiter         Comment
hi! link markdownLinkTextDelimiter     Comment
call s:h('markdownLinkText',           {'fg': s:blue, 'gui': 'italic', 'cterm': 'italic'})
call s:h('markdownUrl',                {'fg': s:brown, 'gui': 'italic', 'cterm': 'italic'})
" hi! link markdownUrlTitle              pandocLinkTip
hi! link markdownUrlTitleDelimiter     markdownUrlTitle
hi! link markdownCode                  Constant
call s:h('markdownCodeDelimiter',      {'fg': s:fg_light})

" Pandoc Markdown {{{2
hi! link pandocAtxStart                markdownHeadingDelimiter
hi! link pandocEmphasis                markdownItalic
hi! link pandocStrong                  markdownBold
hi! link pandocStrongEmphasis          markdownBoldItalic
hi! link pandocEmphasisInStrong        markdownBoldItalic

hi! link pandocOperator                Comment
hi! link pandocReferenceLabel          markdownLinkText
hi! link pandocReferenceURL            markdownUrl
hi! link pandocLinkTip                 markdownUrlTitle

hi! link pandocImageIcon               Delimiter
hi! link pandocCiteLocator             Delimiter
hi! link pandocFootnoteIDHead          Delimiter
hi! link pandocFootnoteIDTail          Delimiter

call s:h('pandocCiteKey',              {'fg': s:blue, 'gui': 'italic', 'cterm': 'italic'})
hi! link pandocCiteAnchor              pandocCiteKey
hi! link pandocPCite                   pandocCiteKey
hi! link pandocICite                   pandocCiteKey
hi! link pandocFootnoteID              pandocCiteKey
" code
hi! link pandocNoFormatted             pandocCiteKey

" Critic Markup {{{2
hi! link criticAdd                     DiffAdd
hi! link criticDel                     DiffDelete
hi! link criticHighlighter             DiffText
hi! link criticsMeta                   DiffChange

" Octave/Matlab {{{2
hi! link octaveDelimiter               Delimiter
hi! link octaveSemicolon               Normal
hi! link octaveBlockComment            Title
hi! link octaveVariable                Identifier
hi! link octaveOperator                Operator
hi! link octaveIdentifier              Identifier
hi! link octaveTab                     Error
hi! link matlabDelimiter               Delimiter
hi! link matlabCellComment             Title
hi! link matlabCellCommentIndented     Title

" vim {{{2
hi! link vimCommentTitle               Title
hi! link vimScriptDelim                Todo

" python {{{2
hi! link pythonAttribute               Type
" hi! link pythonBuiltin                 Type

" javascript {{{2
hi! link jsBrackets                    Delimiter
hi! link jsObjectBraces                Delimiter
hi! link jsFuncBraces                  Delimiter
hi! link jsIfElseBraces                Statement
hi! link jsObjectKey                   Identifier

" go {{{2
hi! link goPackage                     Include
hi! link goImport                      Include

" vim-json {{{2
call s:h('jsonKeyword',                {'fg': s:blue})
call s:h('jsonNull',                   {'fg': s:brown})
call s:h('jsonBraces',                 {'fg': s:fg})

" sql {{{2
call s:h('sqlStatement',               {'fg': s:green_light})
hi! link sqlKeyword                    Identifier
hi! link sqlOperator                   PreProc
hi! link sqlFunction                   Function
hi! link sqlSpecial                    Constant
hi! link Quote                         String
hi! link sqlFold                       String

" Plugins {{{1
" Fugitive {{{2
call s:h('fugitiveUnstagedModifier',   {'fg': s:red})
call s:h('fugitiveStagedModifier',     {'fg': s:green_light})
hi! link fugitiveHeading               PreProc
hi! link fugitiveHeader                PreProc
hi! link fugitiveSymbolicRef           Label
hi! link fugitiveCount                 Todo
call s:h('diffLine',                   {'fg': s:purple, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('diffSubName',                {'fg': s:purple, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('diffIndexLine',              {'fg': s:cyan, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('diffFile',                   {'fg': s:cyan, 'gui': 'reverse', 'cterm': 'reverse'})
hi! link diffAdded                     DiffAdd
hi! link diffRemoved                   DiffDelete
hi! link diffChanged                   DiffChange

" GV.vim {{{2
" hi! link gvSha                         Delimiter
hi! link gvAuthor                      Comment
hi! link gvTag                         Tag
hi! link gvGitHub                      PreProc
hi! link gvJira                        PreProc
call s:h('gvHead',                     {'fg': s:pink})
call s:h('gvOrigin',                   {'fg': s:blue_light})

" flog {{{2
hi! link flogAuthor                    Comment
hi! link flogHash                      Identifier
hi! link flogRef                       Label
hi! link flogRefTag                    Tag
call s:h('flogRefHead',                {'fg': s:pink})
hi! link flogRefHeadBranch             flogRefHead
call s:h('flogBranch1',                {'fg': s:blue_light})
call s:h('flogBranch2',                {'fg': s:pink})
call s:h('flogBranch3',                {'fg': s:purple})
call s:h('flogBranch4',                {'fg': s:yellow})
call s:h('flogBranch5',                {'fg': s:green_light})
call s:h('flogBranch6',                {'fg': s:brown})
call s:h('flogBranch7',                {'fg': s:orange})
call s:h('flogBranch8',                {'fg': s:cyan_light})

" GitGutter / Signify / GitSigns.nvim {{{2
call s:h('GitGutterAdd',               {'fg': s:green_light})
call s:h('GitGutterChange',            {'fg': s:blue_light})
call s:h('GitGutterDelete',            {'fg': s:red})
call s:h('GitGutterChangeDelete',      {'fg': s:orange})
call s:h('GitGutterAddLine',           {'fg': s:green, 'cterm': 'reverse', 'gui': 'reverse'})
call s:h('GitGutterChangeLine',        {'fg': s:blue, 'cterm': 'reverse', 'gui': 'reverse'})
call s:h('GitGutterDeleteLine',        {'fg': s:red, 'cterm': 'reverse', 'gui': 'reverse'})
call s:h('GitGutterChangeDeleteLine',  {'fg': s:orange, 'cterm': 'reverse', 'gui': 'reverse'})

call s:h('GitSignsAdd',                {'fg': s:green_light})
call s:h('GitSignsChange',             {'fg': s:blue_light})
call s:h('GitSignsDelete',             {'fg': s:red})
call s:h('GitSignsChangeDelete',       {'fg': s:orange})
call s:h('GitSignsAddLn',              {'fg': s:green, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('GitSignsChangeLn',           {'fg': s:blue, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('GitSignsDeleteLn',           {'fg': s:red, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('GitSignsChangeDeleteLn',     {'fg': s:orange, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('GitSignsAddNr',              {'fg': s:green, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('GitSignsChangeNr',           {'fg': s:blue, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('GitSignsDeleteNr',           {'fg': s:red, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('GitSignsChangeDeleteNr',     {'fg': s:orange, 'gui': 'reverse', 'cterm': 'reverse'})

" call s:h('GitSignsAddStagedLn',           {'bg': s:green_bg, 'fg': s:bg})
" call s:h('GitSignsChangeStagedLn',        {'bg': s:blue_bg, 'fg': s:bg})
" call s:h('GitSignsDeleteStagedLn',        {'bg': s:red_bg, 'fg': s:bg})
" call s:h('GitSignsChangeDeleteStagedLn',  {'bg': s:yellow_bg, 'fg': s:bg})
" call s:h('GitSignsAddStagedLn',           {'fg': s:green_bg, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
" call s:h('GitSignsChangeStagedLn',        {'fg': s:blue_bg, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
" call s:h('GitSignsDeleteStagedLn',        {'fg': s:red_bg, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})
" call s:h('GitSignsChangeDeleteStagedLn',  {'fg': s:yellow_bg, 'bg': s:bg, 'gui': 'reverse', 'cterm': 'reverse'})

" dadbod-ui  {{{2
hi! link NotificationInfo              PmenuSel
hi! link NotificationError             ErrorMsg
hi! link NotificationWarning           WarningMsg
hi! link EchoNotificationInfo          Keyword
hi! link EchoNotificationError         Error
hi! link EchoNotificationWarning       Exception

" netrw {{{2
call s:h('netrwClassify',              {'fg': s:fg_com})
call s:h('netrwSymLink',               {'fg': s:cyan})
call s:h('netrwExe',                   {'fg': s:pink})

" vim-dirvish-git
hi link DirvishGitModified             Type
hi link DirvishGitStaged               Statement
hi link DirvishGitRenamed              Identifier
hi link DirvishGitUnmerged             Debug
hi link DirvishGitIgnored              Comment
hi link DirvishGitUntracked            Operator

" telescope.nvim {{{2
hi! link TelescopeMatching             Todo
hi! link TelescopeSelection            PmenuSel

" nvim-lspconfig {{{2
hi! link DiagnosticSignError           ErrorMsg
hi! link DiagnosticSignWarn            WarningMsg
call s:h('DiagnosticSignInfo',         {'fg': s:bg_light, 'bg': s:blue_light, 'gui': 'reverse', 'cterm': 'reverse'})
call s:h('DiagnosticSignHint',         {'fg': s:bg_light, 'bg': s:purple, 'gui': 'reverse', 'cterm': 'reverse'})
hi! link DiagnosticSignErrorNr         DiagnosticSignError
hi! link DiagnosticSignWarnNr          DiagnosticSignWarn
hi! link DiagnosticSignInfoNr          DiagnosticSignInfo
hi! link DiagnosticSignHintNr          DiagnosticSignHint

" nvim-tree.lua {{{2
call s:h('NvimTreeSymlink',            {'fg': s:cyan})
call s:h('NvimTreeFolderIcon',         {'fg': s:blue})
call s:h('NvimTreeRootFolder',         {'fg': s:blue_light})
call s:h('NvimTreeExecFile',           {'fg': s:purple})
hi! link NvimTreeSpecialFile           Special
call s:h('NvimTreeWindowPicker',       {'fg': s:pink, 'cterm': 'reverse', 'gui': 'reverse'})
call s:h('NvimTreeImageFile',          {'fg': s:purple})
call s:h('NvimTreeOpenedFile',         {'fg': s:yellow})
call s:h('NvimTreeGitDirty',           {'fg': s:red})
call s:h('NvimTreeGitDeleted',         {'fg': s:red})
call s:h('NvimTreeGitStaged',          {'fg': s:green})
call s:h('NvimTreeGitMerge',           {'fg': s:orange})
call s:h('NvimTreeGitRenamed',         {'fg': s:yellow})
call s:h('NvimTreeIndentMarker',       {'fg': s:fg_com})
call s:h('NvimTreeGitNew',             {'fg': s:fg_light})
