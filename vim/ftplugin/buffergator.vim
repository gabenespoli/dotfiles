noremap <buffer> <silent> l           :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "")<CR>
noremap <buffer> <silent> L           :<C-U>call b:buffergator_catalog_viewer.visit_target(1, 1, "")<CR>
noremap <buffer> <silent> <C-j>       :<C-U>call b:buffergator_catalog_viewer.visit_target(!g:buffergator_autodismiss_on_select, 0, "")<CR>

