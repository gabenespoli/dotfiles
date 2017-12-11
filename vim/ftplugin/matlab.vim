nnoremap <buffer> <localleader>tt :MatlabLaunchServer<CR>
nnoremap <buffer><silent> <localleader>w :MatlabCliOpenWorkspace<CR>

nnoremap <buffer>         <localleader>rn :MatlabRename
nnoremap <buffer><silent> <localleader>fn :MatlabFixName<CR>
vnoremap <buffer><silent> <localleader>b <ESC>:MatlabCliRunSelection<CR>
nnoremap <buffer><silent> <localleader>b <ESC>:MatlabCliRunCell<CR>
nnoremap <buffer><silent> <localleader>ll :MatlabCliRunLine<CR>
nnoremap <buffer>         <localleader>pp vip:MatlabCliRunSelection<CR>
nnoremap <buffer><silent> <localleader>v <ESC>:MatlabCliViewVarUnderCursor<CR>
vnoremap <buffer><silent> <localleader>V <ESC>:MatlabCliViewSelectedVar<CR>
nnoremap <buffer><silent> <localleader>h <ESC>:MatlabCliHelp<CR>
nnoremap <buffer><silent> <localleader>e <ESC>:MatlabCliOpenInMatlabEditor<CR>
nnoremap <buffer><silent> <localleader>c :MatlabCliCancel<CR>
