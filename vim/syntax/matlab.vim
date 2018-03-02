syn match matlabCellComment         "^%%.*$"
syn match matlabCellCommentPrefix   "^\s*"
syn match matlabCellCommentIndented "^\s*%%.*$" contains=matlabCellCommentPrefix
