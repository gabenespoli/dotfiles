syntax match TotesTitle         /^#.*$/
syntax match TotesTodoBox       /\[ \]/
syntax match TotesDoneBox       /\[x\]/
syntax match TotesTodo          /^\s*- \[ \]/ contains=TotesTodoBox
syntax match TotesDone          /^\s*- \[x]/ contains=TotesDoneBox
syntax match TotesTag           /@[a-z][^ ]*/
syntax match TotesPerson        /@[A-Z][^ ]*/
syntax match TotesKeyword       /+[^ ]*/

hi def link TotesTitle          Title
hi def link TotesTodoBox        Delimiter
hi def link TotesDoneBox        Function
hi def link TotesTag            Tag
hi def link TotesPerson         PreProc
hi def link TotesKeyword        Constant
