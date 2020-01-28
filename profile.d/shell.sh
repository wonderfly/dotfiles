[[ -z "$PS1" ]] && return # interactive only

alias vi=vim
export EDITOR='vim'
export VISUAL=${EDITOR}
export PAGER='less'

if echo "a" | grep --color "a" >/dev/null 2>/dev/null; then
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
