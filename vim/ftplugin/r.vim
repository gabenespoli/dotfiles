" nvim-r plugin bindings {{{1
" nmap <expr> <C-l>   string(g:SendCmdToR)=="function('SendCmdToR_fake')" ? ':execute "normal \<Plug>SlimeLineSend"<CR>'        : ':call SendLineToR("stay")<CR>'
" nmap <expr> <M-C-l> string(g:SendCmdToR)=="function('SendCmdToR_fake')" ? ':execute "normal \<Plug>SlimeLineSendj"<CR>'       : ':call SendLineToR("down")<CR>'
" nmap <expr> <C-k>   string(g:SendCmdToR)=="function('SendCmdToR_fake')" ? ':execute "normal \<Plug>SlimeParagraphSend"<CR>'   : ':call SendParagraphToR("echo", "stay")<CR>'
" nmap <expr> <M-C-k> string(g:SendCmdToR)=="function('SendCmdToR_fake')" ? ':execute "normal \<Plug>SlimeParagraphSend}j"<CR>' : ':call SendParagraphToR("echo", "down")<CR>'


set equalalways

" keybindings {{{1
inoremap {<CR> {<CR>}<Esc>O

" comment headings and folding (like Rstudio) {{{1
" highlight
au VimEnter,BufEnter <buffer> syn match Title '^#.*-\{4,\}$'
au VimEnter,BufEnter <buffer> syn match Title '^#.*=\{4,\}$'
au VimEnter,BufEnter <buffer> syn match Title '^#.*#\{4,\}$'

" adjusting headings
function! AddRstudioHeadings(level)
  " remove existing headings if there are any
  silent! execute "s/[-=#]\\{4,\\}$//g"
  " get number of heading characters to add
  let l:maxWidth = 79
  execute "normal! $"
  let l:currentWidth = col(".")
  let l:numberToInsert = l:maxWidth - l:currentWidth
  " get new heading level character
  if     a:level == 1
    let l:headingCharacter = "-"
  elseif a:level == 2
    let l:headingCharacter = "="
  elseif a:level == 3
    let l:headingCharacter = "#"
  elseif a:level == 0
    return
  else
    echo "Heading level must be 0, 1, 2, or 3"
  endif
  " add new heading characters
  execute "normal! $" . l:numberToInsert . "a" . l:headingCharacter
endfunction

nnoremap <buffer> <localleader>0 :call AddRstudioHeadings(0)<CR>
nnoremap <buffer> <localleader>1 :call AddRstudioHeadings(1)<CR>
nnoremap <buffer> <localleader>2 :call AddRstudioHeadings(2)<CR>
nnoremap <buffer> <localleader>3 :call AddRstudioHeadings(3)<CR>

" folding
set foldmethod=expr
set foldexpr=GetRFolds(v:lnum)
function! GetRFolds(lnum)
  if     getline(a:lnum) =~ '^#.*-\{4,\}$'
    return '>1'
  elseif getline(a:lnum) =~ '^#.*=\{4,\}$'
    return '>2'
  elseif getline(a:lnum) =~ '^#.*#\{4,\}$'
    return '>3'
  else
    return '='
  endif
endfunction

" capitalL plugin settings
let b:Lpatterns = ['/#.*TODO/gj *.R', '/^.*<-\s*function/gj %']
let b:Lreformat = ['', '/[^|]*|[^|]*|\s/']
" let b:Lreformat = ['[^|]*|[^|]*|\s#\+\s*\(TODO.*\)$/\1', '[^|]*|[^|]*|\s/']
