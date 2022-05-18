# ZSH Enviroment Variables

# Brew
export PATH=/opt/homebrew/bin:$PATH

# Web
export PATH="$HOME/.npm-global/bin:$PATH"

# Node
export NODE_OPTIONS=--max_old_space_size=4096

# Arm64 puppetter provide chromium
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`

# LSCOLORS
export LSCOLORS=ExfxbEaEBxxEhEhBaDaCaD