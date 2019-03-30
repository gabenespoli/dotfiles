#!/bin/bash

# Mac options {{{1
if [ "$(uname)" == "Darwin" ]; then
  # overwrite builtins with gnu ones
  for gnu in coreutils findutils grep gnu-sed gawk; do
    export PATH="/usr/local/opt/$gnu/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/$gnu/libexec/gnuman:$MANPATH"
  done
  if hash gls 2> /dev/null; then
    alias ls="gls --color --group-directories-first"
    alias ll="gls -Flh --color --group-directories-first"
    alias la="gls -Flha --color --group-directories-first"
  else
    alias ll="ls -Flh"
    alias la="ls -Flha"
  fi
  # custom path
  export PATH="$HOME/Library/Haskell/bin:$PATH"
  export PATH="/usr/local/lib:$PATH"
  export PATH="/usr/local/bin:$PATH"
  alias agi="brew install"
  alias agu="brew update && brew upgrade && brew cleanup"
  alias ql='qlmanage -p &>/dev/null'
  alias matlab="/Applications/MATLAB_R2017a.app/bin/matlab -nosplash -nodesktop"
  alias openx="open -a Microsoft\ Excel.app"

# Linux options {{{1
else 
  export PATH="/usr/local/lib:/usr/local/bin:$PATH"
  alias ls="ls --color --group-directories-first"
  alias ll="ls -Flh --color --group-directories-first"
  alias la="ls -Flha --color --group-directories-first"
  alias agi="sudo apt-get -y install"
  alias agu="sudo apt-get update && sudo apt-get upgrade"
  alias sambastart="sudo /etc/init.d/samba start"
  alias d="dropbox"
  alias ds="dropbox status"
  alias matlab="matlab -nosplash -nodesktop"
fi

# Environment {{{1
LS_COLORS=$LS_COLORS:'di=0;34:ln=0;36:ex=0;35:ow=30;42:' ; export LS_COLORS
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"
export EDITOR='nvim'
export CLICOLOR=1
export JQ_COLORS='0;36:0;36:0;36:0;36:0;36:0;31:0;31'

# Prompt {{{1
if [ -e ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
  GIT_PROMPT='$(__git_ps1 "\[\e[31m\]|\[\e[36m\]%s")'
fi
if [ -n "$TMUX" ]; then
  TMUX_PROMPT="$(tmux display-message -p '(#I) ')"
fi
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SSH_PROMPT="^"
fi
PS1="$SSH_PROMPT$TMUX_PROMPT\[\e[34m\]\W$GIT_PROMPT\[\e[0m\] $ "

# Aliases & Functions {{{1
alias lt="tree -L 2 --dirsfirst"
alias grep="grep --color"
alias df="df -h"
alias du="du -hs"
alias wa="tmux attach"
alias wd="tmux detach"
alias fold="fold -s"
alias exe="chmod u+x"
function catcsv() { call="awk -F \",\" '{print $"$2"}' $1"; eval ${call} ; } # usage: catcsv csvFilename columnNumber
alias t="cat ~/todo/todo.txt"
alias todo="$EDITOR $HOME/todo/todo.txt"
alias pip_upgrade="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias pudb="python -m pudb.run"
alias octave="octave --no-gui"
alias lilyjazz="$HOME/.lyp/lilyponds/2.18.2/bin/lilypond --include='$HOME/.lyp/packages/lilyjazz@0.2.0' '$@'"
alias lilypond="$HOME/.lyp/lilyponds/2.18.2/bin/lilypond '$@'"
function ranger() { /usr/local/bin/ranger --choosedir=$HOME/.rangerdir $@; cd "`cat $HOME/.rangerdir`" ; }
alias weather="curl http://wttr.in/Kitchener"
alias keys='keyboard | grep -v "Control\|Semicolon" && keyboard | grep -v "Command\|Semicolon" && keyboard | grep -v "Command\|Control"'

# git {{{1
alias gs="git status -sb"
alias gb="git branch"
alias gg="git checkout"
alias ga="git add"
alias gr="git reset"
alias gd="git diff"
alias gc="git commit"
alias gca="git commit --amend"
alias gss="git stash save"
alias gsp="git stash pop"
alias gsl="git stash list"
alias glog="git log --graph --pretty=format:'%C(blue)%h%Creset%C(yellow)%d%Creset %s %C(cyan)(%cr) %C(green)<%an>%Creset' --abbrev-commit"
alias gl='$EDITOR +GV +"autocmd BufWipeout <buffer> qall"'
alias ts="tig status"
alias tl="tig"

# source other files {{{1
function sourcex() { [ -f "$1" ] && source "$1" ; }
sourcex "$HOME/private/github"
sourcex "$HOME/bin/network_aliases"
sourcex "$HOME/.bash_aliases"

# stuff that should be at the end {{{1
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if command -v pyenv-virtualenv 1>/dev/null 2>&1; then
  eval "$(pyenv virtualenv-init -)"
fi
