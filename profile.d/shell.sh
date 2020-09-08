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

[[ -z "$PS1" ]] && return # interactive only

alias vi=nvim
alias vim="nvim"
export EDITOR='nvim'
export VISUAL=${EDITOR}
export PAGER='less'

if echo "a" | grep --color "a" >/dev/null 2>/dev/null; then
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# fd, a `find` alternative: https://github.com/sharkdp/fd
#alias fd=fdfind

# For GNU screen to allow mouse scrolling.
export TERM=xterm-256color

export PATH=$HOME/.diff-so-fancy:$PATH
alias hgdiff="hg diff | diff-so-fancy | less"

# Add my tools to PATH
export PATH=$HOME/.dotfiles-work/tools/:$HOME/.dotfiles/tools:$PATH

# Go
export PATH=$PATH:/usr/local/go/bin

alias gdb="gdb --silent"
