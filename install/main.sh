#!/bin/bash

# To run this install from a new mac, when you don't have the repo yet:
# 
# 1. Install homebrew from https://brew.sh
# 
# echo "" && echo "-- Installing Homebrew..."
# [ -z "$(which brew)" ] &&
#   /bin/bash -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# 
# 2. Install git with homebrew
# 
# brew install git
# 
# 3. Clone this repo
# 
# git clone https://github.com/gabenespoli/dotfiles.git
# 
# 4. Run this script

echo "" && echo "-- Installing Homebrew packages..."
brew install bash readline tmux neovim
brew install coreutils findutils grep gnu-sed gawk
brew install wget lf fd ripgrep fzf bat
brew install jq cloc tree trash htop
brew install openssh openssl
brew install pandoc pandoc-citeproc pandoc-crossref basictex xpdf

brew install --cask karabiner-elements
# brew install --cask alacritty
brew install --cask macvim
brew install --cask rectangle

brew install npm
brew install golang
brew install efm-langserver
# brew install hashicorp/tap/terraform-ls
npm install -g neovim
npm install -g pyright
npm install -g bash-language-server
npm install -g vim-language-server
go install github.com/lighttiger2505/sqls@latest
go install github.com/denisenkom/go-mssqldb

echo "" && echo "-- Adding git bash completion and prompt colors..."
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
rm ~/.bash-git-prompt && git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
ln -sfv "$HOME"/dotfiles/misc/git-prompt-colors.sh "$HOME"/.git-prompt-colors.sh

echo "" && echo "-- Installing tmux plugins..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf

# ~/.dotfiles
ln -sfv "$HOME"/dotfiles/inputrc "$HOME"/.inputrc
ln -sfv "$HOME"/dotfiles/bashrc "$HOME"/.bashrc
ln -sfv "$HOME"/dotfiles/bash_profile "$HOME"/.bash_profile
ln -sfv "$HOME"/dotfiles/tmux.conf "$HOME"/.tmux.conf
ln -sfv "$HOME"/dotfiles/gitconfig "$HOME"/.gitconfig

# ~/.config
ln -sfc "$HOME"/dotfiles/config/karabiner "$HOME"/.config/
ln -sfc "$HOME"/dotfiles/config/alacritty "$HOME"/.config/
ln -sfc "$HOME"/dotfiles/config/efm-langserver "$HOME"/.config/
ln -sfc "$HOME"/dotfiles/config/bat "$HOME"/.config/
ln -sfc "$HOME"/dotfiles/config/lf "$HOME"/.config/
ln -sfc "$HOME"/dotfiles/config/pudb "$HOME"/.config/

# ~/.config/nvim
mkdir -pv "$HOME"/.config/nvim
ln -sfv "$HOME"/dotfiles/vimrc "$HOME"/.config/nvim/init.vim
ln -sfv "$HOME"/dotfiles/vim/colors "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/ftdetect "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/ftplugin "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/syntax "$HOME"/.config/nvim/
nvim +PlugInstall -c "TSInstall! bash python" +qall

# ~/.vim
mkdir -pv "$HOME"/.vim
ln -sfv "$HOME"/dotfiles/vimrc "$HOME"/.vimrc
ln -sfv "$HOME"/dotfiles/vim/colors "$HOME"/.vim/
ln -sfv "$HOME"/dotfiles/vim/ftdetect "$HOME"/.vim/
ln -sfv "$HOME"/dotfiles/vim/ftplugin "$HOME"/.vim/
ln -sfv "$HOME"/dotfiles/vim/syntax "$HOME"/.vim/
vim +PlugInstall +qall
