#!/bin/bash

# Todo list for setting up a new mac
# - [ ] Install git
# - [ ] Install homebrew (https://brew.sh/)
# - [ ] Install fonts (Mono Lisa, Dank Mono)
# - [ ] Install Logi options+, login to sync settings
# - [ ] Clone dotfiles into ~/dotfiles
# - [ ] Run this script (install.sh)
# - [ ] Set user and email in ~/dotfiles/.git/config
# - [ ] Add ~/.gitconfig-local containing user/email
# - [ ] Add ~/.bash_local with custom stuff
# - [ ] Setup github auth with access tokens

# general terminal stuff
brew install coreutils findutils grep gnu-sed gawk wget
brew install fd ripgrep fzf
brew install htop lf eza tree trash cloc jq
brew install tmux neovim
brew install pyenv pyenv-virtualenv

# casks
brew install --cask karabiner-elements
brew install --cask ghostty
brew install --cask rectangle
brew install --cask macvim

# language server stuff
brew install efm-langserver
brew install npm
npm install -g neovim
npm install -g pyright

# terminal
mkdir -pv "$HOME"/.config/ghostty
ln -sfv "$HOME"/dotfiles/ghostty "$HOME"/.config/ghostty/config
ln -sfv "$HOME"/dotfiles/zshrc "$HOME"/.zshrc
ln -sfv "$HOME"/dotfiles/gitconfig "$HOME"/.gitconfig
ln -sfv "$HOME"/dotfiles/p10k.zsh "$HOME"/.p10k.zsh
mkdir -pv "$HOME"/.config/lf
ln -sfv "$HOME"/dotfiles/lfrc "$HOME"/.config/lf/lfrc

# karabiner
ln -sfv "$HOME"/dotfiles/config/karabiner "$HOME"/.config
ln -sfv "$HOME"/dotfiles/config/efm-langserver "$HOME"/.config/

# tmux
ln -sfv "$HOME"/dotfiles/tmux.conf "$HOME"/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf

# Setup terminfo for italics inside tmux (https://gist.github.com/nicm/ea9cf3c93f22e0246ec858122d9abea1)
tic -x "$HOME"/dotfiles/misc/tmux-256color.terminfo

# install oh my zsh (https://ohmyz.sh/#install)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-^/.oh-my-zsh/custom}/plugins/fzf-tab

# install powerlevel10k theme (https://github.com/romkatv/powerlevel10k)
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# neovim
mkdir -pv "$HOME"/.config/nvim
ln -sfv "$HOME"/dotfiles/vimrc "$HOME"/.config/nvim/init.vim
ln -sfv "$HOME"/dotfiles/vim/colors "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/ftdetect "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/ftplugin "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/syntax "$HOME"/.config/nvim/
nvim +PlugInstall -c "TSInstall! python sql bash json vim lua" +qall

# vim (for macvim)
mkdir -pv "$HOME"/.vim
ln -sfv "$HOME"/dotfiles/vimrc "$HOME"/.vimrc
ln -sfv "$HOME"/dotfiles/vim/colors "$HOME"/.vim/
ln -sfv "$HOME"/dotfiles/vim/ftdetect "$HOME"/.vim/
ln -sfv "$HOME"/dotfiles/vim/ftplugin "$HOME"/.vim/
ln -sfv "$HOME"/dotfiles/vim/syntax "$HOME"/.vim/
vim +PlugInstall +qall

# python
mkdir -pv "$HOME"/.ipython/profile_default
ln -sfv "$HOME"/dotfiles/python/ipython_config.py "$HOME"/.ipython/profile_default/ipython_config.py
ln -sfv "$HOME"/dotfiles/python/isort.cfg "$HOME"/.isort.cfg
ln -sfv "$HOME"/dotfiles/python/flake8 "$HOME"/.flake8

# miniconda
# # https://docs.conda.io/projects/miniconda/en/latest/
# mkdir -p ~/miniconda3
# curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/miniconda3/miniconda.sh
# bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
# rm -rf ~/miniconda3/miniconda.sh

# neovim python host prog
# conda create -y -n neovim
# conda deactivate && conda activate neovim
# conda install -y python
# pip install pynvim black isort

# pyenv
pyenv install 3.10
pyenv install 3.11

# neovim python host prog
pyenv virtualenv 3.11 neovim
pyenv activate neovim
pip install pynvim black isort

# echo "" && echo "-- Installing Microsoft ODBC..."
# # https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/install-microsoft-odbc-driver-sql-server-macos
# brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
# brew update
# HOMEBREW_ACCEPT_EULA=Y brew install msodbcsql17
# # brew install mssql-tools # install sqlcmd and bcp
# # brew install sqlcmd # install the go version of sqlcmd

