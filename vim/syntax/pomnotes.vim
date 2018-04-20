syntax match PomNotesTitle     /^.*:$/
syntax match PomNotesDash      /^-\ /
syntax match PomNotesX         /^x\ /
syntax match CommentChar    /^>\ /
syntax match PomNotesTickBox   /^\s*-\ \[\ \]\ /
syntax match PomNotesTickBoxX  /^\s*-\ \[x\]\ /

hi link PomNotesTitle    Title
hi link PomNotesDash     Todo
hi link PomNotesX        Constant
hi link CommentChar   PomNotesX
hi link PomNotesTickBox  PomNotesDash
hi link PomNotesTickBoxX PomNotesX
