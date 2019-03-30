syntax match markdownPandocCitation /\[@[^\]]*\]/
syntax match markdownPandocCitation /[@#]fig:[a-zA-Z_-]*/
syntax match markdownPandocCitation /[@#]tbl:[a-zA-Z_-]*/

syntax match markdownProbablyCitation /([^)]*)/
hi link markdownProbablyCitation markdownPandocCitation
