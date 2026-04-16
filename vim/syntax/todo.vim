syntax match TotesTitle             /^#.*$/
syntax match TotesTodoBox           /\[ \]/
syntax match TotesDoneBox           /\[[xX]\] .*/
syntax match TotesDoingBox          /\[\/\] .*/
syntax match TotesImportantBox      /\[\!\]/
syntax match TotesWaitingBox        /\[\~\]/
syntax match TotesTodo              /^\s*- \[ \]/ contains=TotesTodoBox
syntax match TotesDone              /^\s*- \[x]/ contains=TotesDoneBox
syntax match TotesNode              /^\s*> \[ \]/ contains=TotesTodoBox
syntax match TotesNodeDone          /^\s*> \[x]/ contains=TotesDoneBox
syntax match TotesTag               /@[a-z][^ ()]*/ containedin=BulletTodo,BulletDoing,BulletWaiting
syntax match TotesPerson            /@[A-Z][^ ()]*/ containedin=BulletTodo,BulletDoing,BulletWaiting
syntax match TotesKeyword           /+[^ ]*/ containedin=BulletTodo,BulletDoing,BulletWaiting
syntax match TotesImportant         / ![^ ]*/ containedin=BulletTodo,BulletDoing,BulletWaiting

syntax match BulletTodo             /^ *\* .*/
syntax match BulletDoing            /^ *\/ .*/
syntax match BulletWaiting          /^ *\~ .*/
syntax match BulletDone             /^ *[xX] .*/
syntax match BulletImportant        /^ *! .*/

hi def link TotesTitle              Title
hi def link TotesTodoBox            Delimiter
hi def link TotesDoneBox            Delimiter
hi def link TotesDoingBox           Constant
hi def link TotesImportantBox       Todo
hi def link TotesWaitingBox         PreProc
hi def link TotesTag                Tag
hi def link TotesPerson             String
hi def link TotesKeyword            Identifier
hi def link TotesNode               PreProc
hi def link TotesNodeDone           PreProc
hi def link TotesImportant          Error

hi def link BulletTodo              Todo
hi def link BulletDoing             Constant
hi def link BulletWaiting           PreProc
hi def link BulletDone              Delimiter
hi def link BulletImportant         Error
