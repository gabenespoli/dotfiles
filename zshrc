# Setup $PATH
if [ -f /etc/profile ]; then

  # Setup PATH from scratch every time
  PATH=""
  MANPATH=""
  source /etc/profile

  eval "$(/opt/homebrew/bin/brew shellenv)"

  if hash gls 2> /dev/null; then
    # Overwrite builtins with homebrew-installed GNU ones
    for gnu in coreutils findutils grep gnu-sed gawk; do
      export PATH="$HOMEBREW_PREFIX/opt/$gnu/libexec/gnubin:$PATH"
      export MANPATH="$HOMEBREW_PREFIX/opt/$gnu/libexec/gnuman:$MANPATH"
    done
  fi

  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
          . "$HOME/miniconda3/etc/profile.d/conda.sh"
      else
          export PATH="$HOME/miniconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<

fi

# main zsh options  {{{1
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="af-magic"
DISABLE_AUTO_TITLE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

plugins=(fzf-tab)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Custom settings and alisases  {{{1
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

bindkey "^N" history-search-forward
bindkey "^P" history-search-backward

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS=$LS_COLORS:'di=0;34:ln=0;36:ex=0;35:ow=30;42:'
export JQ_COLORS='0;36:0;36:0;36:0;36:0;36:0;31:0;31'

if hash gls 2> /dev/null; then
  alias ll="gls -F --color --group-directories-first"
  alias ls="gls -Flh --color --group-directories-first"
  alias la="gls -Flha --color --group-directories-first"
else
  alias ll="ls -F"
  alias ls="ls -Flh"
  alias la="ls -Flha"
fi

alias ta="tmux attach"
alias lt="tree -L 2 --dirsfirst"
alias exe="chmod u+x"
alias fold="fold -s"

alias cl="conda env list"
alias ca="conda deactivate && conda activate"

alias gs="git status --short"
alias ga="git add"
alias gd="git diff"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias czz="git stash save"
alias czp="git stash pop && gs"
alias glog="git log --oneline --date=short --format='%C(6)%cd %C(blue)[%h] %C(8){%an}%C(auto)%d %s'"
alias gl="glog --graph --topo-order -15"
alias gL="glog --graph --topo-order -30 --all"
alias grlog="git reflog --format='%C(6)%cr%C(auto) %h %C(9)%gD %C(auto)%gs %d'"
alias glr="grlog -15"
alias gR="git reset HEAD^ && gs"

alias Gl="$EDITOR +'Flog'"
alias GL="$EDITOR +'Flog -all'"
alias Gs="$EDITOR -c ':Gedit :'"
alias GS=Gs

export FZF_DEFAULT_OPTS='
  --layout reverse
  --color=hl:8,fg+:15,bg+:0,hl+:2,info:5,prompt:2,pointer:2,marker:6,spinner:2,header:7
  --preview "bat --style=numbers --color=always --line-range :500 {}"
  '

# Change working dir in shell to last dir in lf on exit
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# source other files  {{{1
function sourcex() { [ -f "$1" ] && source "$1" ; }
sourcex "$HOME/.bash_local"

