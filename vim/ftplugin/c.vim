" Customizations for C files.

function! s:CInclude(header)
  execute "normal! mq/#include\<cr>o#include <" . a:header . ".h>\<esc>`q"
endfunction

command! -bang -nargs=* CInclude call <SID>CInclude(<q-args>)

augroup clang_format
  autocmd!
  "autocmd BufWritePre *.c,*.h :call LanguageClient#textDocument_formatting_sync()
  autocmd BufWritePre *.c,*.h :LspDocumentFormat
augroup END

"nnoremap <buffer> <c-]> :call LanguageClient#textDocument_definition()<cr>
nnoremap <buffer> <C-]> :LspDefinition<cr>
