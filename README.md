# DotFiles

Unzip and override this files into user profile directory.
Notice that you have to use *--recursive* for downloading submodules.

## Packages

```
brew install fzf
brew install lsd
```

## Symlinks

Directory ~/
```
ln -s ~/DotFiles/ohmyzsh
ln -s ~/DotFiles/ohmyzsh-custom
ln -s ~/DotFiles/.zshrc
ln -s ./DotFiles/.gitconfig
ln -s ./DotFiles/.ideavimrc
```

Directory .config
```
ln -s ~/DotFiles/nvim
ln -s ~/DotFiles/lsd
```
