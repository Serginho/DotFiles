function __merge_staging() {
  current_branch=`git branch --show`
  git pull --rebase
  git checkout staging
  git pull --rebase
  git checkout $current_branch
  git merge staging
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

alias merge-staging=__merge_staging
