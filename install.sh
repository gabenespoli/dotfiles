#!/bin/bash

# script for installing symlinks from this dotfiles folder to home folder
# https://github.com/gabenespoli/dotfiles

# get path of current dir
dotfilesDir=`pwd`

# loop through input args, switch case to install different things
for arg in $@
do
    case "$arg" in
        bashrc )
            if [ -f "$HOME/.bashrc" ]; then
                echo "$HOME/.bashrc already exists. No link was created."
            else
               ln -s "${dotfilesDir}/bashrc $HOME/.bashrc"
                echo "$HOME/.bashrc successfully linked"
            fi
            ;;
        vim )
            if [ -f "$HOME/.vimrc" ] || [ -d "$HOME/.vim" ] ; then
                echo "$HOME/.vimrc or .vim/ already exist. No links were created."
            else
                ln -s "${dotfilesDir}/vimrc $HOME/.vimrc"
                mkdir $HOME/.vim
                    
                declare -a dirs=("after" "colors" "ftplugin" "spell")
                for dir in "${dirs[@]}"
                do
                    ln -s "${dotfilesDir}/vim/$dir $HOME/.vim/$dir"
                done
                echo "Successfully linked .vimrc and .vim/"

                echo "Installing Vundle and installing plugins..."
                git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
                vim +PluginInstall +qall
                echo "Done."
            fi
            ;;
        tmux )
            if [ -f "$HOME/.tmux.conf" ] || [ -d "$HOME/.tmux" ] ; then
                echo "$HOME/.tmux.conf or .tmux/ already exist. No links were created."
            else
                ln -s "${dotfilesDir}/tmux.conf $HOME/.tmux.conf"
                mkdir $HOME/.tmux

                declare -a dirs=("tmux-gmac.conf" "tmux-mac.conf" "tmux-reset.conf")
                for dir in "${dirs[@]}"
                do
                    ln -s "${dotfilesDir}/vim/$dir $HOME/.vim/$dir"
                done
                echo "Successfully linked .vimrc and .vim/"

                echo "Installing Tmux Plugin Manager (TPM)..."
                git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
                tmux source $HOME/.tmux.conf
            fi
    esac
done

## install homebrew
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

### essentials
#brew install git
#brew install bash
#brew install vim
#brew install tmux
#brew install reattach-to-user-namespace
#brew install ranger

### languages
#brew install python
#brew install octave
#brew install r
#brew install rbenv

### research
#pip2 install ipython
#pip2 install scipy
#pip2 install numpy
#pip2 install matplotlib
#pip2 install pandas
#pip2 install scikit-learn

### email
#brew install mutt
#brew install offlineimap
#brew install msmtp
#brew install urlview
#pip2 install urlscan
#pip install goobook

### docs
#brew install pandoc
#brew install pandoc-citeproc

### other
#brew install rlwrap
#brew install ctags
#pip3 install hangups

## change shell to brew's version of bash
#sudo echo "/usr/local/bin/bash" >> /etc/shells
#sudo chsh -s /usr/local/bin/bash

## python packages
