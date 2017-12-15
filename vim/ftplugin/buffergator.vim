" use C-j as enter to open the selected file
noremap <buffer> <silent> <C-j>       :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "")<CR>

" for split/vsplit, use s/v instead of i/s
noremap <buffer> <silent> v           :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "vert sb")<CR>
noremap <buffer> <silent> s           :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "sb")<CR>
noremap <buffer> <silent> pv          :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 0, "vert sb")<CR>
noremap <buffer> <silent> ps          :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 0, "sb")<CR>
noremap <buffer> <silent> V           :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 1, "vert sb")<CR>
noremap <buffer> <silent> gv          :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 1, "vert sb")<CR>
noremap <buffer> <silent> S           :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 1, "sb")<CR>
noremap <buffer> <silent> gs          :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 1, "sb")<CR>
noremap <buffer> <silent> ev          :<C-U>call b:buffergator_catalog_viewer.visit_open_target(0, !g:buffergator_autodismiss_on_select, "vert sb")<CR>
noremap <buffer> <silent> es          :<C-U>call b:buffergator_catalog_viewer.visit_open_target(0, !g:buffergator_autodismiss_on_select, "sb")<CR>

