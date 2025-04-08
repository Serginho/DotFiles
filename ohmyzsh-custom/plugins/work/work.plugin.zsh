function __merge_staging() {
  current_branch=`git branch --show`
  git pull --rebase
  git checkout staging
  git pull --rebase
  git checkout $current_branch
  git merge staging
}

function __package_script_select() {
  local package_json="package.json"

  if [[ ! -f "$package_json" ]]; then
    echo "❌ No se encontró package.json en el directorio actual."
    return 1
  fi

  local scripts=$(jq -r '.scripts | keys[]' "$package_json")
  if [[ -z "$scripts" ]]; then
    echo "⚠️ No se encontraron scripts en package.json."
    return 1
  fi

  local selected=$(echo "$scripts" | fzf --prompt="Selecciona un script: ")

  if [[ -z "$selected" ]]; then
    echo "🚫 Cancelado."
    return 0
  fi

  echo "🚀 Ejecutando: yarn $selected"
  yarn "$selected"
}


alias reruntests="git commit --allow-empty --no-verify -m 'build: rerun tests' && git push"
alias y='yarn'
alias yct='yarn cli:test'
alias yb='yarn bazel'
alias ybb='yarn bazel build'
alias ybt='yarn bazel test'
alias ybr='yarn bazel run'
alias ybc='yarn bazel clean'
alias ybce='yarn bazel clean --expunge'
alias yibt='yarn ibazel test'
alias yibr='yarn ibazel run'
alias yl='yarn lint'
alias yi='yarn install'
alias ys='yarn start'
alias yscr=__package_script_select

alias merge-staging=__merge_staging
