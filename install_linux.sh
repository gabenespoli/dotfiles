#!/bin/bash
set -e

# =============================================================================
# New Linux (Xubuntu 24.04) Setup Script
# =============================================================================
#
# Prerequisites (do these manually before running this script):
#   1. Install git:
#      sudo apt install git -y
#   2. Clone this repo:
#      git clone https://github.com/gabenespoli/dotfiles.git ~/dotfiles
#   3. Run this script:
#      cd ~/dotfiles && bash install_linux.sh
#
# After running this script:
#   - [ ] Create ~/.gitconfig_local with your name/email:
#         [user]
#           name = Your Name
#           email = your@email.com
#   - [ ] Create ~/.bash_local with machine-specific shell commands
#   - [ ] Setup GitHub auth (SSH key or personal access token)
#   - [ ] Restart your terminal (or log out/in) to pick up zsh as default shell
# =============================================================================

sudo apt update

# --- Core CLI utils ---
sudo apt install -y curl wget htop tree cloc jq
sudo apt install -y fd-find ripgrep fzf
sudo ln -sfv "$(which fdfind)" /usr/local/bin/fd

# eza (needs the gierens PPA on Ubuntu 24.04)
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor --yes -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

sudo apt install -y trash-cli

# lf file manager (from GitHub releases)
LF_VERSION=$(curl -s https://api.github.com/repos/gokcehan/lf/releases/latest | jq -r '.tag_name')
curl -LO "https://github.com/gokcehan/lf/releases/download/${LF_VERSION}/lf-linux-amd64.tar.gz"
tar xzf lf-linux-amd64.tar.gz
sudo mv lf /usr/local/bin/
rm lf-linux-amd64.tar.gz

mkdir -pv "$HOME"/.config
ln -sfv "$HOME"/dotfiles/config/lf "$HOME"/.config
ln -sfv "$HOME"/dotfiles/config/eza "$HOME"/.config
ln -sfv "$HOME"/dotfiles/gitconfig "$HOME"/.gitconfig

# --- Python ---
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
uv tool install pynvim
uv tool install jupytext
uv tool install ruff
uv tool install pyright
mkdir -pv "$HOME"/.ipython/profile_default
ln -sfv "$HOME"/dotfiles/python/ipython_config.py "$HOME"/.ipython/profile_default/ipython_config.py
ln -sfv "$HOME"/dotfiles/config/ruff "$HOME"/.config

# --- Neovim (latest stable from GitHub releases) ---
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar xzf nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo mv nvim-linux-x86_64 /opt/nvim
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
rm nvim-linux-x86_64.tar.gz
mkdir -pv "$HOME"/.config/nvim
ln -sfv "$HOME"/dotfiles/config/nvim/init.lua "$HOME"/.config/nvim/init.lua
ln -sfv "$HOME"/dotfiles/config/nvim/lua "$HOME"/.config/nvim/lua
ln -sfv "$HOME"/dotfiles/vim/colors "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/ftdetect "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/ftplugin "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/syntax "$HOME"/.config/nvim/
/usr/local/bin/nvim --headless "+Lazy! sync" +qa
/usr/local/bin/nvim --headless "+TSInstall! python sql bash json vim lua git_config" +qa

# --- Zsh and Tmux ---
sudo apt install -y zsh tmux
ln -sfv "$HOME"/dotfiles/zshrc "$HOME"/.zshrc
ln -sfv "$HOME"/dotfiles/p10k.zsh "$HOME"/.p10k.zsh
ln -sfv "$HOME"/dotfiles/tmux.conf "$HOME"/.tmux.conf
[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
[ -d "$HOME/.oh-my-zsh" ] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
[ -d "$HOME/.oh-my-zsh/custom/plugins/fzf-tab" ] || git clone https://github.com/Aloxaf/fzf-tab "$HOME"/.oh-my-zsh/custom/plugins/fzf-tab
[ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME"/.oh-my-zsh/custom/themes/powerlevel10k
chsh -s /usr/bin/zsh

# --- Media Server ---

# SSH
sudo apt install -y openssh-server
sudo systemctl enable --now ssh

# VNC screen sharing
sudo apt install -y x11vnc
x11vnc -storepasswd
# Add to Xubuntu "Session and Startup" to launch on boot:
#   x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth ~/.vnc/passwd -rfbport 5900 -shared

# Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# --- auto login ---
# TODO: configure auto-login for Xubuntu

# --- mount eg drive and create samba server ---
# TODO: configure Samba

# --- install jellyfin and media server ---
# TODO: configure Jellyfin

echo ""
echo "Done! Log out and back in (or reboot) for zsh to take effect as your default shell."
