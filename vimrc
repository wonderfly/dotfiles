" Begin. {{{
augroup filetype_vim
  " See why this is useful and sane:
  " https://learnvimscriptthehardway.stevelosh.com/chapters/18.html#grouping
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Get help {{{
" :help <the thing you want to know>
"
" Even when you only vaguely know what you are looking for, you can use
" `:helpgrep <keyword>`.
" }}}

" General configurations {{{
set nocompatible " No need to be compatible with vi
set path+=** " Configure the `:find` command to search through subdirectories
set wildmenu

" Open man page for the word under cursor with K.
command! -bang -nargs=* Man :terminal ++close man <args>
set keywordprg=:Man

syntax on
colorscheme delek
set number
set mouse=a
set pastetoggle=<F9>
set cursorline
set shell=/bin/bash " Use bash (and not zsh) for shell commands executed in vim.

set exrc  " Enable per Project/Directory .vimrc
set secure  " Disable unsafe commands in your project-specific .vimrc files

" Save your pinky from having to press ESC to exit insert mode.
imap jk <Esc>

" Find / search settings
set incsearch
set hlsearch

" Status Bar(bottom) Settings
set laststatus=2
set ruler

" Command Line Settings
set showcmd
set showmode

" No tab
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Show a vertical red bar at the margin.
set textwidth=80
set colorcolumn=+1
highlight ColorColumn ctermbg=gray guibg=gray9

" Folding
set foldmethod=syntax " This might be causing a bug: https://github.com/neoclide/coc.nvim/issues/1048#issuecomment-539809369
set foldlevel=100
set foldcolumn=3

" Spell check on for Markdowns, git commits and text files
augroup spellchecks
  autocmd!
  autocmd FileType markdown,gitcommit,text setlocal spell spelllang=en_us
augroup END

" Linux Kernel coding style
let g:linuxsty_patterns = [ "/linux/", "/kernel/" , "/vboot_reference/", "/depthcharge/", "coreboot", "e2fsprogs", "sbsigntools"]

" Disable the following option if you don't like vim's Python style.
" It comes with /usr/share/vim/vim<version>/ftplugin/python.vim
" let g:python_recommended_style = 0
" }}}

" Mappings {{{
let mapleader = ","
nmap ; :

" I never really use the recording features bound to 'q'.
nnoremap q :q<cr>

" Open and close quickfix window quickly and nicely.
let s:qfopen = 0
nnoremap <leader>q :call <SID>QuickfixToggle()<cr>

function! s:QuickfixToggle()
  if s:qfopen
    call <SID>QuickfixClose()
  else
    call <SID>QuickfixOpen()
  endif
endfunction

function! s:QuickfixOpen()
  let s:quickfix_return_to_window = winnr()
  copen
    let s:qfopen = 1
endfunction

function! s:QuickfixClose()
  cclose
  let s:qfopen = 0
  if exists("s:quickfix_return_to_window")
    execute s:quickfix_return_to_window . "wincmd w"
  endif
endfunction

" Always use "very magic" mode in searches.
nnoremap / /\v
nnoremap ? ?\v

" Grep word under cursor, with :Rg.
nnoremap <leader>g :execute "Rg " . expand("<cword>")<cr>

" Configure :Rg with preview window.
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)

" In normal mode, use <leader>" to wrap the current word in double quotes.
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" Toggle cases of the current word in insert mode with Ctrl-u and Ctrl-l.
inoremap <c-u> <esc>viwUi
inoremap <c-l> <esc>viwui

" Toggle cases of the current word in normal mode with <leader>u and <leader>l.
nnoremap <leader>u viwU
nnoremap <leader>l viwu

" Open vimrc quickly
nnoremap <leader>rc :split $MYVIMRC<cr>
nnoremap <leader>lrc :so $MYVIMRC<cr>

" Change working directory to that of the current file.
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Easier moving of code blocks
" " Try to go into visual mode (v), then select several lines of code here and
" " then press ``>`` several times.
vnoremap < <gv
vnoremap > >gv

" Sort selected lines alphabetically
vnoremap ,s :!sort<CR>

" Resize windows more easily.
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
  map <S-h>  <C-W><
  map <S-l>  <C-W>>
endif

" Navigate windows with single keys.
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-l> <C-W>l

" Apply the same mappings to terminal windows.
tnoremap <C-J> <C-W>j
tnoremap <C-K> <C-W>k
tnoremap <C-H> <C-W>h
tnoremap <C-l> <C-W>l

" Move faster in location list
function! Lnext()
  try
    lnext
  catch
    silent! lfir
  endtry
endfunction

function! Lprev()
  try
    lprev
  catch
    silent! lla
  endtry
endfunction
nnoremap ]\ :call Lnext() <CR>
nnoremap [\ :call Lprev() <CR>
" }}}

" Plugins, managed by https://github.com/junegunn/vim-plug. {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" First thing first.
Plug 'tpope/vim-sensible'

" Language specifics
" vim-go installs a bunch of binaries to $GOPATH/bin, e.g., gofmt, golint.
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
let g:go_fmt_command = "goimports" " goimports does BOTH formatting and imports management
" See additional vim-go configs in vim/ftplugin/go.vim

Plug 'davidhalter/jedi-vim'
let g:jedi#use_tabs_not_buffers = 0

Plug 'chrisbra/vim-kconfig' " Prettier kernel config files.
Plug 'vivien/vim-linux-coding-style'  " Linux kernel coding style.
" Type `:LinuxCodingStyle` to enable it on-demand.

Plug 'gentoo/gentoo-syntax'
Plug 'kergoth/vim-bitbake', { 'for': 'bitbake'}
Plug 'dag/vim-fish'

" Generally useful plugins
Plug 'preservim/nerdtree'
nmap nd :NERDTree<cr>
" Use hterm friendly charactors.
let NERDTreeDirArrowExpandable = "+"
let NERDTreeDirArrowCollapsible = "-"

Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'vim-scripts/tcd.vim'

Plug 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['go']
" In my experience, having anything else here will break it.
" Source about the incompatibility between vim-go and syntastic:
" https://github.com/neoclide/coc.nvim/issues/1048#issuecomment-539809369.

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'

Plug 'martinlroth/vim-acpi-asl'

" Skip installing YCM if a work profile is detected - as my work profile
" installs a different version of YCM.
if !filereadable($HOME . "/.vim/work.vim")
  Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --go-completer --clangd-completer' }
endif
let g:ycm_autoclose_preview_window_after_completion = 1
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
let g:fzf_history_dir = '~/.fzf-history'
let g:fzf_action = { 'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~70%' }
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>

"Plug 'junegunn/limelight.vim' " Depends on goyo.
"Plug 'junegunn/goyo.vim'
"" Color name (:help cterm-colors) or ANSI code
"let g:limelight_conceal_ctermfg = 'gray'
"let g:limelight_conceal_ctermfg = 240

Plug 'Vimjas/vim-python-pep8-indent' " Depends on autopep8

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'luna'

call plug#end()
" }}}

" Abbreviations {{{
iabbrev optinoal optional
iabbrev functino function
" }}}

" Work-specific settings {{{
if filereadable($HOME . "/.vim/work.vim")
  source $HOME/.vim/work.vim
endif
" }}}
