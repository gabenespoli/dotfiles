noremap <buffer> <silent> s           :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "sb")<CR>
noremap <buffer> <silent> v           :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 1, "vert sb")<CR>
noremap <buffer> <silent> <C-j>       :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 1, "")<CR>
noremap <buffer> <silent> <Esc>       :<C-U>call b:buffergator_catalog_viewer.close(1)<CR>

