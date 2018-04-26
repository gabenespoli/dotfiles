#!/bin/bash

# get this file on your computer first:
# cd $HOME
# sudo apt-get -y install openssh-server
# sudo apt-get -y install git
# git clone https://github.com/gabenespoli/dotfiles

# xterm with italics
# https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
tic -x $HOME/dotfiles/xterm-256color-italics.terminfo
tic -x $HOME/dotfiles/tmux-256color.terminfo

# bash
mv $HOME/.bashrc $HOME/.bashrc.bak
ln -s $HOME/dotfiles/bashrc $HOME/.bashrc
ln -s $HOME/dotfiles/inputrc $HOME/.inputrc
source $HOME/.bashrc
sudo apt-get -y install curl

# dropbox
sudo apt-get -y install nautilus-dropbox
dropbox start -i

# vim
sudo apt-get -y install vim
ln -s $HOME/dotfiles/vimrc $HOME/.vimrc
mkdir $HOME/.vim
ln -s $HOME/dotfiles/vim/autoload $HOME/.vim/autoload
ln -s $HOME/dotfiles/vim/ftdetect $HOME/.vim/ftdetect
ln -s $HOME/dotfiles/vim/ftplugin $HOME/.vim/ftplugin
ln -s $HOME/dotfiles/vim/spell $HOME/.vim/spell
ln -s $HOME/dotfiles/vim/syntax $HOME/.vim/syntax
vim -c "PlugInstall" -c "qall"

# neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get -y install neovim
mkdir -p $HOME/.config/nvim
ln -s "$HOME/vimrc $HOME/.config/nvim/init.vim"
mkdir -p $HOME/.local/share/nvim
ln -s "$HOME/.vim $HOME/.local/share/nvim/site"

# tmux
sudo apt-get -y install tmux
ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
mkdir $HOME/.tmux
# ln -s $HOME/dotfiles/tmux/tmux-mac.conf $HOME/.tmux/tmux-mac.conf
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# ranger
sudo apt-get -y install ranger
ln -s ~/dotfiles/config/ranger ~/.config/ranger

# misc
sudo apt-get -y install tig
ln -s $HOME/dotfiles/tigrc $HOME/.tigrc

