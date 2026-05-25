#!/bin/bash
set -e

# =============================================================================
# New Mac Setup Script
# =============================================================================
#
# Prerequisites (do these manually before running this script):
#   1. Install Xcode Command Line Tools (includes git):
#      xcode-select --install
#   2. Install Homebrew (https://brew.sh):
#      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#   3. Clone this repo:
#      git clone https://github.com/gabenespoli/dotfiles.git ~/dotfiles
#   4. Run this script:
#      cd ~/dotfiles && bash install.sh
#
# After running this script:
#   - [ ] Create ~/.gitconfig_local with your name/email:
#         [user]
#           name = Your Name
#           email = your@email.com
#   - [ ] Create ~/.bash_local with machine-specific shell commands
#   - [ ] Setup GitHub auth (SSH key or personal access token)
#   - [ ] Install fonts (Mono Lisa, Dank Mono) — these are paid/licensed
#   - [ ] Import misc/RectangleConfig.json into Rectangle
#   - [ ] Restart your terminal to pick up zsh/p10k changes
# =============================================================================

# install stuff
brew install coreutils findutils grep gnu-sed gawk wget
brew install fd ripgrep fzf
brew install htop lf eza tree trash cloc jq
brew install tmux neovim
brew install uv ruff pyright

brew install --cask karabiner-elements
brew install --cask rectangle
brew install --cask ghostty
brew install --cask macvim

brew install npm
npm install -g neovim

brew install rust
source "$HOME/.cargo/env"
cargo install --locked tree-sitter-cli

brew install anomalyco/tap/opencode

# link files
ln -sfv "$HOME"/dotfiles/zshrc "$HOME"/.zshrc
ln -sfv "$HOME"/dotfiles/p10k.zsh "$HOME"/.p10k.zsh
ln -sfv "$HOME"/dotfiles/gitconfig "$HOME"/.gitconfig
ln -sfv "$HOME"/dotfiles/tmux.conf "$HOME"/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -pv "$HOME"/.config/ghostty
ln -sfv "$HOME"/dotfiles/ghostty "$HOME"/.config/ghostty/config
ln -sfv "$HOME"/dotfiles/config/ghostty-themes "$HOME"/.config/ghostty/themes
ln -sfv "$HOME"/dotfiles/config/lf "$HOME"/.config
ln -sfv "$HOME"/dotfiles/config/karabiner "$HOME"/.config
ln -sfv "$HOME"/dotfiles/config/ruff "$HOME"/.config
ln -sfv "$HOME"/dotfiles/config/eza "$HOME"/.config
mkdir -pv "$HOME"/.config/opencode
ln -sfv "$HOME"/dotfiles/config/opencode/opencode.json "$HOME"/.config/opencode
ln -sfv "$HOME"/dotfiles/config/opencode/themes "$HOME"/.config/opencode

# setup terminfo for italics inside tmux (https://gist.github.com/nicm/ea9cf3c93f22e0246ec858122d9abea1)
tic -x "$HOME"/dotfiles/misc/tmux-256color.terminfo

# python
mkdir -pv "$HOME"/.ipython/profile_default
ln -sfv "$HOME"/dotfiles/python/ipython_config.py "$HOME"/.ipython/profile_default/ipython_config.py

# python tools for neovim
uv tool install pynvim
uv tool install jupytext

# neovim
mkdir -pv "$HOME"/.config/nvim
ln -sfv "$HOME"/dotfiles/config/nvim/init.lua "$HOME"/.config/nvim/init.lua
ln -sfv "$HOME"/dotfiles/config/nvim/lua "$HOME"/.config/nvim/lua
ln -sfv "$HOME"/dotfiles/vim/colors "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/ftdetect "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/ftplugin "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/syntax "$HOME"/.config/nvim/
nvim --headless "+Lazy! sync" +qa
nvim --headless "+TSInstall! python sql bash json vim lua git_config" +qa

# vim (for macvim)
mkdir -pv "$HOME"/.vim
ln -sfv "$HOME"/dotfiles/vimrc "$HOME"/.vimrc
ln -sfv "$HOME"/dotfiles/vim/colors "$HOME"/.vim/
ln -sfv "$HOME"/dotfiles/vim/ftdetect "$HOME"/.vim/
ln -sfv "$HOME"/dotfiles/vim/ftplugin "$HOME"/.vim/
ln -sfv "$HOME"/dotfiles/vim/syntax "$HOME"/.vim/
vim +PlugInstall +qall

# install oh-my-zsh LAST (spawns new shell, may interrupt script)
# https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/Aloxaf/fzf-tab "$HOME"/.oh-my-zsh/custom/plugins/fzf-tab
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME"/.oh-my-zsh/custom/themes/powerlevel10k

echo ""
echo "Done! Restart your shell (or open a new terminal) to pick up zsh changes."

# echo "" && echo "-- Installing Microsoft ODBC..."
# # https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/install-microsoft-odbc-driver-sql-server-macos
# brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
# brew update
# HOMEBREW_ACCEPT_EULA=Y brew install msodbcsql17
# # brew install mssql-tools # install sqlcmd and bcp
# # brew install sqlcmd # install the go version of sqlcmd
