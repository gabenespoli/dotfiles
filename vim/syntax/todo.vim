" titles {{{1
syntax match TodoTitle          /^\/\/.*$/ contains=TodoProject,TodoDue
syntax match TodoTitle          /^##.*$/ contains=TodoProject,TodoDue
syntax match TodoTitle          /^#.*$/ contains=TodoProject,TodoDue

" bullets {{{1
syntax match TodoTodoChar       /^\s*-\ /
syntax match TodoTodo           /^\s*-\ .*$/ contains=TodoTodoChar,TodoProject,TodoContext,TodoWaiting,TodoURL,TodoJIRA
syntax match TodoDoneChar       /^\s*x\ /
syntax match TodoDone           /^\s*x\ .*$/ contains=TodoDoneChar
syntax match TodoDoingChar      /^\s*\*\ /
syntax match TodoDoing          /^\s*\*\ .*$/ contains=TodoDoingChar,TodoProject,TodoContext,TodoWaiting,TodoURL,TodoDue,TodoJIRA
syntax match TodoWaitChar    /^\s*@\ /
syntax match TodoWait        /^\s*@\ .*$/ contains=TodoWaitChar,TodoProject,TodoContext,TodoWaiting,TodoURL,TodoJIRA
syntax match TodoCommentChar    /^\s*>\ /
syntax match TodoComment        /^\s*>\ .*$/ contains=TodoCommentChar,TodoProject,TodoContext,TodoWaiting,TodoURL,TodoJIRA
syntax match TodoWaitingChar    /^\s*?\ /
syntax match TodoWaiting        /^\s*?\ .*$/ contains=TodoWaitingChar,TodoProject,TodoContext,TodoWaiting,TodoURL,TodoJIRA
syntax match TodoPushChar       /^\s*\$\ /
syntax match TodoPush           /^\s*\$\ .*$/ contains=TodoPushChar,TodoProject,TodoContext,TodoWaiting,TodoURL,TodoJIRA

" tick-box versions
syntax match TodoTickBox        /^\s*-\ \[\ \]\ /
syntax match TodoTickBoxDone    /^\s*-\ \[x\]\ /
syntax match TodoTickBoxDoing   /^\s*-\ \[\*\]\ /
syntax match TodoTickBoxWait /^\s*-\ \[@\]\ /
syntax match TodoTickBoxPush    /^\s*-\ \[$\]\ /

syntax match TodoBox            /^\s*\[\ \]\ /
syntax match TodoBoxDoneChar    /^\s*\[x\]\ /
syntax match TodoBoxDone        /^\s*\[x\]\ .*$/ contains=TodoBoxDoneChar

" tags {{{1
syntax match TodoProject            /+\S*\>/
" syntax match TodoKey            /\S*:\S*/
" syntax match TodoPoints         /pts:\d*/
syntax match TodoDue            /due:\d\d\d\d-\d\d-\d\d/
syntax match TodoURL            /http[s]\?:\/\/\S*/
" syntax match TodoSubTitle       /^.*:$/

syntax match TodoContext        /@\S*\>/
syntax match TodoWaiting        /@waiting/

syntax match TodoDate           /\d\d\d\d-\d\d-\d\d/

" custom mida tags
syntax match TodoJIRA           /\[\u\+-\d\+\]/

" priorities (todo.txt) {{{1
syntax match TodoPriorityAChar  /^\s*(A)\ /
syntax match TodoPriorityBChar  /^\s*(B)\ /
syntax match TodoPriorityCChar  /^\s*(C)\ /
syntax match TodoPriorityDChar  /^\s*(D)\ /
syntax match TodoPriorityA      /^\s*(A)\ .*$/ contains=TodoPriorityAChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL,TodoJIRA
syntax match TodoPriorityB      /^\s*(B)\ .*$/ contains=TodoPriorityBChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL,TodoJIRA
syntax match TodoPriorityC      /^\s*(C)\ .*$/ contains=TodoPriorityCChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL,TodoJIRA
syntax match TodoPriorityD      /^\s*(D)\ .*$/ contains=TodoPriorityDChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL,TodoJIRA
syntax match TodoPriorityM      /^\s*(M)\ .*$/ contains=TodoPriorityMChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL,TodoJIRA
syntax match TodoPriorityT      /^\s*(T)\ .*$/ contains=TodoPriorityTChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL,TodoJIRA
syntax match TodoPriorityW      /^\s*(W)\ .*$/ contains=TodoPriorityWChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL,TodoJIRA
syntax match TodoPriorityR      /^\s*(R)\ .*$/ contains=TodoPriorityRChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL,TodoJIRA
syntax match TodoPriorityF      /^\s*(F)\ .*$/ contains=TodoPriorityFChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL,TodoJIRA

" highlight today's date
let today = strftime('%Y-%m-%d')
execute 'syn match TodoDateToday /' . today . '/'

" default highlights {{{1
hi def link TodoTitle           Title
" hi def link TodoSubTitle        markdownBoldItalic

hi def link TodoTodoChar        Identifier
hi def link TodoTodo            Normal
hi def link TodoDoneChar        Special
hi def link TodoDone            Comment
hi def link TodoDoingChar       Statement
hi def link TodoDoing           Statement
hi def link TodoWaitChar        Constant
hi def link TodoWait            Constant
hi def link TodoCommentChar     Type
hi def link TodoComment         Comment
hi def link TodoWaitingChar     Error
hi def link TodoPushChar        NonText
hi def link TodoPush            Comment

hi def link TodoTickBox         TodoTodo
hi def link TodoTickBoxDone     TodoDone
hi def link TodoTickBoxDoing    TodoDoing
hi def link TodoTickBoxWait     TodoWait
hi def link TodoTickBoxComment  TodoComment

hi def link TodoBox             TodoTodoChar
hi def link TodoBoxDoneChar     TodoDoneChar
hi def link TodoBoxDone         TodoDone

hi def link TodoProject         Identifier
" hi def link TodoKey             Identifier
" hi def link TodoPoints          Identifier
hi def link TodoJIRA            Identifier
hi def link TodoDue             DiffAdd
hi def link TodoURL             markdownItalic

hi def link TodoContext         Constant
hi def link TodoWaiting         TodoContext
hi def link TodoNext            TodoContext

hi def link TodoDate            Normal
hi def link TodoDateToday       TodoDate

hi def link TodoPriorityAChar   Type
hi def link TodoPriorityBChar   Todo
hi def link TodoPriorityCChar   Normal
hi def link TodoPriorityDChar   Normal
hi def link TodoPriorityMChar   markdownItalic
hi def link TodoPriorityTChar   markdownItalic
hi def link TodoPriorityWChar   Constant
hi def link TodoPriorityRChar   markdownItalic
hi def link TodoPriorityFChar   markdownItalic
hi def link TodoPriorityA       TodoPriorityAChar
hi def link TodoPriorityB       TodoPriorityBChar
hi def link TodoPriorityC       TodoPriorityCChar
hi def link TodoPriorityD       TodoPriorityDChar
hi def link TodoPriorityM       TodoPriorityMChar
hi def link TodoPriorityT       TodoPriorityTChar
hi def link TodoPriorityW       TodoPriorityWChar
hi def link TodoPriorityR       TodoPriorityRChar
hi def link TodoPriorityF       TodoPriorityFChar
