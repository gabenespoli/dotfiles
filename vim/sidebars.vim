""" Sidebar Toggles
" nerdtree, buffergator, tagbar, gundo, loclist, (qf list)
" TODO choose left or right for each; only close if is same side
" TODO blank

function! SidebarToggle(name)
    if !exists('g:sidebar') || empty(g:sidebar)
        execute "call SidebarOpen('".a:name."')"
    elseif g:sidebar != a:name
        execute "call SidebarClose('".g:sidebar."')"
        execute "call SidebarOpen('".a:name."')"
    elseif g:sidebar == a:name
        execute "call SidebarClose('".a:name."')"
    endif
endfunction

function! SidebarOpen(name)
    if a:name == 'nerdtree'
        let dir = expand('%:p:h')
        execute 'NERDTree '.dir
        let g:sidebar = 'nerdtree'
    elseif a:name == 'buffergator'
        execute 'BuffergatorOpen'
        let g:sidebar = 'buffergator'
    elseif a:name == 'tagbar'
        execute 'TagbarOpen'
        let g:sidebar = 'tagbar'
    elseif a:name == 'gundo'
        execute 'GundoToggle'
        let g:sidebar = 'gundo'
    endif
endfunction

function! SidebarClose(name)
    if a:name == 'nerdtree'
        execute 'NERDTreeClose'
    elseif a:name == 'buffergator'
        execute 'BuffergatorClose'
    elseif a:name == 'tagbar'
        execute 'TagbarClose'
    elseif a:name == 'gundo'
        execute 'GundoToggle'
    endif
    let g:sidebar = ''
    if exists('g:Lbufnr')
        execute 'call Lresize()'
    endif
endfunction

function! ResetWindowSizes()
    let current_bufwinnr = bufwinnr('%')
    if exists('g:sidebar') && !empty(g:sidebar)
        execute 'SidePanelWidth(g:width)'
    endif
    if exists('g:Lbufnr') && g:Lbufnr > 0
        execute 'call Lresize()'
    endif
    execute current_bufwinnr . ' wincmd w'
endfunction

function! Lvimgrep()
    execute 'silent lvimgrep /{>>\|{==\|{++\|{--\|TODO/j %'
endfunction

function! Lopen()
    if !exists('g:Lpos')
        let g:Lpos = 'vertical'
    endif
    let currentWindow = bufwinnr('%')
    execute 'call Lvimgrep()'
    execute g:Lpos.' lopen'
    execute 'set modifiable'
    silent! %s/[^{]*\({>>\|{==\|{++\|{--\)\([^}]*}\).*$/\1\2/ge
    execute 'set nomodified'
    execute 'call L_ResizeCurrentWindow(g:Lpos)'
    normal! gg
    let g:Lbufnr = bufnr('%')
    execute currentWindow . ' wincmd w'
endfunction

function! Lclose()
    execute 'lclose'
    let g:Lbufnr = 0
endfunction

function! Ltoggle()
    if !exists('g:Lbufnr')
        let g:Lbufnr = 0
    endif
    if g:Lbufnr > 0
        execute 'call Lclose()'
    else
        execute 'call Lopen()'
    endif
endfunction

function! Lresize()
    " switch to loclist, then call L_ResizeCurrentWindow, switch back
    if exists('g:Lbufnr') && g:Lbufnr > 0 && exists('g:Lpos')
        let currentWindow = bufwinnr('%')
        execute  bufwinnr(g:Lbufnr) . ' wincmd w'
        execute 'call L_ResizeCurrentWindow(g:Lpos)'
        execute currentWindow . ' wincmd w'
    endif
endfunction

function! L_ResizeCurrentWindow(pos)
    if a:pos =~ 'vertical'
        if exists('g:width')
            let width = g:width
        elseif exists('$COLS')
            let width = ($COLS - 100) / 2
        else
            let width = 40
        endif
        execute 'vertical resize ' . width
    else
        if exists('g:height')
            let height = g:height
        else
            let height = 8
        endif
        execute 'resize ' . height
    endif
endfunction
