alias dbl='docker build -t'

function __dsaf() {
  docker start $(docker ps | awk 'NR==2 {print $1}')
}

function __dsof() {
  docker stop $(docker ps | awk 'NR==2 {print $1}')
}

function __drmf() {
  docker rm $(docker ps -a | awk 'NR==2 {print $1}')
}


function __dsbrm() {
  local sandbox
  if [ -z "$1" ]; then
    local selected_line
    selected_line=$(sbx list | tail -n +2 | \
                    fzf --height 40% --layout=reverse --border --prompt="Eliminar sandbox > ")
    [ -z "$selected_line" ] && return 0
    sandbox=$(echo "$selected_line" | awk '{print $1}')
  else
    sandbox="$1"
  fi

  echo "🗑️ Eliminando sandbox: $sandbox"
  sbx rm "$sandbox"
}

alias dsaf=__dsaf
alias dsoa='docker stop $(docker ps -q)'
alias dsof=__dsof
alias deit='docker exec -it'
alias drmi='docker rmi'
alias drmf=__drmf
alias dsbrm=__dsbrm
