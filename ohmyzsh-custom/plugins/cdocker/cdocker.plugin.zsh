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


alias dsaf=__dsaf
alias dsoa='docker stop $(docker ps -q)'
alias dsof=__dsof
alias deit='docker exec -it'
alias drmi='docker rmi'
alias drmf=__drmf
