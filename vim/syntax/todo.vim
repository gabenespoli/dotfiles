" titles {{{1
syntax match TodoTitle          /^\/\/.*$/
syntax match TodoTitle          /^##.*$/
syntax match TodoTitle          /^#.*$/
syntax match TodoTitle          /^.*:$/

" bullets {{{1
syntax match TodoTodoChar       /^\s*-\ /
syntax match TodoTodo           /^\s*-\ .*$/ contains=TodoTodoChar,TodoTag,TodoContext,TodoWaiting
syntax match TodoDoneChar       /^\s*x\ /
syntax match TodoDone           /^\s*x\ .*$/ contains=TodoDoneChar
syntax match TodoDoingChar      /^\s*\*\ /
syntax match TodoDoing          /^\s*\*\ .*$/ contains=TododoingChar,TodoTag,TodoContext,TodoWaiting
syntax match TodoExclaimChar    /^\s*!\ /
syntax match TodoExclaim        /^\s*!\ .*$/ contains=TodoActionChar,TodoTag,TodoContext,TodoWaiting
syntax match TodoCommentChar    /^\s*>\ /
syntax match TodoComment        /^\s*>\ .*$/ contains=TodoCommentChar,TodoTag,TodoContext,TodoWaiting

" tick-box versions
syntax match TodoTickBox        /^\s*-\ \[\ \]\ /
syntax match TodoTickBoxDone    /^\s*-\ \[x\]\ /
syntax match TodoTickBoxDoing   /^\s*-\ \[\*\]\ /
syntax match TodoTickBoxExclaim /^\s*-\ \[!\]\ /
syntax match TodoTickBoxComment /^\s*-\ \[>\]\ /

" tags {{{1
syntax match TodoTag            /+\S*/
syntax match TodoKey            /\S*:\S*/
syntax match TodoPoints         /pts:\d*/

syntax match TodoContext        /@\S*/
syntax match TodoWaiting        /@waiting/

syntax match TodoDate           /\d\d\d\d-\d\d-\d\d/

" priorities (todo.txt) {{{1
syntax match TodoPriorityAChar  /^(A)\ $/ contains=TodoContext,TodoTag
syntax match TodoPriorityBChar  /^(B)\ $/ contains=TodoContext,TodoTag,
syntax match TodoPriorityCChar  /^(C)\ $/ contains=TodoContext,TodoTag
syntax match TodoPriorityA      /^(A)\ .*$/ contains=TodoContext,TodoTag,TodoPriorityA
syntax match TodoPriorityB      /^(B)\ .*$/ contains=TodoContext,TodoTag,TodoPriorityB
syntax match TodoPriorityC      /^(C)\ .*$/ contains=TodoContext,TodoTag,TodoPriorityC

" day of the week priorities
" TODO: add char to day of week priorities
" link highlight to B/C priority based on current day of week
let day = strftime('%u')
if day == 1
  syn match TodoPriorityB /^(M).*$/ contains=TodoContext,TodoTag
  syn match TodoPriorityC /^(T).*$/ contains=TodoContext,TodoTag
elseif day == 2
  syn match TodoPriorityB /^(T).*$/ contains=TodoContext,TodoTag
  syn match TodoPriorityC /^(W).*$/ contains=TodoContext,TodoTag
elseif day == 3
  syn match TodoPriorityB /^(W).*$/ contains=TodoContext,TodoTag
  syn match TodoPriorityC /^(R).*$/ contains=TodoContext,TodoTag
elseif day == 4
  syn match TodoPriorityB /^(R).*$/ contains=TodoContext,TodoTag
  syn match TodoPriorityC /^(F).*$/ contains=TodoContext,TodoTag
elseif day == 5
  syn match TodoPriorityB /^(F).*$/ contains=TodoContext,TodoTag
  syn match TodoPriorityC /^(S).*$/ contains=TodoContext,TodoTag
elseif day == 6
  syn match TodoPriorityB /^(S).*$/ contains=TodoContext,TodoTag
  syn match TodoPriorityC /^(U).*$/ contains=TodoContext,TodoTag
elseif day == 7
  syn match TodoPriorityB /^(U).*$/ contains=TodoContext,TodoTag
  syn match TodoPriorityC /^(M).*$/ contains=TodoContext,TodoTag
endif

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

hi def link TodoTag             Identifier
hi def link TodoKey             Identifier
hi def link TodoPoints          Identifier

hi def link TodoContext         PreProc
hi def link TodoWaiting         PreProc
hi def link TodoNext            PreProc

hi def link TodoDate            Normal

hi def link TodoPriorityAChar   Error
hi def link TodoPriorityA       Error
hi def link TodoPriorityBChar   Operator
hi def link TodoPriorityB       Operator
hi def link TodoPriorityCChar   Normal
hi def link TodoPriorityC       Normal
