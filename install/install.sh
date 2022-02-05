#!/bin/bash

echo "" && echo "-- Installing Homebrew..."
[ -z "$(which brew)" ] &&
  /bin/bash -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "" && echo "-- Installing Homebrew packages..."
brew install git
brew install bash readline coreutils findutils grep gnu-sed gawk wget
brew install tmux neovim lf git fd ripgrep fzf bat jq cloc tree trash
brew install reattach-to-user-namespace openssh openssl
brew install pandoc pandoc-citeproc pandoc-crossref basictex

brew install --cask karabiner-elements
brew install --cask alacritty
brew install --cask macvim

brew install npm
brew install efm-langserver
npm install -g pyright
npm install -g bash-language-server
npm install -g vim-language-server
npm install -g yaml-language-server

echo "" && echo "-- Adding git bash completion and prompt colors..."
if [ ! -e ~/.git-completion.bash ]; then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

echo "" && echo "-- Installing tmux plugins..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf

echo "-- Symlinking files and directories..."

for rc in inputrc bashrc bash_profile tmux.conf gitconfig git-prompt-colors.sh; do
  ln -sfv "$HOME"/dotfiles/"$rc" "$HOME"/."$rc"
done

for cfg in karabiner alacritty efm-langserver bat lf pudb; do
  ln -sfv "$HOME"/dotfiles/config/"$cfg" "$HOME"/.config/
done

mkdir -p "$HOME"/.vim
mkdir -p "$HOME"/.config/nvim
ln -sfv "$HOME"/dotfiles/vimrc "$HOME"/.vimrc
ln -sfv "$HOME"/dotfiles/vimrc "$HOME"/.config/nvim/init.vim
for folder in colors ftdetect ftplugin syntax; do
  ln -sfv "$HOME"/dotfiles/vim/"$folder" "$HOME"/.vim/"$folder"
  ln -sfv "$HOME"/dotfiles/vim/"$folder" "$HOME"/.config/nvim/"$folder"
done
vim +PlugInstall +qall
nvim +PlugInstall -c "TSInstall! vim bash python r" +qall

echo "" && echo "-- Adding updated bash to the list of allowed shells..."
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells' # Prompts for password
chsh -s /usr/local/bin/bash # Change to the new shell, prompts for password
