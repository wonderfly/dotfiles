# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -x EDITOR vim
set -x VISUAL $EDITOR
set -x PAGER less

if echo "a" | grep --color "a" >/dev/null 2>/dev/null
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
end

# fd, a `find` alternative: https://github.com/sharkdp/fd
# if test (uname -a) =~ *Debian*
if string match -rq 'Debian' (uname -a)
  # On Debian and Ubuntu fd is taken by another package.
  alias fd=fdfind
end

# For GNU screen to allow mouse scrolling.
set -x TERM xterm-256color

set -x PATH $HOME/.diff-so-fancy $PATH
alias hgdiff="hg diff | diff-so-fancy | less"

# Add my tools to PATH
set -x PATH $HOME/.dotfiles-work/tools/ $HOME/.dotfiles/tools $PATH

# Go
set -x PATH $PATH /usr/local/go/bin

# llvm and clang
if test (uname) = "Darwin" 
  set -x PATH $PATH /usr/local/opt/llvm/bin
end

alias gdb="gdb --silent"

# Alway turn on colorization for tree.
alias tree="tree -C"

if test -d "$HOMEBREW_HOME/opt/fzf"
  set -x FZF_HOME "$HOMEBREW_HOME/opt/fzf"
end

if test -z "$FZF_HOME" && test -d $HOME/.fzf
  set -x FZF_HOME $HOME/.fzf
end

if test -n "$FZF_HOME"
  set -x PATH "$FZF_HOME/bin:$PATH"
end

# General fzf settings.
set -x FZF_DEFAULT_OPTS " \
  --inline-info \
  --reverse \
  --exact \
  --color=fg+:#F8F8F8,bg+:#515559,pointer:#F8F8F8,marker:226 \
  --bind=ctrl-e:select-all+accept \
  --bind=ctrl-d:half-page-down \
  --bind=ctrl-e:half-page-up
  --bind=ctrl-t:toggle+down
  --bind=ctrl-b:toggle+up
  --bind=ctrl-g:select-all+accept \
  "
