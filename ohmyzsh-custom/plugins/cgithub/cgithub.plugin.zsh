
function __github_pr_select() {
  SELECTED_PR=$(gh pr list --json number,title | jq -r '.[]|"\(.number) \(.title)"' | ipt -S 20 | sed 's/\"//g')
  echo $SELECTED_PR
  gh pr checkout $(echo $SELECTED_PR | awk '{print $1}')
}

alias ghprl='gh pr list'
alias ghprsl=__github_pr_select
alias ghprc='gh pr checks'
alias ghprco='gh pr checkout'
alias ghprst='gh pr status'
alias ghprv='gh pr view'
alias ghpra='gh pr review --approve'
alias ghprrc='gh pr review -r -b'
alias ghprcm='gh pr review --comment -b'

alias ghci='gh issue create'
