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
sudo apt install -y zsh tmux
ln -sfv "$HOME"/dotfiles/p10k.zsh "$HOME"/.p10k.zsh
ln -sfv "$HOME"/dotfiles/tmux.conf "$HOME"/.tmux.conf
[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
[ -d "$HOME/.oh-my-zsh" ] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
[ -d "$HOME/.oh-my-zsh/custom/plugins/fzf-tab" ] || git clone https://github.com/Aloxaf/fzf-tab "$HOME"/.oh-my-zsh/custom/plugins/fzf-tab
[ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME"/.oh-my-zsh/custom/themes/powerlevel10k
ln -sfv "$HOME"/dotfiles/zshrc "$HOME"/.zshrc
chsh -s /usr/bin/zsh

# --- Ghostty terminal ---
sudo add-apt-repository -y ppa:mkasberg/ghostty-ubuntu
sudo apt update
sudo apt install -y ghostty
mkdir -pv "$HOME"/.config/ghostty
ln -sfv "$HOME"/dotfiles/ghostty "$HOME"/.config/ghostty/config

# --- Media Server ---

# SSH
sudo apt install -y openssh-server
sudo systemctl enable --now ssh

# VNC screen sharing
sudo apt install -y x11vnc
mkdir -pv "$HOME"/.local/bin
tee "$HOME"/.local/bin/x11vnc_autostart.sh <<'SCRIPT'
#!/bin/bash
sleep 3
AUTH_FILE=$(find /run /var/run -name "xauth" -type f 2>/dev/null | head -1)
if [ -n "$AUTH_FILE" ]; then
  exec /usr/bin/x11vnc -auth "$AUTH_FILE" -forever -loop -noxdamage -repeat -rfbauth "$HOME/.vnc/passwd" -rfbport 5900 -shared -display :0
else
  exec /usr/bin/x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth "$HOME/.vnc/passwd" -rfbport 5900 -shared -display :0
fi
SCRIPT
chmod +x "$HOME"/.local/bin/x11vnc_autostart.sh
mkdir -pv "$HOME"/.config/autostart
tee "$HOME"/.config/autostart/x11vnc.desktop <<EOF
[Desktop Entry]
Type=Application
Name=x11vnc
Exec=$HOME/.local/bin/x11vnc_autostart.sh
StartupNotify=false
EOF
# Manual: set VNC password (interactive)
#   x11vnc -storepasswd

# Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# --- auto login ---
sudo mkdir -pv /etc/lightdm/lightdm.conf.d
sudo tee /etc/lightdm/lightdm.conf.d/50-autologin.conf <<EOF
[Seat:*]
autologin-user=$USER
autologin-user-timeout=0
EOF

# --- mount eg drive ---
sudo mkdir -pv /mnt/eg
if ! grep -q "/mnt/eg" /etc/fstab 2>/dev/null; then
  echo "UUID=f9d65897-d5ba-4838-a937-b5a26291f970  /mnt/eg  ext4  defaults,nofail  0  2" | sudo tee -a /etc/fstab
fi
sudo mount -a
ln -sfv /mnt/eg "$HOME"/eg

# --- samba share ---
sudo apt install -y samba
if ! grep -q "\[eg\]" /etc/samba/smb.conf 2>/dev/null; then
  sudo tee -a /etc/samba/smb.conf <<EOF

[eg]
   path = /mnt/eg
   browseable = yes
   read only = no
   guest ok = no
   valid users = $USER
   force user = $USER
EOF
fi
# Manual: set samba password (interactive)
#   sudo smbpasswd -a $USER
sudo systemctl enable --now smbd
# Manual: if using ufw, allow samba
#   sudo ufw allow samba

# # --- backup eg drive to sdc via rsync ---
# # TODO:
# #   1. Partition sdc: sudo gdisk /dev/sdc (single ext4 partition, type 8300)
# #   2. Format: sudo mkfs.ext4 /dev/sdc1
# #   3. Find by-id: ls -l /dev/disk/by-id/ | grep sdc | grep -v "part"
# #   4. Add to fstab:
# #        /dev/disk/by-id/ata-<sdc_serial>  /mnt/eg-backup  ext4  defaults,nofail  0  2
# #   5. sudo mkdir -pv /mnt/eg-backup && sudo mount -a
# #   6. Initial sync: sudo rsync -a --delete /mnt/eg/ /mnt/eg-backup/
# #   7. Uncomment the crontab line below to schedule hourly backups:
# #
# # CRON_JOB="0 * * * * rsync -a --delete /mnt/eg/ /mnt/eg-backup/"
# # (crontab -l 2>/dev/null | grep -v "eg-backup"; echo "$CRON_JOB") | crontab -

# --- jellyfin media server ---
curl -s https://repo.jellyfin.org/install-debuntu.sh | sudo bash
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
