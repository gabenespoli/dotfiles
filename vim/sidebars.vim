"" Sidebars Plugin
" Plugin to manage plugins and loclist/qflist that open as sidebars
" Currently supports: nerdtree, buffergator, tagbar, gundo, loclist, (qf list)

" TODO: blank
" TODO: make SidbarMove function so that focus stays in the same buffer when
" doing the moving
" TODO: set capitalL patterns in each ftplugin; set default to TODO

"" Settings
let g:sidebar_tagbar_cursorline = 1

"" Commands
command! -nargs=1   SidebarToggle  call SidebarToggle(<f-args>)
command! -nargs=1   SidebarOpen    call SidebarOpen(<f-args>)
command! -nargs=1   SidebarClose   call SidebarClose(<f-args>)

"" Keybindings
" nmap <leader>e :call Sidebar
nmap <leader>l :SidebarToggle capitalL<CR>
nmap <leader>f :SidebarToggle nerdtree<CR>
nmap <leader>b :SidebarToggle buffergator<CR>
nmap <leader>t :SidebarToggle tagbar<CR>
nmap <leader>u :SidebarToggle gundo<CR>

nmap <leader>mlh :SidebarClose capitalL<CR>:let g:capitalL_position = 'left'<CR>:SidebarOpen capitalL<CR>
nmap <leader>mlj :SidebarClose capitalL<CR>:let g:capitalL_position = 'bottom'<CR>:SidebarOpen capitalL<CR>
nmap <leader>mlk :SidebarClose capitalL<CR>:let g:capitalL_position = 'top'<CR>:SidebarOpen capitalL<CR>
nmap <leader>mll :SidebarClose capitalL<CR>:let g:capitalL_position = 'right'<CR>:SidebarOpen capitalL<CR>

nmap <leader>mfh :SidebarClose nerdtree<CR>:let g:NERDTreeWinPos = 'left'<CR>:SidebarOpen nerdtree<CR>
nmap <leader>mfj :echo 'Cannot position NERDTree at the bottom.'<CR>
nmap <leader>mfk :echo 'Cannot position NERDTree at the top.'<CR>
nmap <leader>mfl :SidebarClose nerdtree<CR>:let g:NERDTreeWinPos = 'right'<CR>:SidebarOpen nerdtree<CR>

nmap <leader>mbh :SidebarClose buffergator<CR>:let g:buffergator_viewport_split_policy = 'L'<CR>:SidebarOpen buffergator<CR>
nmap <leader>mbj :SidebarClose buffergator<CR>:let g:buffergator_viewport_split_policy = 'B'<CR>:SidebarOpen buffergator<CR>
nmap <leader>mbk :SidebarClose buffergator<CR>:let g:buffergator_viewport_split_policy = 'T'<CR>:SidebarOpen buffergator<CR>
nmap <leader>mbl :SidebarClose buffergator<CR>:let g:buffergator_viewport_split_policy = 'R'<CR>:SidebarOpen buffergator<CR>

nmap <leader>mth :SidebarClose tagbar<CR>:let g:tagbar_left = 1<CR>:SidebarOpen tagbar<CR>
nmap <leader>mtj :echo 'Cannot position tagbar at the bottom.'<CR>
nmap <leader>mtk :echo 'Cannot position tagbar at the top.'<CR>
nmap <leader>mtl :SidebarClose tagbar<CR>:let g:tagbar_left = 0<CR>:SidebarOpen tagbar<CR>

"" Functions

function! SidebarToggle(name)
    let l:position = SidebarGetPosition(a:name)
    let l:varname = 'g:sidebar_'.l:position
    if exists(l:varname) && eval(l:varname) != ''
        " if there's [supposed to be] something there
        if eval(l:varname) == a:name
            " make sure it's actually open before closing it,
            "   otherwise open it instead
            let l:bufname = SidebarGetBufname(a:name)
            if bufwinnr(l:bufname) == -1
                execute 'SidebarOpen '.a:name
            else
                execute 'SidebarClose '.eval(l:varname)
            endif
        endif
    else
        execute 'SidebarOpen '.a:name
    endif
endfunction

function! SidebarGetBufname(name)
    if a:name == 'capitalL'
        return '[Location List]'
    elseif a:name == 'nerdtree'
        return 'NERD_tree'
    elseif a:name == 'buffergator'
        return '[[buffergator-buffers]]'
    elseif a:name == 'tagbar'
        return '__Tagbar__'
    elseif a:name == 'gundo'
        return '__Gundo__'
    endif
