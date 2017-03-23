"syn region pythonComment
"      \ start=+\%(:\n\s*\)\@<=\z('''\|"""\)+ end=+\z1+ keepend
"      \ contains=pythonEscape,pythonTodo,@Spell

