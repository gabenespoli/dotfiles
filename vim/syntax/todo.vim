" titles {{{1
syntax match TodoTitle          /^\/\/.*$/ contains=TodoProject,TodoDue
syntax match TodoTitle          /^##.*$/ contains=TodoProject,TodoDue
syntax match TodoTitle          /^#.*$/ contains=TodoProject,TodoDue

" bullets {{{1
syntax match TodoTodoChar       /^\s*-\ /
syntax match TodoTodo           /^\s*-\ .*$/ contains=TodoTodoChar,TodoProject,TodoContext,TodoWaiting,TodoURL,TodoMIDA
syntax match TodoDoneChar       /^\s*x\ /
syntax match TodoDone           /^\s*x\ .*$/ contains=TodoDoneChar
syntax match TodoDoingChar      /^\s*\*\ /
syntax match TodoDoing          /^\s*\*\ .*$/ contains=TodoDoingChar,TodoProject,TodoContext,TodoWaiting,TodoURL,TodoDue,TodoMIDA
syntax match TodoExclaimChar    /^\s*!\ /
syntax match TodoExclaim        /^\s*!\ .*$/ contains=TodoExclaimChar,TodoProject,TodoContext,TodoWaiting,TodoURL,TodoMIDA
syntax match TodoCommentChar    /^\s*>\ /
syntax match TodoComment        /^\s*>\ .*$/ contains=TodoCommentChar,TodoProject,TodoContext,TodoWaiting,TodoURL,TodoMIDA
syntax match TodoWaitingChar    /^\s*?\ /
syntax match TodoWaiting        /^\s*?\ .*$/ contains=TodoWaitingChar,TodoProject,TodoContext,TodoWaiting,TodoURL,TodoMIDA

" tick-box versions
syntax match TodoTickBox        /^\s*-\ \[\ \]\ /
syntax match TodoTickBoxDone    /^\s*-\ \[x\]\ /
syntax match TodoTickBoxDoing   /^\s*-\ \[\*\]\ /
syntax match TodoTickBoxExclaim /^\s*-\ \[!\]\ /
syntax match TodoTickBoxComment /^\s*-\ \[>\]\ /

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
syntax match TodoMIDA           /MIDA-\d*/

" priorities (todo.txt) {{{1
syntax match TodoPriorityAChar  /^\s*(A)\ /
syntax match TodoPriorityBChar  /^\s*(B)\ /
syntax match TodoPriorityCChar  /^\s*(C)\ /
syntax match TodoPriorityDChar  /^\s*(D)\ /
syntax match TodoPriorityA      /^\s*(A)\ .*$/ contains=TodoPriorityAChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL
syntax match TodoPriorityB      /^\s*(B)\ .*$/ contains=TodoPriorityBChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL
syntax match TodoPriorityC      /^\s*(C)\ .*$/ contains=TodoPriorityCChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL
syntax match TodoPriorityD      /^\s*(D)\ .*$/ contains=TodoPriorityDChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL

" highlight today's date
let today = strftime('%Y-%m-%d')
execute 'syn match TodoDateToday /' . today . '/'

" default highlights {{{1
hi def link TodoTitle           Title
" hi def link TodoSubTitle        markdownBoldItalic

hi def link TodoTodoChar        Normal
hi def link TodoTodo            Normal
hi def link TodoDoneChar        Special
hi def link TodoDone            Comment
hi def link TodoDoingChar       Statement
hi def link TodoDoing           Normal
hi def link TodoExclaimChar     Todo
hi def link TodoExclaim         Todo
hi def link TodoCommentChar     Type
hi def link TodoComment         Comment
hi def link TodoWaitingChar     Error
hi def link TodoWaiting         Normal

hi def link TodoTickBox         TodoTodo
hi def link TodoTickBoxDone     TodoDone
hi def link TodoTickBoxDoing    TodoDoing
hi def link TodoTickBoxExclaim  TodoExclaim
hi def link TodoTickBoxComment  TodoComment

hi def link TodoProject         Identifier
" hi def link TodoKey             Identifier
" hi def link TodoPoints          Identifier
hi def link TodoMIDA            Constant
hi def link TodoDue             DiffAdd
hi def link TodoURL             markdownItalic

hi def link TodoContext         Special
hi def link TodoWaiting         TodoContext
hi def link TodoNext            TodoContext

hi def link TodoDate            Normal
hi def link TodoDateToday       ErrorMsg

hi def link TodoPriorityAChar   Todo
hi def link TodoPriorityBChar   Constant
hi def link TodoPriorityCChar   Identifier
hi def link TodoPriorityDChar   Type
hi def link TodoPriorityA       TodoPriorityAChar
hi def link TodoPriorityB       TodoPriorityBChar
hi def link TodoPriorityC       TodoPriorityCChar
hi def link TodoPriorityD       TodoPriorityDChar
