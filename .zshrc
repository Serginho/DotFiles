# Path to your oh-my-zsh installation.
export ZSH_CUSTOM=$HOME/ohmyzsh-custom
export ZSH=$HOME/ohmyzsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gruvbox"

TIMER_PRECISION=0
TIMER_FORMAT='%d'

[ -z $plugins ] && plugins=()
plugins+=(ai angular bat bazel cdocker cgit cgithub extract file frontend-search lsd ng timer tmux web-search work yt)
[ -z $JIRA_URL ] || plugins+=(jira)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

if [[ `uname` == 'Darwin' ]]; then
  #alias ls='ls -AFpG'
  export LSCOLORS=ExfxbEaEBxxEhEhBaDaCaD
else
  alias clipboard='xclip -i -selection "clipboard"'
fi

# pbcopy outside macOS: copy to the terminal clipboard using OSC 52
# (works over SSH and inside tmux with "set-clipboard on")
if ! (( $+commands[pbcopy] )); then
  function pbcopy() {
    printf '\033]52;c;%s\a' "$(base64 | tr -d '\n')" > /dev/tty
  }
fi

# Brew
[ -d /opt/homebrew/bin ] && export PATH=/opt/homebrew/bin:$PATH


alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias grep='grep --color'
alias t='tail -f'

alias h='history'
alias hg='history | grep'
alias hgi='history | grep -i'

alias help='man'
alias p='ps -f'
alias sortnr='sort -n -r'

alias merge-staging-master='git co master && git merge staging && git p && git co staging'

# Vim
alias v='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'

# Tmux tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
(( $+commands[tmuxifier] )) && eval "$(tmuxifier init -)"

# Web
export PATH="$HOME/.npm-global/bin:$PATH"

# Image optimization

function convertpng() {
	if [ -z "$1" ]; then
		echo "Usage: $0 [filename]";
	else 
		imagemin --plugin.pngquant.quality={0.1,0.2} "$1.png"  > "$1-op.png";
		mv "$1-op.png" "$1.png";
		echo "Converted $1.png";
	fi
}

if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
elif (( $+commands[fzf] )) && fzf --zsh &> /dev/null; then
  source <(fzf --zsh)
fi
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi

# Node
export NODE_OPTIONS=--max_old_space_size=4096

# Arm64 puppetter provide chromium
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
(( $+commands[chromium] )) && export PUPPETEER_EXECUTABLE_PATH=$commands[chromium]

# Jira
export JIRA_DEFAULT_ACTION='dashboard'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
