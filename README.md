# DotFiles

Unzip and override this files into user profile directory.
Notice that you have to use *--recursive* for downloading submodules.

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
brew install pixz 
```

## NPM Packages

```
npm install -g ipt
npm install -g @squoosh/cli (Node v16 required)
```

## Symlinks

Directory ~/
```
ln -s ~/DotFiles/ohmyzsh
ln -s ~/DotFiles/ohmyzsh-custom
ln -s ./DotFiles/.zshrc
ln -s ./DotFiles/.zshenv
ln -s ./DotFiles/.zshaliases
ln -s ./DotFiles/.gitconfig
ln -s ./DotFiles/.ideavimrc
```

Directory .config
```
ln -s ~/DotFiles/nvim
ln -s ~/DotFiles/lsd
```

## PlugInstall vim
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
