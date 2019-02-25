#!/bin/bash

# Mac options {{{1
if [ "$(uname)" == "Darwin" ]; then
  # overwrite builtins with gnu ones
  for gnu in coreutils findutils grep gnu-sed gawk; do
    export PATH="/usr/local/opt/$gnu/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/$gnu/libexec/gnuman:$MANPATH"
  done
  # custom path
  export PATH="$HOME/Library/Haskell/bin:$PATH"
  export PATH="/usr/local/texbin:$PATH"
  export PATH="/usr/local/lib:$PATH"
  export PATH="/usr/local/bin:$PATH"
  if hash gls 2> /dev/null; then
    alias ls="gls --color --group-directories-first"
    alias lsl="gls -Flh --color --group-directories-first"
    alias lsa="gls -Flha --color --group-directories-first"
  else
    alias lsl="ls -Flh"
    alias lsa="ls -Flha"
  fi
  alias agi="brew install"
  alias agu="brew update && brew upgrade && brew cleanup"
  alias ql='qlmanage -p &>/dev/null'
  alias matlab="/Applications/MATLAB_R2017a.app/bin/matlab -nosplash -nodesktop"
  alias openx="open -a Microsoft\ Excel.app"
  alias wifi="sudo networksetup -setairportnetwork en0"
  function findershowhidden() {
    case $1 in
      on|true ) command="TRUE" ;;
      off|false ) command="FALSE" ;;
    esac
    defaults write com.apple.finder AppleShowAllFiles "$command"
    killall Finder
  }
 #export LSCOLORS=exfxcxdxbxegedabagacad # macOS default from `man ls`
 #                1 2 3 4 5 6 7 8 9 1011
 #                -_|_-_-_|_-_-_-_-_-_-_ # changes I've made to defaults
  export LSCOLORS=exgxcxdxbxegedabagacad
  LS_COLORS=$LS_COLORS:'di=0;34:ln=0;36:ex=0;35:ow=30;42:' ; export LS_COLORS
  export PROMPT_COMMAND="echo -ne '\033]0;${HOSTNAME%%.*}\007'" # tab titles

# Linux options {{{1
else 
  export PATH="/usr/local/lib:/usr/local/bin:$PATH"
  alias ls="ls --color --group-directories-first"
  alias lsl="ls -Flh --color --group-directories-first"
  alias lsa="ls -Flha --color --group-directories-first"
  alias agi="sudo apt-get -y install"
  alias agu="sudo apt-get update"
  alias sambastart="sudo /etc/init.d/samba start"
  alias d="dropbox"
  alias ds="dropbox status"
  alias matlab="matlab -nosplash -nodesktop"
  LS_COLORS=$LS_COLORS:'di=0;34:ln=0;36:ex=0;35:ow=30;42:' ; export LS_COLORS
fi

# Environment {{{1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"
if [ -e ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
  export PS1='\[\e[34m\]\w\[\e[0m\]$(__git_ps1 ":\[\e[32m\]%s")\[\e[0m\] $ '
else
  export PS1='\[\e[34m\]\w\[\e[0m\] $ '
fi
export EDITOR='nvim'
export CLICOLOR=1

# autocomplete
# bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'
bind 'set completion-display-width 0'

# Aliases & Functions {{{1
alias grep="grep --color"
alias df="df -h"
alias du="du -hs"
alias wa="tmux attach"
alias wd="tmux detach"
alias fold="fold -s"
alias exe="chmod u+x"
function catcsv() { call="awk -F \",\" '{print $"$2"}' $1"; eval ${call} ; } # usage: catcsv csvFilename columnNumber
alias t="cat ~/todo/todo.txt"
alias todo="$EDITOR -O $HOME/todo/todo.txt $HOME/todo/backlog.txt"
alias pip_upgrade="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias octave="octave --no-gui"
alias lilyjazz="$HOME/.lyp/lilyponds/2.18.2/bin/lilypond --include='$HOME/.lyp/packages/lilyjazz@0.2.0' '$@'"
alias lilypond="$HOME/.lyp/lilyponds/2.18.2/bin/lilypond '$@'"
function ranger() { /usr/local/bin/ranger --choosedir=$HOME/.rangerdir $@; cd "`cat $HOME/.rangerdir`" ; }
alias pdoc="$HOME/dotfiles/pandoc/pdoc"
alias cite="python $HOME/bin/python/cite/cite.py"
alias rate="python $HOME/bin/python/rate.py"
alias weather="curl http://wttr.in/Kitchener"

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
alias glog="git log --graph --decorate --oneline"
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(blue)%h%C(reset) - %C(green)(%ar)%C(reset) %C(bold blue)%s%C(reset) %C(bold green)- %an%C(reset)%C(yellow)%d%C(reset)' --all"
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
if hash rbenv 2> /dev/null; then
  eval "$(rbenv init -)" ;
fi
