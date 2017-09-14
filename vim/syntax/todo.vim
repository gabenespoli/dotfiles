syn match TodoPriorityA /^(A)/ contains=TodoProject,TodoContext,TodoTag
syn match TodoPriorityB /^(B)/ contains=TodoProject,TodoContext,TodoTag
syn match TodoPriorityC /^(C)/ contains=TodoProject,TodoContext,TodoTag
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
