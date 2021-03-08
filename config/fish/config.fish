set -x EDITOR 'vim'

alias sl='screen -ls'
alias sc='screen'
function sr
  screen -r $argv[1]
end

function srkill
  # Kill a screen session
  echo screen -S $argv[1] -X quit
  screen -S $argv[1] -X quit
end

# Docker shortcuts
function docker_clean
  # Delete all containers
  docker rm (docker ps -a -q)
  # Delete all images
  docker rmi (docker images -q)
  # Delete all volumes
  sudo rm -rf /var/lib/docker/volumes
end

# gcloud shortcuts
alias gsh="gcloud compute ssh"
alias gimages="gcloud compute images"
alias ginstances="gcloud compute instances"
alias gapp="gcloud app"

alias clr=clear

# vi mode
fish_vi_key_bindings

# virsh
set -x LIBVIRT_DEFAULT_URI qemu:///system

# Required to vim LimeLight to work
set -x TERM xterm-256color

# Disable auto-correct
# unsetopt correct_all

# Find disk hogs
alias dus='du -sh ./* | sort -h'

# Show timestamp in the prompt
# PROMPT='%{$fg[yellow]%}[%D{%f/%m/%y} %D{%L:%M:%S}] %m '$PROMPT
function fish_right_prompt
  set_color yellow
  echo (date +"%D %T") (set_color normal)
end

function fish_prompt
  set exit_status $status 
  set_color yellow
  printf (prompt_pwd)
  if test $exit_status != 0
    set_color red
    printf "[$exit_status]"
    set_color yellow
  end
  echo '>' (set_color normal)
end

alias g4p='g4 p'

# Create a temp dir and cd into it
function tmp
  set dir "(date +'%Y-%m-%d_%H:%M:%S')"
  mkdir "$dir"
  cd "$dir"
end

# Load common shell configuration.
# if [ -f ~/.profile ]; then
#   source ~/.profile
# fi

# Load zsh specific configs.
# for config_file in (~/.zsh/*.zsh(rN))
#   source $config_file
# end

function which
  set -l target $argv[1]
  set -l which_output (command which $target)
  if string match -rq $target $which_output
    echo $which_output
    return
  end
  set -l IFS ""
  set -l functions_output (functions $target)
  if string match -rq $target $functions_output
    echo "$functions_output"
    return
  end
  echo "`$target` is not a command, alias or function."
  exit 1
end
