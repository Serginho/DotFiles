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

plugins=(bazel cgit cgithub extract frontend-search ng timer web-search work colorize images) 

source $ZSH/oh-my-zsh.sh
source $ZSH_CUSTOM/.aliases
source $ZSH_CUSTOM/.functions


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi
