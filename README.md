# DotFiles

Unzip and override this files into user profile directory.
Notice that you have to use _--recursive_ for downloading submodules.

## Packages

```
brew install neovim
brew install fzf
brew install the_silver_searcher
brew install lsd
brew install bat
brew install cloc
brew install gh
brew install git
brew install jq
brew install openai-whisper
```

## NPM Packages

```
npm install -g ipt
```

## Manual packages

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier

```

## Symlinks

Directory ~/

```
ln -s ~/DotFiles/ohmyzsh
ln -s ~/DotFiles/ohmyzsh-custom
ln -s ~/DotFiles/.zshrc
ln -s ./DotFiles/.gitconfig
ln -s ./DotFiles/.ideavimrc
ln -s ./DotFiles/.tmux.conf
```

Directory .config

```
ln -s ~/DotFiles/nvim
ln -s ~/DotFiles/lsd
```

## Raycast

To enable raycast extensions, compile extensions locally

```
yarn install
yarn dev
```

## Plugins

### Jira

Setup your ohmyzsh jira config on your private config file

```
export JIRA_URL='https://url_to_jira_cloud.example'
```
