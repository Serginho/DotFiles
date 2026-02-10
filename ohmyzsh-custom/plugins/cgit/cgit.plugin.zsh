

function __create_tag() {
  git tag -a $1 -m "$1"
}

function __delete_branches() {
selected_branches=$(git branch --list | sed 's/\*//g' | fzf --multi)

if [ -n "$selected_branches" ]; then
    while read -r branch; do
        git branch -D "$branch"
    done <<< "$selected_branches"
fi
}

function __gcfd() {
    echo "🔎 Buscando archivos 'untracked' para borrar..."
    # 1. Ejecuta el dry-run primero
    git clean -nfd
    
    # Comprobamos si hay algo que borrar (opcional, pero estético)
    if [ -z "$(git clean -nfd)" ]; then
        echo "✨ Nada que borrar."
        return
    fi

    echo ""
    # 2. Pregunta al usuario (read -q lee un solo caracter, sin necesidad de Enter)
    if read -q "choice?⚠️  ¿Quieres borrar estos archivos permanentemente? (y/N) "; then
        echo "\n🗑️  Borrando..."
        # 3. Si es 'y', ejecuta el borrado real
        git clean -fd
    else
        echo "\n🛡️  Cancelado. No se borró nada."
    fi
}

alias g='git'
alias gst='git status'
alias gss='git status -s'
alias gcb='git checkout -b'
alias gbd='git branch -d'
alias gbl='git branch -l'
alias gbcp='git branch --show-current | pbcopy' 
alias gco='git checkout'
alias gcfd=__gcfd
alias gbd=__delete_branches
alias ga='git add -A'
alias gca='git commit --amend'
alias gcam='git commit -a -m'
alias gm='git merge'
alias gms='git merge --squash'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias gpr='git pull --rebase'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdw='git diff --word-diff'
alias grm='git rm'
alias grmc='git rm --cached'
alias gr='git reset --'
alias grh='git reset --hard'
alias gl='git log --graph --pretty='\''%C(yellow)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias gsta='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'
alias grev='git revert'
alias gct=__create_tag
alias grt='git tag -d'
alias grrt='git push --delete origin';
alias gpt='git push origin'









# Git Worktree

function __gwco() {
  if [ -z "$1" ]; then
    echo "❌ Error: Debes especificar el nombre de la rama."
    echo "Uso: gwco <rama> [base]"
    return 1
  fi

  local branch="$1"
  local base="${2:-HEAD}"

  local repo_root
  repo_root=$(git rev-parse --show-toplevel) || return 1
  
  local repo_name
  repo_name=$(basename "$repo_root")

  local parent_dir
  parent_dir=$(dirname "$repo_root")

  local branch_folder="${branch//\//-}"

  local target_dir="$parent_dir/$repo_name-$branch_folder"

  echo "🚀 Configurando worktree..."
  echo "📂 Origen: $repo_name ($base)"
  echo "📂 Destino: $target_dir"

  git worktree add -b "$branch" "$target_dir" "$base" 2>/dev/null || \
  git worktree add "$target_dir" "$branch"

  cd "$target_dir" 
}

function _gwco_autocomplete() {
  local -a branches
  branches=("${(@f)$(git branch --all --format='%(refname:short)' 2>/dev/null)}")
  compadd -- "${branches[@]}"
}

compdef _gwco_autocomplete __gwco gwco

function gwcof() {
  git rev-parse --is-inside-work-tree > /dev/null 2>&1 || return 1

  local selected_line
  selected_line=$(git worktree list | \
                  fzf --height 40% --layout=reverse --border --prompt="Ir al worktree > " --query="$1")

  if [ -z "$selected_line" ]; then
    return 0
  fi

  local target_dir
  target_dir=$(echo "$selected_line" | awk '{print $1}')

  echo "🚀 Cambiando directorio..."
  echo "📂 Destino: $target_dir"
  
  cd "$target_dir"
}
function __gwrm() {
  if [ -z "$1" ]; then
    echo "❌ Error: Debes especificar el nombre del worktree."
    echo "Uso: gwrm <worktree>"
    return 1
  fi

  local worktree="$1"
  local repo_root
  repo_root=$(git worktree list --porcelain | awk '/worktree/ {print $2; exit}')

  local parent_dir
  parent_dir=$(dirname "$repo_root")

  local target_dir="$parent_dir/$worktree"

  echo "🗑️ Eliminando worktree..."
  echo "📂 Worktree: $target_dir"

  git worktree remove "$target_dir" --force && rm -rf "$target_dir"

  echo "🔙 Volviendo al repositorio principal..."
  cd "$repo_root" || return 1
}


function __gwrp() {
  local repo_root
  repo_root=$(git worktree list --porcelain | awk '/worktree/ {print $2; exit}')

  if [ -z "$repo_root" ]; then
    echo "❌ Error: No estás dentro de un repositorio Git o worktree."
    return 1
  fi

  echo "🔙 Volviendo al directorio original del repositorio..."
  cd "$repo_root" || return 1
}

function _gwrm_autocomplete() {
  local -a worktrees
  worktrees=("${(@f)$(git worktree list --porcelain 2>/dev/null | grep '^worktree' | cut -d' ' -f2 | tail -n +2 | xargs -I{} basename {})}")
  compadd -- "${worktrees[@]}"
}

compdef _gwrm_autocomplete __gwrm gwrm

alias gwl='git worktree list';
alias gwco=__gwco;
alias gwrm=__gwrm;
alias gwrp=__gwrp;


