# vim: ft=zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.dotfiles/zsh-custom

# Path to your oh-my-zsh installation.
export ZSH="${HOME}"/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="mymuse"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(
  ## git
#)

source $ZSH/oh-my-zsh.sh

# The git plugin aliases gcl as git clone. I don't want that.
#unalias gcl

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Convenient functions for screen commands.
alias sl='screen -ls'
alias sc='screen'
function sr() {
  screen -r $1
}

function srkill() {
  # Kill a screen session
  echo screen -S $1 -X quit
  screen -S $1 -X quit
}

# Docker shortcuts
function docker_clean() {
  # Delete all containers
  docker rm $(docker ps -a -q)
  # Delete all images
  docker rmi $(docker images -q)
  # Delete all volumes
  sudo rm -rf /var/lib/docker/volumes
}

# gcloud shortcuts
alias gsh="gcloud compute ssh"
alias gimages="gcloud compute images"
alias ginstances="gcloud compute instances"
alias gapp="gcloud app"

alias clr=clear

# vi mode
set -o vi

# Enable reverse history search
# https://unix.stackexchange.com/a/30169
bindkey -v
bindkey '^R' history-incremental-search-backward

# Enable backspace in vi mode
# https://github.com/denysdovhan/spaceship-prompt/issues/91#issuecomment-327996599
bindkey "^?" backward-delete-char

# virsh
export LIBVIRT_DEFAULT_URI=qemu:///system


# Required to vim LimeLight to work
export TERM=xterm-256color

# Disable auto-correct
unsetopt correct_all

# Find disk hogs
alias dus='du -sh ./* | sort -h'

# Show timestamp in the prompt
PROMPT='%{$fg[yellow]%}[%D{%f/%m/%y} %D{%L:%M:%S}] %m '$PROMPT

alias g4p='g4 p'

# Create a temp dir and cd into it
tmp() {
  dir="$(date +'%Y-%m-%d_%H:%M:%S')"
  mkdir "${dir}"
  cd "${dir}"
}

# Load common shell configuration.
if [ -f ~/.profile ]; then
  source ~/.profile
fi

# Load zsh specific configs.
for config_file (~/.zsh/*.zsh(rN)); do
  source $config_file
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
