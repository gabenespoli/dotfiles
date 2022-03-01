syntax match TotesTitle         /^#.*$/
syntax match TotesTodoBox       /\[ \]/
syntax match TotesDoneBox       /\[x\]/
syntax match TotesTodo          /^\s*- \[ \]/ contains=TotesTodoBox
syntax match TotesDone          /^\s*- \[x]/ contains=TotesDoneBox
syntax match TotesKeyword       /@[^ ]*/

hi def link TotesTitle          Title
hi def link TotesDoneBox        Type
hi def link TotesKeyword        String
