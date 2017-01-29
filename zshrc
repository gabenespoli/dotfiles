# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

## oh my zsh stuff
# ----------------
export ZSH="$HOME/.oh-my-zsh"

# Themes: https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="sumach"
CASE_SENSITIVE="false"

# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd" # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"

plugins=()
source $ZSH/oh-my-zsh.sh
export ZSH_CUSTOM="$HOME/.zsh"
# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# Aliases are kept in ~/.oh-my-zsh/custom/aliases.zsh


# add editing mode to prompt
# https://dougblack.io/words/zsh-vi-mode.html
bindkey -e
#bindkey '^P' up-history
#bindkey '^N' down-history
#bindkey '^?' backward-delete-char
#bindkey '^h' backward-delete-char
#bindkey '^w' backward-kill-word
#bindkey '^r' history-incremental-search-backward
function zle-line-init zle-keymap-select {
    VIM_PROMPT_INS="%{$fg_bold[yellow]%} [% +]%  %{$reset_color%}"
    VIM_PROMPT_CMD="%{$fg_bold[green]%} [% :]%  %{$reset_color%}"
    EMACS_PROMPT="%{$fg_bold[magenta]%} [% @]%  %{$reset_color%}"
    #RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    RPS1="${${${KEYMAP/vicmd/$VIM_PROMPT_CMD}/(viins)/$VIM_PROMPT_INS}/(main)/$EMACS_PROMPT} $EPS1"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1


source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
