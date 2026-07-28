sudo apt update

# --- do before cloning this repo ---
# sudo apt install git -y

# --- utils ---

# --- ssh ---
sudo apt install openssh-server -y
# ensure it starts when the computer starts
sudo systemctl enable --now ssh

# --- vnc screen sharing ---
sudo apt install x11vnc -y
x11vnc -storepasswd
# (You can also add this to your Xubuntu "Session and Startup" app so it launches automatically on boot).
x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth ~/.vnc/passwd -rfbport 5900 -shared

# --- google chrome ---
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# --- auto login ---

# --- mount eg drive and create samba server ---

# --- install jellyfin and media server ---
