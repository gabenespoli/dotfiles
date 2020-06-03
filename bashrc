#!/bin/bash

# Mac options {{{1
if [[ $(uname) == "Darwin" ]]; then
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

# Linux options {{{1
else
  alias ls="ls -F --color --group-directories-first"
  alias ll="ls -Flh --color --group-directories-first"
  alias la="ls -Flha --color --group-directories-first"
  alias sambastart="sudo /etc/init.d/samba start"
  alias d="dropbox"
  alias ds="dropbox status"
fi

# Environment {{{1
export TERM=xterm-256color-italic
export PATH="$HOME/local/bin:$HOME/bin:/usr/local/bin:/usr/local/lib:$PATH"
export EDITOR='nvim'
export CLICOLOR=1
export LS_COLORS=$LS_COLORS:'di=0;34:ln=0;36:ex=0;35:ow=30;42:'
export JQ_COLORS='0;36:0;36:0;36:0;36:0;36:0;31:0;31'
export HOMEBREW_NO_AUTO_UPDATE=1

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
alias td="tmux detach"
alias wa="echo Use ta instead."
alias wd="echo Use td instead."
alias fold="fold -s"
alias exe="chmod u+x"
alias t="todo.sh"
alias T="$EDITOR $HOME/todo/todo.txt"
alias octave="octave --no-gui"
alias lilyjazz="$HOME/.lyp/lilyponds/2.18.2/bin/lilypond --include='$HOME/.lyp/packages/lilyjazz@0.2.0' '$@'"
alias lilypond="$HOME/.lyp/lilyponds/2.18.2/bin/lilypond '$@'"
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
alias ca="conda deactivate && conda activate"
alias cx="conda deactivate"
alias pudb="python -m pudb.run"
alias jn="jupyter notebook"
alias jl="jupyter lab"

# git {{{1
alias gst="git status -sb"
alias gs="git st"
alias gb="git branch"
alias gg="git checkout"
alias ggb="git checkout -b"
alias ga="git add"
alias gaa="git add -A"
alias gd="git diff"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias czz="git stash save"
alias czp="git stash pop && gs"
alias czl="git stash list"
alias glog="git log --oneline --date=short --format='%C(6)%cd%C(auto) %h%d %s %C(8)(%an)'"
alias gl="glog --graph --topo-order -15"
alias gL="glog --graph --topo-order -30 --all"
alias grlog="git reflog --format='%C(6)%cr%C(auto) %h %C(9)%gD %C(auto)%gs %d'"
alias glr="grlog -15"
alias rb="git rebase"
alias ri="git rebase --interactive"
alias rr="git rebase --continue"
alias ra="git rebase --abort"
alias rim="git rebase --interactive --autosquash master"
alias gr="git reset"
alias grr="echo 'Use gR instead.'"
alias gR="git reset HEAD^ && gs"
alias gwip="git add -A && git commit -m 'WIP'"

alias Gl="$EDITOR +'GV'"
alias GL="$EDITOR +'GV --all'"
alias Gs="$EDITOR -c ':Gedit :'"

# fzf {{{1
export FZF_DEFAULT_OPTS='--height 40% --bind=ctrl-o:select-all
  --color=hl:8,fg+:15,bg+:0,hl+:2
  --color=info:5,prompt:2,pointer:2,marker:6,spinner:2,header:7
  '

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() (
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
)

# source other files {{{1
function sourcex() { [ -f "$1" ] && source "$1" ; }
sourcex "$HOME/private/github"
sourcex "$HOME/bin/network_aliases"
sourcex "$HOME/.bash_aliases"
sourcex "$HOME/.bash_local"
sourcex "$HOME/.git-completion.bash"

# Prompt {{{1
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
  source $HOME/.bash-git-prompt/gitprompt.sh
else
  # https://ss64.com/bash/syntax-prompt.html
  PS1="\[\e[34m\]\w\[\e[0m\] $ "
fi

# End {{{1
echo "Sourced bashrc."
