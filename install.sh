#!/bin/bash

# script for installing symlinks from Dropbox to home folder

if [ -d "$HOME/bin" ]
then echo "$HOME/bin already exists. No link was created."
else ln -s $HOME/Dropbox/bin $HOME/bin
        echo "Successfully linked bin"
fi

if [ -d "$HOME/dotfiles" ]
then echo "$HOME/dotfiles already exists. No link was created."
else ln -s $HOME/Dropbox/dotfiles $HOME/dotfiles
        echo "Successfully linked dotfiles"
fi

if [ -f "$HOME/.bashrc" ]
then echo "$HOME/.bashrc already exists. No link was created."
else ln -s $HOME/Dropbox/dotfiles/bashrc $HOME/.bashrc
        echo "Successfully linked bashrc"
fi

if [ -f "$HOME/.inputrc" ]
then echo "$HOME/.inputrc already exists. No link was created."
else ln -s $HOME/Dropbox/dotfiles/inputrc $HOME/.inputrc
        echo "Successfully linked inputrc"
fi

# install homebrew and brews
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install git
brew install bash
brew install tmux
brew install reattach-to-user-namespace
brew install vim
brew install pandoc

# change shell to brew's version of bash
sudo echo "/usr/local/bin/bash" >> /etc/shells
sudo chsh -s /usr/local/bin/bash

# symlinks
ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/tmux-mac.conf $HOME/.tmux-mac.conf

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# install vim plugin manager (vundle)
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
ln -s $HOME/dotfiles/vim/ftplugin $HOME/.vim/ftplugin
ln -s $HOME/dotfiles/vim/spell $HOME/.vim/spell
vim +PluginInstall +qall
