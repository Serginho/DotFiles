
function sharefile() {
  URL=$(curl -s --upload-file $1 https://transfer.sh/$1)
  echo $URL | /usr/bin/pbcopy
  echo "$URL copied on clipboard"
}
