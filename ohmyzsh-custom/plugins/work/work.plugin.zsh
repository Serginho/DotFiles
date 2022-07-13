function __merge_staging() {
  current_branch=`git branch --show`
  git pull --rebase
  git checkout staging
  git pull --rebase
  git checkout $current_branch
  git merge staging
}

alias cdtw='cd && cd tulotero/tulotero-web'
alias cdtwl='cd && cd tulotero/tulotero-web-landing'
alias reruntests="git commit --allow-empty --no-verify -m 'build: rerun tests' && git push"
alias y='yarn'
alias ycse='yarn cli:serve:es'
alias ycsm='yarn cli:serve:mx'
alias ycsu='yarn cli:serve:us'
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
alias yetees='yarn cli:e2e:es'
alias yetemx='yarn cli:e2e:mx'
alias yeteus='yarn cli:e2e:us'
alias yeteses='yarn cli:serve:es:e2e'
alias yetesmx='yarn cli:serve:mx:e2e'
alias yetesus='yarn cli:serve:us:e2e'
alias yetenses='yarn cli:e2e:es:noserver'
alias yetensmx='yarn cli:e2e:mx:noserver'
alias yetensus='yarn cli:e2e:us:noserver'
alias yetedes='yarn cli:e2e:es:debug'
alias yetedmx='yarn cli:e2e:mx:debug'
alias yetedus='yarn cli:e2e:us:debug'
alias yetewes='yarn cli:e2e:es:watch'
alias yetewmx='yarn cli:e2e:mx:watch'
alias yetewus='yarn cli:e2e:us:watch'

alias merge-staging=__merge_staging
