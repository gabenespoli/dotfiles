" titles {{{1
syntax match TodoTitle          /^\/\/.*$/
syntax match TodoTitle          /^##.*$/
syntax match TodoTitle          /^#.*$/

" bullets {{{1
syntax match TodoTodoChar       /^\s*-\ /
syntax match TodoTodo           /^\s*-\ .*$/ contains=TodoTodoChar,TodoProject,TodoContext,TodoWaiting
syntax match TodoDoneChar       /^\s*x\ /
syntax match TodoDone           /^\s*x\ .*$/ contains=TodoDoneChar
syntax match TodoDoingChar      /^\s*\*\ /
syntax match TodoDoing          /^\s*\*\ .*$/ contains=TodoDoingChar,TodoProject,TodoContext,TodoWaiting
syntax match TodoExclaimChar    /^\s*!\ /
syntax match TodoExclaim        /^\s*!\ .*$/ contains=TodoActionChar,TodoProject,TodoContext,TodoWaiting
syntax match TodoCommentChar    /^\s*>\ /
syntax match TodoComment        /^\s*>\ .*$/ contains=TodoCommentChar,TodoProject,TodoContext,TodoWaiting

" tick-box versions
syntax match TodoTickBox        /^\s*-\ \[\ \]\ /
syntax match TodoTickBoxDone    /^\s*-\ \[x\]\ /
syntax match TodoTickBoxDoing   /^\s*-\ \[\*\]\ /
syntax match TodoTickBoxExclaim /^\s*-\ \[!\]\ /
syntax match TodoTickBoxComment /^\s*-\ \[>\]\ /

" tags {{{1
syntax match TodoProject            /+\S*/
" syntax match TodoKey            /\S*:\S*/
" syntax match TodoPoints         /pts:\d*/
syntax match TodoDue            /due:\d\d\d\d-\d\d-\d\d/
" syntax match TodoURL            /http:\/\/\S*/
syntax match TodoTitle          /^.*:$/

syntax match TodoContext        /@\S*/
syntax match TodoWaiting        /@waiting/

syntax match TodoDate           /\d\d\d\d-\d\d-\d\d/

" priorities (todo.txt) {{{1
syntax match TodoPriorityAChar  /^(A)\ /
syntax match TodoPriorityBChar  /^(B)\ /
syntax match TodoPriorityCChar  /^(C)\ /
syntax match TodoPriorityDChar  /^(D)\ /
syntax match TodoPriorityA      /^(A)\ .*$/ contains=TodoPriorityAChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL
syntax match TodoPriorityB      /^(B)\ .*$/ contains=TodoPriorityBChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL
syntax match TodoPriorityC      /^(C)\ .*$/ contains=TodoPriorityCChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL
syntax match TodoPriorityD      /^(D)\ .*$/ contains=TodoPriorityDChar,TodoContext,TodoWaiting,TodoProject,TodoKey,TodoPoints,TodoDue,TodoURL

" day of the week priorities
" TODO: add char to day of week priorities
" link highlight to B/C priority based on current day of week
let day = strftime('%u')
if day == 1
  syn match TodoPriorityB /^(M).*$/ contains=TodoContext,TodoProject
  syn match TodoPriorityC /^(T).*$/ contains=TodoContext,TodoProject
elseif day == 2
  syn match TodoPriorityB /^(T).*$/ contains=TodoContext,TodoProject
  syn match TodoPriorityC /^(W).*$/ contains=TodoContext,TodoProject
elseif day == 3
  syn match TodoPriorityB /^(W).*$/ contains=TodoContext,TodoProject
  syn match TodoPriorityC /^(R).*$/ contains=TodoContext,TodoProject
elseif day == 4
  syn match TodoPriorityB /^(R).*$/ contains=TodoContext,TodoProject
  syn match TodoPriorityC /^(F).*$/ contains=TodoContext,TodoProject
elseif day == 5
  syn match TodoPriorityB /^(F).*$/ contains=TodoContext,TodoProject
  syn match TodoPriorityC /^(S).*$/ contains=TodoContext,TodoProject
elseif day == 6
  syn match TodoPriorityB /^(S).*$/ contains=TodoContext,TodoProject
  syn match TodoPriorityC /^(U).*$/ contains=TodoContext,TodoProject
elseif day == 7
  syn match TodoPriorityB /^(U).*$/ contains=TodoContext,TodoProject
  syn match TodoPriorityC /^(M).*$/ contains=TodoContext,TodoProject
endif

" highlight today's date
let today = strftime('%Y-%m-%d')
execute 'syn match TodoDateToday /' . today . '/'

" default highlights {{{1
hi def link TodoTitle           Title

hi def link TodoTodoChar        Operator
hi def link TodoTodo            Normal
hi def link TodoDoneChar        Comment
hi def link TodoDone            Comment
hi def link TodoDoingChar       Constant
hi def link TodoDoing           Constant
hi def link TodoExclaimChar     Error
hi def link TodoExclaim         Error
hi def link TodoCommentChar     Type
hi def link TodoComment         Comment

hi def link TodoTickBox         TodoTodo
hi def link TodoTickBoxDone     TodoDone
hi def link TodoTickBoxDoing    TodoDoing
hi def link TodoTickBoxExclaim  TodoExclaim
hi def link TodoTickBoxComment  TodoComment

hi def link TodoProject         Statement
" hi def link TodoKey             Identifier
" hi def link TodoPoints          Identifier
hi def link TodoDue             Identifier
" hi def link TodoURL             TodoDone

hi def link TodoContext         Type
hi def link TodoWaiting         TodoContext
hi def link TodoNext            TodoContext

hi def link TodoDate            Normal
hi def link TodoDateToday       ErrorMsg

hi def link TodoPriorityAChar   Error
hi def link TodoPriorityBChar   Special
hi def link TodoPriorityCChar   Constant
hi def link TodoPriorityDChar   Function
hi def link TodoPriorityA       TodoPriorityAChar
hi def link TodoPriorityB       TodoPriorityBChar
hi def link TodoPriorityC       TodoPriorityCChar
hi def link TodoPriorityD       TodoPriorityDChar
