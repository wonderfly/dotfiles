" Customizations for C files.

" CInclude {{{
function! s:CInclude(header)
  execute "normal! mq/#include\<cr>o#include <" . a:header . ".h>\<esc>`q"
endfunction

command! -bang -nargs=* CInclude call <SID>CInclude(<q-args>)
" }}}

" Lsp {{{
"nnoremap <buffer> <c-]> :call LanguageClient#textDocument_definition()<cr>
nnoremap <buffer> <C-]> :LspDefinition<cr>

if !exists("g:clangformat_on")
  let g:pluginname_setting=1
endif

function! s:ClangFormat()
  if g:clangformat_on == 1
    echohl ModeMsg | echom "Calling LspDocumentFormat" | echohl None
    execute 'LspDocumentFormat'
  else
    echohl ModeMsg | echom "ClangFormat off!" | echohl None
  endif
endfunction

function! s:ToggleClangFormat()
  let g:clangformat_on = (g:clangformat_on + 1) % 2
  echohl ModeMsg | echom "ClangFormat state changed to: " . g:clangformat_on | echohl None
endfunction
command! -bang ToggleClangFormat call <SID>ToggleClangFormat()

augroup clang_format
  autocmd!
  "autocmd BufWritePre *.c,*.h :call LanguageClient#textDocument_formatting_sync()
  autocmd BufWritePre *.c,*.h call <SID>ClangFormat()
augroup END
" }}}