endfunction

function! SidebarOpen(name)
    let l:position = SidebarGetPosition(a:name)
    let l:varname = 'g:sidebar_'.l:position

    if exists(l:varname) && eval(l:varname) != ''
        if eval(l:varname) == a:name
            " if it's there already, move to it instead
            let l:bufname = SidebarGetBufname(a:name)
            if bufwinnr(l:bufname) > 0
                execute bufwinnr(l:bufname) . ' wincmd w'
                return
            endif
        elseif
            " if something else is there, close it first
            execute 'SidebarClose '.eval(l:varname)
        endif
    endif

    if a:name == 'blank'
        execute 'call SidebarBlankOpen()'
    elseif a:name == 'capitalL'
        execute 'Lopen'
    elseif a:name == 'nerdtree'
        let dir = expand('%:p:h')
        execute 'NERDTree '.dir
    elseif a:name == 'buffergator'
        execute 'BuffergatorOpen'
    elseif a:name == 'tagbar'
        execute 'TagbarOpen'
        if g:sidebar_tagbar_cursorline
            execute 'set cursorline'
        endif
    elseif a:name == 'gundo'
        execute 'GundoToggle'
    else
        echo 'Unknown sidebar (opening).'
        return
    endif

    execute "let ".l:varname." = '".a:name."'"
endfunction

function! SidebarClose(name)
    " check if already closed
    let l:position = SidebarGetPosition(a:name)
    let l:varname = 'g:sidebar_'.l:position
    if !exists(l:varname) || eval(l:varname) != a:name
        return
    endif
    if a:name == 'blank'
        execute 'call SidebarBlankClose()'
    elseif a:name == 'capitalL'
        execute 'Lclose'
    elseif a:name == 'nerdtree'
        execute 'NERDTreeClose'
    elseif a:name == 'buffergator'
        execute 'BuffergatorClose'
    elseif a:name == 'tagbar'
        execute 'TagbarClose'
    elseif a:name == 'gundo'
        execute 'GundoToggle'
    else
        echo 'Unknown sidebar (closing).'
        return
    endif
    execute "let ".l:varname." = ''"
    " patch to make capitalL window stay the right size
    if exists('g:Lbufnr')
        execute 'call Lresize()'
    endif
endfunction

function! SidebarBlankOpen()
endfunction

function! SidebarBlankClose()
endfunction

function! SidebarGetPosition(name)
    " note that these defaults are as the plugin requests the value
    " e.g. tagbar is boolean true for left; gundo is boolean true for right
    let l:defaults = {
        \ 'capitalL':      'right',
        \ 'nerdtree':      'left',
        \ 'buffergator':   'L',
        \ 'tagbar':        1,
        \ 'gundo':         1,
    \ }

    if a:name == 'capitalL'
        if !exists('g:capitalL_position')
            let g:capitalL_position = l:defaults[a:name]
        endif
        return g:capitalL_position

    elseif a:name == 'nerdtree'
        if !exists('g:NERDTreeWinPos')
            let g:NERDTreeWinPos = l:defaults[a:name]
        endif
        return g:NERDTreeWinPos

    elseif a:name == 'buffergator'
        if !exists('g:buffergator_viewport_split_policy')
            let g:buffergator_viewport_split_policy = l:defaults[a:name]
        endif
        if g:buffergator_viewport_split_policy == 'L'
            return 'left'
        elseif g:buffergator_viewport_split_policy == 'B'
            return 'bottom'
        elseif g:buffergator_viewport_split_policy == 'T'
            return 'top'
        elseif g:buffergator_viewport_split_policy == 'R'
            return 'right'
        endif

    elseif a:name == 'tagbar'
        if !exists('g:tagbar_left')
            let g:tagbar_left = l:defaults[a:name]
        endif
        if g:tagbar_left
            return 'left'
        else
            return 'right'
        endif

    elseif a:name == 'gundo'
        if !exists('g:gundo_right')
            let g:gundo_right = l:defaults[a:name]
        endif
        if g:gundo_right
            return 'right'
        else
            return 'left'
        endif
    endif

endfunction

source ~/dotfiles/vim/capitalL.vim
