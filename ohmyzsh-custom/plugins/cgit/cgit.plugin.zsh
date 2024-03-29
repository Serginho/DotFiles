

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

alias g='git'
alias gst='git status'
alias gss='git status -s'
alias gcb='git checkout -b'
alias gbd='git branch -d'
alias gbcp='git branch --show-current | pbcopy' 
alias gco='git checkout'
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
