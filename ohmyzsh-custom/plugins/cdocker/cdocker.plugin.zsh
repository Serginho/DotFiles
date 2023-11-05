alias dbl='docker build -t'
alias dsaf="docker start $(docker ps | awk 'NR==2 {print $1}')"
alias dsoa='docker stop $(docker ps -q)'
alias dsof="docker stop $(docker ps | awk 'NR==2 {print $1}')"
alias deit='docker exec -it'
alias drmi='docker rmi'
alias drmf="docker rm $(docker ps -a | awk 'NR==2 {print $1}')"
