syntax match TodoTitle          /^\/\/.*$/
syntax match TodoTitle          /^##.*$/
syntax match TodoTitle          /^#.*$/
syntax match TodoTitle          /^.*:$/

syntax match TodoDash           /^-\ /
syntax match TodoX              /^x\ /
syntax match TodoTickBox        /^\s*-\ \[\ \]\ /
syntax match TodoTickBoxX       /^\s*-\ \[x\]\ /

syntax match TodoTxtDone        /^x\ \d\d\d\d-\d\d-\d\d\ .*/
syntax match TodoAction         /!\S*/

syntax match CommentChar        /^>\ /

syntax match TodoTag            /+\S*/
syntax match TodoKey            /\S*:\S*/ contains=TodoDate,TodoPoints
syntax match TodoPointsKey      /pts:/
syntax match TodoPoints         /pts:\d\{1,2}/ contains=TodoPointsTag

syntax match TodoContext        /@\S*/
syntax match TodoWaiting        /@waiting/
syntax match TodoNext           /@next/
syntax match TodoDate           /\d\d\d\d-\d\d-\d\d/



" priorities (todo.txt) {{{1
syntax match TodoPriorityA /^(A).*$/ contains=TodoProject,TodoContext,TodoTag
syntax match TodoPriorityB /^(B).*$/ contains=TodoProject,TodoContext,TodoTag
syntax match TodoPriorityC /^(C).*$/ contains=TodoProject,TodoContext,TodoTag

" day of the week priorities
" link highlight to B/C priority based on current day of week
let day = strftime("%u")
if day == 1
  syn match TodoPriorityB /^(M).*$/ contains=TodoProject,TodoContext,TodoTag
  syn match TodoPriorityC /^(T).*$/ contains=TodoProject,TodoContext,TodoTag
elseif day == 2
  syn match TodoPriorityB /^(T).*$/ contains=TodoProject,TodoContext,TodoTag
  syn match TodoPriorityC /^(W).*$/ contains=TodoProject,TodoContext,TodoTag
elseif day == 3
  syn match TodoPriorityB /^(W).*$/ contains=TodoProject,TodoContext,TodoTag
  syn match TodoPriorityC /^(R).*$/ contains=TodoProject,TodoContext,TodoTag
elseif day == 4
  syn match TodoPriorityB /^(R).*$/ contains=TodoProject,TodoContext,TodoTag
  syn match TodoPriorityC /^(F).*$/ contains=TodoProject,TodoContext,TodoTag
elseif day == 5
  syn match TodoPriorityB /^(F).*$/ contains=TodoProject,TodoContext,TodoTag
  syn match TodoPriorityC /^(S).*$/ contains=TodoProject,TodoContext,TodoTag
elseif day == 6
  syn match TodoPriorityB /^(S).*$/ contains=TodoProject,TodoContext,TodoTag
  syn match TodoPriorityC /^(U).*$/ contains=TodoProject,TodoContext,TodoTag
elseif day == 7
  syn match TodoPriorityB /^(U).*$/ contains=TodoProject,TodoContext,TodoTag
  syn match TodoPriorityC /^(M).*$/ contains=TodoProject,TodoContext,TodoTag
endif

" default highlights {{{1
hi link TodoTitle     Title

hi link TodoDash      Todo
hi link TodoX         Operator
hi link TodoTickBox   Todo
hi link TodoTickBoxX  Operator

hi link TodoTxtDone   Comment
hi link TodoAction    Todo

hi link CommentChar   Comment

hi link TodoTag       Identifier
hi link TodoKey       TodoTag
hi link TodoPointsKey TodoKey
hi link TodoPoints    TodoPointsKey

hi link TodoContext   Type
hi link TodoWaiting   TodoContext
hi link TodoNext      TodoContext
hi link TodoDate      Normal
