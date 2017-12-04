syn match TodoPriorityA /^(A).*$/ contains=TodoProject,TodoContext,TodoTag
syn match TodoPriorityB /^(B).*$/ contains=TodoProject,TodoContext,TodoTag
syn match TodoPriorityC /^(C).*$/ contains=TodoProject,TodoContext,TodoTag
syn match TodoDone /^x\ \d\d\d\d-\d\d-\d\d\ .*/
syn match TodoProject /+\S*/
syn match TodoContext /@\S*/
syn match TodoTag /\S*:\S*/ contains=TodoDate,TodoPoints
syn match TodoPointsTag /pts:/
syn match TodoPoints /pts:\d\{1,2}/ contains=TodoPointsTag
syn match TodoDate /\d\d\d\d-\d\d-\d\d/
syn match TodoWaiting /@waiting/
syn match TodoTitle /^\/\/.*$/
syn match TodoTitle /^##.*$/

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
