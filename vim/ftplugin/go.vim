set ts=8 sw=8 noet
set nolist

" Go has no max line-length, but set colorcolumn as a reference
set colorcolumn=81

nnoremap <buffer> <LocalLeader>i <Plug>(go-info)
nnoremap <buffer> <LocalLeader>f :GoImports<CR>

nnoremap <buffer> <LocalLeader>r <Plug>(go-run)
nnoremap <buffer> <LocalLeader>b <Plug>(go-build)
nnoremap <buffer> <LocalLeader>t <Plug>(go-test)
nnoremap <buffer> <LocalLeader>c <Plug>(go-coverage)

" let g:go_def_mapping_enabled = 0 " disable mapping that interferes with fzf
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
