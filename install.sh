#!/bin/bash

# Todo list for setting up a new mac
#
# - [ ] Import mac terminal profile
# - [ ] Check "Use Option as Meta key" in mac terminal
# - [ ] Install Homebrew
# - [ ] Install Macvim
# - [ ] Install Logi options+, login to sync settings
# - [ ] Install Karabiner, link settings, set simple mods for internal keyboard
# - [ ] Install Rectangle, import settings
# - [ ] Setup zsh
# - [ ] Setup neovim
# - [ ] Setup tmux
# - [ ] install dank mono nerd font
# - [ ] Install azure data studio, link settings
# - [ ] Install miniconda
# - [ ] Setup github auth with access tokens

# general terminal stuff
brew install neovim
brew install tmux
brew install htop
brew install trash
brew install fzf
brew install fd
brew install ripgrep
brew install bat
brew install lf

# language server stuff
brew install efm-langserver
brew install npm
npm install -g neovim
npm install -g pyright

# # other language servers (bash, vim, sql)
# npm install -g bash-language-server
# npm install -g vim-language-server
# brew install golang
# go install github.com/lighttiger2505/sqls@latest
# go install github.com/denisenkom/go-mssqldb

# # other brew installs from before
# brew install bash readline
# brew install coreutils findutils grep gnu-sed gawk wget
# brew install jq cloc tree
# brew install openssh openssl
# brew install pandoc pandoc-citeproc pandoc-crossref basictex xpdf

# # brew cask installs from before
# brew install --cask karabiner-elements
# brew install --cask alacritty
# brew install --cask macvim
# brew install --cask rectangle

# install oh my zsh (https://ohmyz.sh/#install)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "" && echo "-- Setting up terminal..."
ln -sfv "$HOME"/dotfiles/zshrc "$HOME"/.zshrc
ln -sfv "$HOME"/dotfiles/gitconfig "$HOME"/.gitconfig
ln -sfv "$HOME"/dotfiles/config/bat "$HOME"/.config/
ln -sfv "$HOME"/dotfiles/config/lf "$HOME"/.config/
ln -sfv "$HOME"/dotfiles/config/pudb "$HOME"/.config/

# install fzf-tab for zsh
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

ln -sfv "$HOME"/dotfiles/config/karabiner/karabiner.json "$HOME"/.config/karabiner/karabiner.json
ln -sfv "$HOME"/dotfiles/config/efm-langserver "$HOME"/.config/

echo "" && echo "-- Setting up tmux..."
ln -sfv "$HOME"/dotfiles/tmux.conf "$HOME"/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf


echo "" && echo "-- Setting up neovim..."
mkdir -pv "$HOME"/.config/nvim
ln -sfv "$HOME"/dotfiles/vimrc "$HOME"/.config/nvim/init.vim
ln -sfv "$HOME"/dotfiles/vim/colors "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/ftdetect "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/ftplugin "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/syntax "$HOME"/.config/nvim/
nvim +PlugInstall -c "TSInstall! python sql bash json vim lua" +qall

echo "" && echo "-- Setting up vim..."
mkdir -pv "$HOME"/.vim
ln -sfv "$HOME"/dotfiles/vimrc "$HOME"/.vimrc
ln -sfv "$HOME"/dotfiles/vim/colors "$HOME"/.vim/
ln -sfv "$HOME"/dotfiles/vim/ftdetect "$HOME"/.vim/
ln -sfv "$HOME"/dotfiles/vim/ftplugin "$HOME"/.vim/
ln -sfv "$HOME"/dotfiles/vim/syntax "$HOME"/.vim/
vim +PlugInstall +qall

echo "" && echo "-- Linking python config..."
mkdir -pv "$HOME"/.ipython/profile_default
ln -sfv "$HOME"/dotfiles/python/ipython_config.py "$HOME"/.ipython/profile_default/ipython_config.py
ln -sfv "$HOME"/dotfiles/python/isort.cfg "$HOME"/.isort.cfg
ln -sfv "$HOME"/dotfiles/python/flake8 "$HOME"/.flake8

echo "" && echo "-- Installing miniconda and python environments..."
# https://docs.conda.io/projects/miniconda/en/latest/
mkdir -p ~/miniconda3
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

echo "" && echo "-- Creating python environment for neovim..."
conda create -y -n neovim
conda deactivate && conda activate neovim
conda install -y python
pip install pynvim

echo "" && echo "-- Setting up Azure Data Studio..."
ln -sfv "$HOME"/dotfiles/misc/azuredatastudio/settings.json "$HOME"/Library/Application\ Support/azuredatastudio/User/settings.json
# https://stackoverflow.com/questions/39972335/how-do-i-press-and-hold-a-key-and-have-it-repeat-in-vscode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
defaults write com.azuredatastudio.oss ApplePressAndHoldEnabled -bool false

