"" CapitalL vim plugin to control location lists

"" Commands
command!            Lopen          call Lopen()
command!            Lclose         call Lclose()

"" Functions
function! Lvimgrep()
    execute 'silent lvimgrep /{>>\|{==\|{++\|{--\|TODO/j %'
endfunction

function! Lopen()
    if !exists('g:capitalL_position')
        let g:capitalL_position = 'right'
    endif
    let currentWindow = bufwinnr('%')
    execute 'call Lvimgrep()'
    execute ParsePosition(g:capitalL_position).' lopen'
    execute 'set modifiable'
    silent! %s/[^{]*\({>>\|{==\|{++\|{--\)\([^}]*}\).*$/\1\2/ge
    execute 'set nomodified'
    execute 'call CapitalL_ResizeCurrentWindow(g:capitalL_position)'
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
    " switch to loclist, then call CapitalL_ResizeCurrentWindow, switch back
    if exists('g:Lbufnr') && g:Lbufnr > 0 && exists('g:capitalL_position')
        let currentWindow = bufwinnr('%')
        execute  bufwinnr(g:Lbufnr) . ' wincmd w'
        execute 'call CapitalL_ResizeCurrentWindow(g:capitalL_position)'
        execute currentWindow . ' wincmd w'
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

function! CapitalL_ResizeCurrentWindow(position)
    if a:position == 'left' || a:position == 'right'
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

function! ParsePosition(position)
    if a:position == "right"
        return "vertical"
    elseif a:position == "left"
        return "topleft vertical"
    elseif a:position == "top"
        return "topleft"
    elseif a:position == "bottom"
        return "botright"
    else
        return ""
    endif
endfunction
