# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bira"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rails)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#Custom Alias
alias emacs='emacs -nw'
alias clipboard='xclip -i -selection "clipboard"'
#some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -AFpG --color=auto'

alias lamppstart='sudo service apache2 start && sudo service mysql start'
alias lamppstop='sudo service apache2 stop && sudo service mysql stop'
alias lampprestart='sudo service apache2 restart && sudo service mysql restart'

alias agroot='cd /var/www/agencias'

#Java
export JAVA_HOME=/opt/jdk1.7.0_67
PATH=$JAVA_HOME/bin:$PATH

#NodeJS
export NODE_HOME=/opt/nodejs
PATH=$NODE_HOME/bin:$PATH

##PHP
#export PHP_HOME=/opt/lampp
#PATH=$PHP_HOME/bin:$PATH

#Twitch Streaming
#streaming() {
	#INRES="1920x1080" # input resolution
	#OUTRES="1280x720" # output resolution
	#FPS="15" # target FPS
	#GOP="30" # i-frame interval, should be double of FPS, 
	#GOPMIN="15" # min i-frame interval, should be equal to fps, 
	#THREADS="4" # max 6
	#CBR="1000k" # constant bitrate (should be between 1000k - 3000k)
	#QUALITY="ultrafast"  # one of the many FFMPEG preset
	#AUDIO_RATE="44100"
	#STREAM_KEY="$1" # use the terminal command Streaming streamkeyhere to stream your video to twitch or justin
	#SERVER="live-fra" # twitch server in frankfurt, see http://bashtech.net/twitch/ingest.php for list

	#ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0 -f alsa -i pulse -f flv -ac 2 -ar $AUDIO_RATE \
		#-vcodec libx264 -g $GOP -keyint_min $GOPMIN -b $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p\
		#-s $OUTRES -preset $QUALITY -tune film -acodec libmp3lame -threads $THREADS -strict normal \
		#-bufsize $CBR "rtmp://$SERVER.twitch.tv/app/$STREAM_KEY"
#}
