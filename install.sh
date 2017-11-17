#!/bin/bash

# script for installing symlinks from this dotfiles folder to home folder
# https://github.com/gabenespoli/dotfiles

# path to dotfiles dir
dotfiles="$HOME/dotfiles"

# loop through input args, switch case to install different things
for arg in $@
do
    case "$arg" in
        bashrc )
            mv "$HOME/.bashrc $HOME/.bashrc.bak"
            ln -s "$dotfiles/bashrc $HOME/.bashrc"
            ln -s "$dotfiles/bash_profile $HOME/.bash_profile"
            ln -s "$dotfiles/inputrc $HOME/.inputrc"
            ;;

        vim )
            #vim
            ln -s "$dotfiles/vimrc $HOME/.vimrc"
            mkdir $HOME/.vim
            declare -a dirs=("after" "colors" "ftplugin" "spell" "ftdetect" "syntax" "autoload")
            for dir in "${dirs[@]}"
            do
                ln -s "$dotfiles/vim/$dir $HOME/.vim/$dir"
            done
            # nvim
            mkdir -p $HOME/.config/nvim
            ln -s "$dotfiles/vimrc $HOME/.config/nvim/init.vim"
            mkdir -p $HOME/.local/share/nvim
            ln -s "$HOME/.vim $HOME/.local/share/nvim/site"
            ;;

        tmux )
            ln -s "$dotfiles/tmux.conf $HOME/.tmux.conf"
            mkdir $HOME/.tmux
            ln -s "$dotfiles/tmux/tmux-mac.conf $HOME/.tmux/.tmux-mac.conf"
            ln -s "$dotfiles/tmux/tmux-linux.conf $HOME/.tmux/.tmux-linux.conf"
            git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
            ;;

        todo )
            ln -s "$HOME/Dropbox/todo $HOME/todo"
            ln -s "$dotfiles/todo.cfg $HOME/.todo.cfg"
            ln -s "$dotfiles/todo.actions.d $HOME/.todo.actions.d"
            ;;

        folders )
            ln -s "$HOME/Dropbox/bin $HOME/bin"
            ln -s "$HOME/Dropbox/bin/private $HOME/private"
            ln -s "$HOME/Dropbox/projects $HOME/projects"
            mkdir "$HOME/local"
            ;;

        pandoc )
            ln -s "$dotfiles/pandoc $HOME/.pandoc"
            ;;

        coding )
            ln -s "$dotfiles/gitconfig $HOME/.gitconfig"
            ln -s "$dotfiles/octaverc $HOME/.octaverc"
            ln -s "$dotfiles/Rprofile $HOME/.Rprofile"
            ln -s "$dotfiles/ipython $HOME/.ipython"
            ln -s "$dotfiles/highlight $HOME/.highlight"
            ;;

        email )
            ln -s "$dotfiles/muttrc $HOME/.muttrc"
            ln -s "$dotfiles/mutt $HOME/.mutt"
            ln -s "$dotfiles/msmtprc $HOME/.msmtprc"
            ln -s "$HOME/bin/private/offlineimaprc $HOME/.msmtprc"
            ln -s "$HOME/bin/private/goobookrc $HOME/.goobookrc"
            ;;

        mac )
            # install homebrew
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

            brew install git
            brew install bash
            brew install vim
            brew install tmux
            brew install reattach-to-user-namespace
            brew install ranger

            brew install python
            brew install python3
            brew install octave
            brew install r
            brew install rbenv

            pip2 install ipython scipy numpy pandas matplotlib scikit-learn

            brew install mutt
            brew install offlineimap
            brew install msmtp
            brew install urlview
            pip2 install urlscan
            pip install goobook

            brew install pandoc
            brew install pandoc-citeproc

            brew install rlwrap
            brew install ctags
            pip3 install hangups

            # change shell to brew's version of bash
            sudo echo "/usr/local/bin/bash" >> /etc/shells
            sudo chsh -s /usr/local/bin/bash
            ;;

        linux )
            sudo apt-get install git
            sudo apt-get install vim
            sudo apt-get install nvim
            sudo apt-get install tmux
            git clone https://github.com/ranger/ranger "$HOME/local"

            sudo apt-get install r-base
            sudo apt-get install octave
            sudo apt-get install rbenv
            sudo apt-get install ipython
            sudo apt-get install python-pip
            pip install scipy numpy pandas matplotlib scikit-learn

            sudo apt-get install pandoc
            sudo apt-get install pandoc-citeproc
            sudo apt-get install ctags
            sudo apt-get install rlwrap
            ;;

    esac
done
