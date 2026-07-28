#!/bin/bash
set -e
export NONINTERACTIVE=1

# =============================================================================
# New Linux (Xubuntu 24.04) Setup Script
# =============================================================================
#
# Prerequisites (do these manually before running this script):
#   1. Install git and curl:
#      sudo apt install -y git curl
#   2. Install Homebrew (https://brew.sh):
#      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
#   3. Clone this repo:
#      git clone https://github.com/gabenespoli/dotfiles.git ~/dotfiles
#   4. Run this script:
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

# --- System packages (apt) ---
sudo apt update
sudo apt install -y build-essential zsh trash-cli

# --- Core CLI utils (brew) ---
brew install fd ripgrep fzf
brew install htop lf eza tree cloc jq wget
mkdir -pv "$HOME"/.config
ln -sfv "$HOME"/dotfiles/config/lf "$HOME"/.config
ln -sfv "$HOME"/dotfiles/config/eza "$HOME"/.config
ln -sfv "$HOME"/dotfiles/gitconfig "$HOME"/.gitconfig

# --- Python ---
brew install uv ruff pyright
uv tool install pynvim
uv tool install jupytext
mkdir -pv "$HOME"/.ipython/profile_default
ln -sfv "$HOME"/dotfiles/python/ipython_config.py "$HOME"/.ipython/profile_default/ipython_config.py
ln -sfv "$HOME"/dotfiles/config/ruff "$HOME"/.config

# --- Neovim ---
brew install neovim tree-sitter-cli
mkdir -pv "$HOME"/.config/nvim
ln -sfv "$HOME"/dotfiles/config/nvim/init.lua "$HOME"/.config/nvim/init.lua
ln -sfv "$HOME"/dotfiles/config/nvim/lua "$HOME"/.config/nvim/lua
ln -sfv "$HOME"/dotfiles/vim/colors "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/ftdetect "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/ftplugin "$HOME"/.config/nvim/
ln -sfv "$HOME"/dotfiles/vim/syntax "$HOME"/.config/nvim/
nvim --headless "+Lazy! sync" +qa
nvim --headless "+TSInstall! python sql bash json vim lua git_config" +qa

# --- Zsh and Tmux ---
brew install tmux
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

# # Remove apt-installed CLI tools
# sudo apt remove -y fd-find ripgrep fzf eza htop tree cloc

# # Remove the eza PPA
# sudo rm -f /etc/apt/sources.list.d/gierens.list
# sudo rm -f /etc/apt/keyrings/gierens.gpg

# # Remove the fd symlink
# sudo rm -f /usr/local/bin/fd

# # Remove trash-cli (keep this one — it stays as apt)
# # sudo apt remove -y trash-cli  # <-- DON'T run this, you still want it via apt

# # Remove manually installed neovim
# sudo rm -rf /opt/nvim
# sudo rm -f /usr/local/bin/nvim

# # Remove manually installed tree-sitter
# sudo rm -f /usr/local/bin/tree-sitter

# # Remove manually installed lf
# sudo rm -f /usr/local/bin/lf

# # Remove uv (installed via curl)
# rm -rf "$HOME/.local/bin/uv" "$HOME/.local/bin/uvx"
# # uv tool uninstall pynvim jupytext ruff pyright  # run this first if uv is still in PATH

# # Clean up apt
# sudo apt autoremove -y
