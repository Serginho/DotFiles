# Improve zsh load time
ZSH_DISABLE_COMPFIX="true"

# Speed up zsh compinit by only checking cache once a day.
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
  touch .zcompdump
else
  compinit -C
fi

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
plugins+=(angular bat bazel cgit cgithub extract file frontend-search lsd ng timer web-search work)
[ -z $JIRA_URL ] || plugins+=(jira)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# Brew
export PATH=/opt/homebrew/bin:$PATH

# Web
export PATH="$HOME/.npm-global/bin:$PATH"

# Node
export NODE_OPTIONS=--max_old_space_size=4096

# Arm64 puppetter provide chromium
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`

# Jira
export JIRA_DEFAULT_ACTION='dashboard'
export EDITOR='nvim'

if [[ `uname` == 'Darwin' ]]; then
  #alias ls='ls -AFpG'
  export LSCOLORS=ExfxbEaEBxxEhEhBaDaCaD
else
  alias ls='ls -AFpG --color=auto'
  alias clipboard='xclip -i -selection "clipboard"'
fi

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

# Vim
alias v='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'

# Image optimization
autoload -U convertpng

function convertpng() {
	if [ -z "$1" ]; then
		echo "Usage: $0 [filename]";
	else 
		imagemin --plugin.pngquant.quality={0.1,0.2} "$1.png"  > "$1-op.png";
		mv "$1-op.png" "$1.png";
		echo "Converted $1.png";
	fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi
