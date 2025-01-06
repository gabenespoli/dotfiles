syntax match TotesTitle         /^#.*$/
syntax match TotesTodoBox       /\[ \]/
syntax match TotesDoneBox       /\[x\]/
syntax match TotesDoingBox      /\[\.\]/
syntax match TotesImportantBox  /\[\!\]/
syntax match TotesWaitingBox    /\[\~\]/
syntax match TotesTodo          /^\s*- \[ \]/ contains=TotesTodoBox
syntax match TotesDone          /^\s*- \[x]/ contains=TotesDoneBox
syntax match TotesNode          /^\s*> \[ \]/ contains=TotesTodoBox
syntax match TotesNodeDone      /^\s*> \[x]/ contains=TotesDoneBox
syntax match TotesTag           /@[a-z][^ ()]*/
syntax match TotesPerson        /@[A-Z][^ ()]*/
syntax match TotesKeyword       /+[^ ]*/
syntax match TotesImportant     /![^ ]*/

hi def link TotesTitle          Title
hi def link TotesTodoBox        Delimiter
hi def link TotesDoneBox        Special
hi def link TotesDoingBox       Constant
hi def link TotesImportantBox   Todo
hi def link TotesWaitingBox     Type
hi def link TotesTag            Tag
hi def link TotesPerson         String
hi def link TotesKeyword        Identifier
hi def link TotesNode           PreProc
hi def link TotesNodeDone       PreProc
hi def link TotesImportant      Error
