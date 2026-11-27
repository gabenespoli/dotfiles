#!/bin/bash
set -e

# =============================================================================
# VS Code + Databricks setup (also run from install_mac.sh)
# =============================================================================
#
# Before running, create ~/.databricks_workspaces (kept out of this repo),
# one workspace per line:
#     dev   https://adb-1111111111111111.11.azuredatabricks.net
#     prod  https://adb-2222222222222222.22.azuredatabricks.net
#
# After running:
#   - [ ] az login   (if this script couldn't do it)
#   - [ ] In each repo:  dbx-init <profile> [cluster-id]
# =============================================================================

DOTFILES="$HOME/dotfiles"
VSCODE_USER="$HOME/Library/Application Support/Code/User"
WORKSPACES="$HOME/.databricks_workspaces"
DATABRICKSCFG="$HOME/.databrickscfg"

# --- Install tools ---
brew install --cask visual-studio-code
brew install databricks/tap/databricks azure-cli jq uv node

CODE="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"

# --- Config (overwrites existing settings) ---
mkdir -pv "$VSCODE_USER"
ln -sfv "$DOTFILES"/config/vscode/settings.json "$VSCODE_USER"/settings.json
ln -sfv "$DOTFILES"/config/vscode/keybindings.json "$VSCODE_USER"/keybindings.json

# --- Snooker theme ---
ruby "$DOTFILES"/misc/generate_vscode_theme.rb
VSIX="${TMPDIR:-/tmp}/snooker-theme.vsix"
(cd "$DOTFILES"/config/vscode/snooker-theme &&
  npx --yes @vscode/vsce package --allow-missing-repository --skip-license -o "$VSIX")
"$CODE" --install-extension "$VSIX" --force 2>&1 | { grep -vE 'DEP0169|trace-deprecation' || true; }

# --- Extensions ---
grep -v '^\s*\(#\|$\)' "$DOTFILES"/config/vscode/extensions.txt | while read -r ext; do
  "$CODE" --install-extension "$ext" --force 2>&1 | { grep -vE 'DEP0169|trace-deprecation' || true; }
done

# --- Databricks auth (Azure CLI, one profile per workspace) ---
if ! az account show &>/dev/null; then
  az login
fi

if [ -f "$WORKSPACES" ]; then
  touch "$DATABRICKSCFG"
  chmod 600 "$DATABRICKSCFG"
  grep -v '^\s*\(#\|$\)' "$WORKSPACES" | while read -r profile host; do
    if grep -q "^\[$profile\]" "$DATABRICKSCFG"; then
      echo "databricks profile [$profile] already exists, skipping"
    else
      printf '\n[%s]\nhost      = %s\nauth_type = azure-cli\n' "$profile" "$host" >> "$DATABRICKSCFG"
      echo "added databricks profile [$profile]"
    fi
  done
  databricks auth profiles
else
  echo "WARNING: $WORKSPACES not found; skipping databricks profiles."
fi

echo ""
echo "VS Code done. In each repo run: dbx-init <profile> [cluster-id]"
