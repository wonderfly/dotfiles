if [ -d "$HOMEBREW_HOME/opt/fzf" ]; then
  export FZF_HOME="$HOMEBREW_HOME/opt/fzf"
fi

if [ -z "$FZF_HOME" ] && [ -d $HOME/.fzf ]; then
  export FZF_HOME=$HOME/.fzf
fi

if [ -n "$FZF_HOME" ]; then
  export PATH="$FZF_HOME/bin:$PATH"
fi

if command -v fzf > /dev/null; then
  # open recently edited files in vim (https://github.com/junegunn/fzf/wiki/Examples#v)
  v() {
    local files
    files=$(grep '^>' ~/.viminfo | cut -c3- |
            while read line; do
              [ -f "${line/\~/$HOME}" ] && echo "$line"
            done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
  }

  # cd to recently opened directories (https://github.com/junegunn/fzf/wiki/Examples#z)
  j() {
    [ $# -gt 0 ] && _z "$*" && return
    cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf-tmux +s --tac --query "$*")"
  }
fi
