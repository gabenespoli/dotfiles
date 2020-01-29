#!/bin/bash

# Mac options {{{1
if [ "$(uname)" == "Darwin" ]; then
  # overwrite builtins with gnu ones
  for gnu in coreutils findutils grep gnu-sed gawk; do
    export PATH="/usr/local/opt/$gnu/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/$gnu/libexec/gnuman:$MANPATH"
  done
  if hash gls 2> /dev/null; then
    alias ls="gls -Flh --color --group-directories-first"
    alias lS="gls --color --group-directories-first"
    alias ll="gls -Flh --color --group-directories-first"
    alias la="gls -Flha --color --group-directories-first"
  else
    alias ls="ls -Flh"
    alias lS="ls"
    alias ll="ls -Flh"
    alias la="ls -Flha"
  fi
  alias lsa="la"
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
  alias ls="ls -Flh --color --group-directories-first"
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
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"
export EDITOR='nvim'
export CLICOLOR=1
export JQ_COLORS='0;36:0;36:0;36:0;36:0;36:0;31:0;31'
export TERM=xterm-256color-italic

# python / spark
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_VERSION=miniconda3-latest
export PYSPARK_DRIVER_PYTHON=ipython
export SPARK_HOME="$HOME/.pyenv/versions/miniconda3-latest/envs/spark/lib/python3.5/site-packages/pyspark"

# unbind werase (C-w) so we can bind it with readline (inputrc)
stty werase undef
bind '"\C-w": backward-kill-word'

# Prompt {{{1
if [ -e ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
  GIT_PROMPT='$(__git_ps1 "\[\e[31m\]|\[\e[36m\]%s")'
fi
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SSH_PROMPT="^ "
fi
PS1="$SSH_PROMPT\[\e[34m\]\W$GIT_PROMPT\[\e[0m\] $ "

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
alias t="todo.sh"
alias T="$EDITOR $HOME/todo/todo.txt"
alias motes="cd $HOME/notes && mvim $HOME/notes/$(date +%Y-%m-%d).txt"
alias octave="octave --no-gui"
alias lilyjazz="$HOME/.lyp/lilyponds/2.18.2/bin/lilypond --include='$HOME/.lyp/packages/lilyjazz@0.2.0' '$@'"
alias lilypond="$HOME/.lyp/lilyponds/2.18.2/bin/lilypond '$@'"
function ranger() { /usr/local/bin/ranger --choosedir=$HOME/.rangerdir $@; cd "`cat $HOME/.rangerdir`" ; }
alias weather="curl http://wttr.in/Kitchener"
alias keys='keyboard | grep -v "Control\|Semicolon" && keyboard | grep -v "Command\|Semicolon" && keyboard | grep -v "Command\|Control"'

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
alias ca="conda deactivate && conda activate"
alias cx="conda deactivate"
alias pip_upgrade="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias pudb="python -m pudb.run"
alias jn="jupyter notebook"
alias jl="jupyter lab"
alias pylab="ipython --pylab -i -c '\
  import pandas as pd; \
  pd.options.display.width=0; \
  pd.options.display.max_rows=15; \
  pd.options.display.max_columns=9 \
  '"

# git {{{1
alias gst="git status -sb"
alias gs="git st"
alias gb="git branch"
alias gg="git checkout"
alias ggb="git checkout -b"
alias ga="git add"
alias gd="git diff"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias czz="git stash save"
alias czp="git stash pop && gs"
alias czl="git stash list"
alias glog="git log --oneline --pretty=format:'%C(cyan)%h%Creset %s%C(auto)%d%Creset'"
alias gl="glog --graph --topo-order -15"
alias gla="gl --all -30"
alias rb="git rebase"
alias ri="git rebase --interactive"
alias rr="git rebase --continue"
alias ra="git rebase --abort"
alias rim="git rebase --interactive master"
alias gr="git reset"
alias grr="git reset HEAD^ && gs"
alias gwip="git add -A && git commit -m 'WIP'"

alias Gl='$EDITOR +"GV --format=%h\ %s%d" +"autocmd BufWipeout <buffer> qall"'
alias GL='$EDITOR +"GV --format=%h\ %s%d --all" +"autocmd BufWipeout <buffer> qall"'
alias Gs="$EDITOR -c 'call MyGstatus()' ."

alias ts="tig status"
alias tl="tig"

# source other files {{{1
function sourcex() { [ -f "$1" ] && source "$1" ; }
sourcex "$HOME/private/github"
sourcex "$HOME/bin/network_aliases"
sourcex "$HOME/.bash_aliases"
sourcex "$HOME/.bash_local"
sourcex "$HOME/.git-completion.bash"

# https://github.com/gabenespoli/bash-git-prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
  export GIT_PROMPT_THEME=Custom
  source "$HOME/.bash-git-prompt/gitprompt.sh"
fi

# stuff that should be at the end {{{1
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if command -v pyenv-virtualenv 1>/dev/null 2>&1; then
  eval "$(pyenv virtualenv-init -)"
fi
