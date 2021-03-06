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

plugins=(bazel cgit extract frontend-search ng timer web-search work)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

if [[ `uname` == 'Darwin' ]]; then
	alias ls='ls -AFpG'
	export LSCOLORS=ExfxbEaEBxxEhEhBaDaCaD
else
	alias ls='ls -AFpG --color=auto'
	alias clipboard='xclip -i -selection "clipboard"'
fi

# Alias
alias ll='ls -lFh' #size,show type,human readable
alias la='ls -lAFh' #long list,show almost all,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias l='ls -CF' # List no details

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi

