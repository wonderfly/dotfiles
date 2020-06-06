"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Get help
" :help <the thing you want to know>
"
" Even when you only vaguely know what you are looking for, you can use
" `:helpgrep <keyword>`.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General configurations.
"
set nocompatible " No need to be compatible with vi
set path+=** " Configure the `:find` command to search through subdirectories
set wildmenu

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
set tw=80
set colorcolumn=+1,+2
highlight ColorColumn ctermbg=red guibg=gray9

" Folding
" set foldmethod=syntax " This might be causing a bug: https://github.com/neoclide/coc.nvim/issues/1048#issuecomment-539809369
set foldlevel=100
set foldcolumn=3

" Spell check on for Markdowns, git commits and text files
autocmd FileType markdown,gitcommit,text setlocal spell spelllang=en_us

" Linux Kernel coding style
let g:linuxsty_patterns = [ "/linux/", "/kernel/" , "/vboot_reference/", "/depthcharge/", "coreboot", "e2fsprogs", "sbsigntools"]

" Disable the following option if you don't like vim's Python style.
" It comes with /usr/share/vim/vim<version>/ftplugin/python.vim
" let g:python_recommended_style = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"
let mapleader=","
nmap ; :

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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins, managed by [vim-plug](https://github.com/junegunn/vim-plug).
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

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

" Generally useful plugins
Plug 'scrooloose/nerdtree'
nmap nd :NERDTree<cr>

Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'vim-scripts/tcd.vim'

Plug 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['go'] " In my experience, having anything else here will break it.
" Source about the incompatibility between vim-go and syntastic:
" https://github.com/neoclide/coc.nvim/issues/1048#issuecomment-539809369.

Plug 'autozimu/LanguageClient-neovim', { 'do': 'bash install.sh' }

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

Plug 'junegunn/limelight.vim' " Depends on goyo.
Plug 'junegunn/goyo.vim'
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

Plug 'Vimjas/vim-python-pep8-indent' " Depends on autopep8

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Work-specific settings {{{
  if filereadable($HOME . "/.vim/work.vim")
    source $HOME/.vim/work.vim
  endif
" }}}
