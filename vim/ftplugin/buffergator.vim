noremap <buffer> <silent> s           :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "sb")<CR>
noremap <buffer> <silent> v           :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 1, "vert sb")<CR>
noremap <buffer> <silent> <C-j>       :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 1, "")<CR>
noremap <buffer> <silent> <Esc>       :<C-U>call b:buffergator_catalog_viewer.close(1)<CR>

" below was copied from file ~/.vim/plugged/vim-buffergator/autoload/buffergator.vim, and edited

"""" Catalog management
noremap <buffer> <silent> cs          :call b:buffergator_catalog_viewer.cycle_sort_regime()<CR>
noremap <buffer> <silent> cd          :call b:buffergator_catalog_viewer.cycle_display_regime()<CR>
noremap <buffer> <silent> cp          :call b:buffergator_catalog_viewer.cycle_directory_path_display()<CR>
noremap <buffer> <silent> cw          :call b:buffergator_catalog_viewer.cycle_viewport_modes()<CR>
noremap <buffer> <silent> cq          :call b:buffergator_catalog_viewer.cycle_autodismiss_modes()<CR>
noremap <buffer> <silent> cc          <NOP>
noremap <buffer> <silent> r           :call b:buffergator_catalog_viewer.rebuild_catalog()<CR>
noremap <buffer> <silent> q           :call b:buffergator_catalog_viewer.close(1)<CR>
noremap <buffer> <silent> d           :<C-U>call b:buffergator_catalog_viewer.delete_target(0, 0)<CR>
noremap <buffer> <silent> D           :<C-U>call b:buffergator_catalog_viewer.delete_target(0, 1)<CR>
noremap <buffer> <silent> x           :<C-U>call b:buffergator_catalog_viewer.delete_target(1, 0)<CR>
noremap <buffer> <silent> X           :<C-U>call b:buffergator_catalog_viewer.delete_target(1, 1)<CR>

""""" Selection: show target and switch focus
noremap <buffer> <silent> <CR>        :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "")<CR>
noremap <buffer> <silent> o           :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "")<CR>
noremap <buffer> <silent> <LeftMouse> :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "")<CR>
noremap <buffer> <silent> s           :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "vert sb")<CR>
noremap <buffer> <silent> <C-v>       :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "vert sb")<CR>
noremap <buffer> <silent> i           :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "sb")<CR>
noremap <buffer> <silent> <C-s>       :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "sb")<CR>
noremap <buffer> <silent> t           :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "tab sb")<CR>
noremap <buffer> <silent> <C-t>       :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "tab sb")<CR>

""""" Selection: show target and switch focus, preserving the catalog regardless of the autodismiss setting
noremap <buffer> <silent> po          :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 0, "")<CR>
noremap <buffer> <silent> ps          :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 0, "vert sb")<CR>
noremap <buffer> <silent> pi          :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 0, "sb")<CR>
noremap <buffer> <silent> pt          :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 0, "tab sb")<CR>

""""" Preview: show target , keeping focus on catalog
noremap <buffer> <silent> O           :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 1, "")<CR>
noremap <buffer> <silent> go          :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 1, "")<CR>
noremap <buffer> <silent> S           :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 1, "vert sb")<CR>
noremap <buffer> <silent> gs          :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 1, "vert sb")<CR>
noremap <buffer> <silent> I           :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 1, "sb")<CR>
noremap <buffer> <silent> gi          :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 1, "sb")<CR>
noremap <buffer> <silent> T           :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 1, "tab sb")<CR>
noremap <buffer> <silent> <SPACE>     :<C-U>call b:buffergator_catalog_viewer.goto_index_entry("n", 1, 1)<CR>
noremap <buffer> <silent> <C-SPACE>   :<C-U>call b:buffergator_catalog_viewer.goto_index_entry("p", 1, 1)<CR>
noremap <buffer> <silent> <C-@>       :<C-U>call b:buffergator_catalog_viewer.goto_index_entry("p", 1, 1)<CR>
noremap <buffer> <silent> <C-N>       :<C-U>call b:buffergator_catalog_viewer.goto_index_entry("n", 1, 1)<CR>
noremap <buffer> <silent> <C-P>       :<C-U>call b:buffergator_catalog_viewer.goto_index_entry("p", 1, 1)<CR>

""""" Preview: go to existing window showing target
noremap <buffer> <silent> E           :<C-U>call b:buffergator_catalog_viewer.visit_open_target(1, !g:buffergator_autodismiss_on_select, "")<CR>
noremap <buffer> <silent> eo          :<C-U>call b:buffergator_catalog_viewer.visit_open_target(0, !g:buffergator_autodismiss_on_select, "")<CR>
noremap <buffer> <silent> es          :<C-U>call b:buffergator_catalog_viewer.visit_open_target(0, !g:buffergator_autodismiss_on_select, "vert sb")<CR>
noremap <buffer> <silent> ei          :<C-U>call b:buffergator_catalog_viewer.visit_open_target(0, !g:buffergator_autodismiss_on_select, "sb")<CR>
noremap <buffer> <silent> et          :<C-U>call b:buffergator_catalog_viewer.visit_open_target(0, !g:buffergator_autodismiss_on_select, "tab sb")<CR>

