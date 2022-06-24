# Image optimization
function convert_png() {
  if [[ -d $1 ]]
  then
    for file in "$1"/*
      do
        echo "Converting $file ..."
        npx @squoosh/cli --oxipng auto $file
      done
  else
      npx @squoosh/cli --oxipng auto $1
  fi
}

function convert_jpg() {
  if [[ -d $1 ]]
  then
    for file in "$1"/*
      do
        echo "Converting $file ..."
        npx @squoosh/cli --mozjpeg auto $file
      done
  else
      npx @squoosh/cli --mozjpeg auto $1
  fi
}

function convert_webp() {
  if [[ -d $1 ]]
  then
    for file in "$1"/*
      do
        echo "Converting $file ..."
        npx @squoosh/cli --webp auto $file
      done
  else
      npx @squoosh/cli --webp auto $1
  fi
}
