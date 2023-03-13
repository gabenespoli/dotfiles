#!/bin/bash

# Mac options {{{1
if [[ $(uname) == "Darwin" ]]; then
  # overwrite builtins with gnu ones
  for gnu in coreutils findutils grep gnu-sed gawk; do
    export PATH="/usr/local/opt/$gnu/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/$gnu/libexec/gnuman:$MANPATH"
  done
  if hash gls 2> /dev/null; then
    alias ll="gls -F --color --group-directories-first"
    alias ls="gls -Flh --color --group-directories-first"
    alias la="gls -Flha --color --group-directories-first"
  else
    alias ll="ls -F"
    alias ls="ls -Flh"
    alias la="ls -Flha"
  fi

# Linux options {{{1
else
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  alias ll="ls -F --color --group-directories-first"
  alias ls="ls -Flh --color --group-directories-first"
  alias la="ls -Flha --color --group-directories-first"
  alias sambastart="sudo /etc/init.d/samba start"
  alias d="dropbox"
  alias ds="dropbox status"
fi

# Environment {{{1
export PATH="$HOME/dotfiles/bin:$HOME/local/bin:$HOME/bin:$HOME/go/bin:/usr/local/bin:/usr/local/lib:$PATH"
export EDITOR='nvim'
export CLICOLOR=1
export LS_COLORS=$LS_COLORS:'di=0;34:ln=0;36:ex=0;35:ow=30;42:'
export JQ_COLORS='0;36:0;36:0;36:0;36:0;36:0;31:0;31'
export HOMEBREW_NO_AUTO_UPDATE=1
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# python / spark
export PYSPARK_DRIVER_PYTHON=ipython
# export MPLBACKEND="module://itermplot"
# export ITERMPLOT=rv

# unbind werase (C-w) so we can bind it with readline (inputrc)
stty werase undef
bind '"\C-w": backward-kill-word'

# Aliases & Functions {{{1
alias lt="tree -L 2 --dirsfirst"
alias grep="grep --color"
alias df="df -h"
alias du="du -hs"
alias ta="tmux attach"
alias fold="fold -s"
alias exe="chmod u+x"
alias octave="octave --no-gui"
alias weather="curl http://wttr.in/Kitchener"

# Change working dir in shell to last dir in lf on exit (adapted from ranger).
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

# python {{{1
alias cl="conda env list"
alias ca="conda deactivate && conda activate"
alias pudb="python -m pudb.run"
alias jn="jupyter notebook"
alias jl="jupyter lab"

# git {{{1
alias gst="git status -sb"
alias gs="git st"
alias gb="git branch"
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
alias rim="git rebase --interactive --autosquash master"
alias gR="git reset HEAD^ && gs"

alias Gl="$EDITOR +'Flog'"
alias GL="$EDITOR +'Flog -all'"
alias Gs="$EDITOR -c ':Gedit :'"

# fzf {{{1
export FZF_DEFAULT_OPTS='
  --layout reverse
  --color=hl:8,fg+:15,bg+:0,hl+:2,info:5,prompt:2,pointer:2,marker:6,spinner:2,header:7
  --preview "bat --style=numbers --color=always --line-range :500 {}"
  '

# source other files {{{1
function sourcex() { [ -f "$1" ] && source "$1" ; }
sourcex "$HOME/private/github"
sourcex "$HOME/bin/network_aliases"
sourcex "$HOME/dotfiles/bash_functions"
sourcex "$HOME/.bash_aliases"
sourcex "$HOME/.bash_local"
sourcex "$HOME/.git-completion.bash"

# Prompt {{{1
if [ "$TERM_PROGRAM" == "WarpTerminal" ]; then
  continue
elif [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
  source $HOME/.bash-git-prompt/gitprompt.sh
else
  # https://ss64.com/bash/syntax-prompt.html
  PS1="\[\e[34m\]\w\[\e[0m\] $ "
fi

# End {{{1
echo "Sourced bashrc."
