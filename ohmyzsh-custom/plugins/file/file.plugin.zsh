
function sharefile() {
  URL=$(curl -s --upload-file $1 https://transfer.sh/$1)
  echo $URL | /usr/bin/pbcopy
  echo "$URL copied on clipboard"
}

function fh() {
  eval $(history | fzf +s --tac | sed 's/ *[0-9]* *//')
}
