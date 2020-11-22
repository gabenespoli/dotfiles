silent! unmap <buffer> <C-p>
silent! unmap <buffer> <C-n>
nmap <buffer> } ]]o
nmap <buffer> { [[o

" git command maps
nnoremap <buffer> co<Space> :Git checkout<Space>
nnoremap <buffer> cb<Space> :Git branch<Space>
nnoremap <buffer> cm<Space> :Git merge<Space>
nnoremap <buffer> ri<Space> :Git rebase -i --autosquash<Space>
nnoremap <buffer> r<Space> :Git rebase<Space>

nnoremap <buffer> coo :Git checkout <C-r>=gv#sha()<CR><CR>
nnoremap <buffer> cf :Git commit --fixup <C-r>=gv#sha()<CR><CR>
nnoremap <buffer> cp :Git cherry-pick <C-r>=gv#sha()<CR><CR>
nnoremap <buffer> gR :Git reset HEAD^<CR>
nnoremap <buffer> rii j:Git rebase -i --autosquash <C-r>=gv#sha()<CR><CR>

" refresh maps
nnoremap <buffer> R :close<CR>:GV --all<CR>
nnoremap <buffer> <C-r> :close<CR>:GV<CR>
nnoremap <buffer> gL :close<CR>:GV --all<CR>
nnoremap <buffer> gl :close<CR>:GV <CR>

" gx map to go to Jira issue online
if has('mac')
  nnoremap <buffer> gx :call GoToJira()<CR>
  function! GoToJira()
    let l:jira_key = ''

    for l:word in split(getline('.'), '\[\|\]')
      if match(l:word, '\u\+-\d\+') > -1
        let l:jira_key = l:word
        break
      endif
    endfor

    if l:jira_key == ''
      echo "No JIRA key found on this line"
    else
      let l:url = 'https://jira.sonova.com/browse/' . l:jira_key
      execute 'silent !open ' . shellescape(l:url)
    endif

  endfunction
endif

" make graph prettier with box drawing symbols and bullets
function GVPretty()
  set modifiable
  " handle corner case where line is '| / /'
  execute '%s/^|\//|╱/g'
  execute '%s/|/│/g'
  " for forward slash only look in first few characters of line
  " we don't want to replace the slash in origin/master, for e.g.
  execute '%s/^\(.\{0,5\}\)\//\1╱/g'
  execute '%s/\\/╲/g'
  execute '%s/\*/∙/g'
  set nomodifiable
  normal! gg
endfunction

" call GVPretty()
