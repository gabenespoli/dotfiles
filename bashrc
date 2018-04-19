#!/bin/bash

## OS-specific options {{{1
if [ "$(uname)" == "Darwin" ]; then
  ### Mac options
  export PATH="/usr/local/bin:$PATH"
  export PATH="/usr/local/lib:$PATH"
  export PATH="/usr/local/texbin:$PATH"
  export PATH="$HOME/Library/Haskell/bin:$PATH"
  export PATH="$HOME/bin:$PATH"
  alias ls="ls -hl"
  alias lsa="ls -hla"
  alias gls="gls -hl --color --group-directories-first"
  alias glsa="gls -hla --color --group-directories-first"
  alias lsg="ls -hl | grep"
  alias lsag="ls -hla | grep"
  alias agi="brew install"
  alias agu="brew update && brew upgrade && brew cleanup"
  alias ql='qlmanage -p &>/dev/null'
  alias matlab="rlwrap -c -a dummy_arg /Applications/MATLAB_R2017a.app/bin/matlab -nosplash -nodesktop"
  alias openx="open -a Microsoft\ Excel.app"
  alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
  alias wifi="sudo networksetup -setairportnetwork en0"
  alias t="todo.sh -a"
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
  export LSCOLORS=exgxcxdxfxegedabagacad
  LS_COLORS=$LS_COLORS:'di=0;34:ln=0;36:ex=0;35:ow=30;42:' ; export LS_COLORS
  export PROMPT_COMMAND="echo -ne '\033]0;${HOSTNAME%%.*}\007'" # tab titles

else 
  ### Linux options
  export PATH="$HOME/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/lib:/usr/local/bin:$PATH"
  if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
  fi
  alias ls="ls -hl --color"
  alias lsa="ls -hla --color"
  alias lsg="ls -hl --color | grep"
  alias lsag="ls -hla --color | grep"
  alias agi="sudo apt-get -y install"
  alias agu="sudo apt-get update"
  alias sambastart="sudo /etc/init.d/samba start"
  alias ranger='python $HOME/local/ranger/ranger.py --choosedir=$HOME/.rangerdir; cd "`cat $HOME/.rangerdir`"'
  alias trash="gio trash"
  alias t="todo-txt -a"
  alias matlab="rlwrap -a -c matlab -nosplash -nodesktop"
  #eval `dircolors $HOME/.dir_colors/dircolors`
  LS_COLORS=$LS_COLORS:'di=0;34:ln=0;36:ex=0;35:ow=30;42:' ; export LS_COLORS
  setxkbmap -option ctrl:nocaps
  setxkbmap -option shift:both_capslock
fi

## Environment {{{1
export PATH="$HOME/local/bin:$PATH"
git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/:\1/' ; }
export PS1='\[\e[0;34m\]\w\[\e[0;37m\]$(git_branch) \[\e[0;37m\]\$\[\e[m\] '
export EDITOR='nvim'
export CLICOLOR=1
export MPLCONFIGDIR="$HOME/dotfiles/matplotlib"

# autocomplete
# bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'
bind 'set completion-display-width 0'

# setup ruby env (requires rbenv to be installed)
if hash rbenv 2> /dev/null; then eval "$(rbenv init -)" ; fi

## Aliases & Functions {{{1
alias edit=$EDITOR
alias grep="grep --color"
alias df="df -h"
alias du="du -hs"
alias wa="tmux attach"
alias wd="tmux detach"
alias fold="fold -s"
alias exe="chmod u+x"
alias cls='printf "\033c"'
alias lsl='printf "\033c" && ls'
alias rd='printf "\033c" && remind -cc+3 -w120 "$HOME"/.reminders'
function cdl { cd $1; ls;}
function catcsv() { call="awk -F \",\" '{print $"$2"}' $1"; eval ${call} ; } # usage: catcsv csvFilename columnNumber
function settitle() { printf "\033k$1\033\\" ; }

### git {{{2
alias gs="git status -sb"
alias gb="git branch"
alias gg="git checkout"
alias ga="git add"
alias gr="git reset"
alias gd="git diff"
alias gc="git commit"
alias gca="git commit --amend"
alias gss="git stash push"
alias gsp="git stash pop"
alias gsl="git stash list"
alias glog="git log --graph --decorate --oneline"
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(blue)%h%C(reset) - %C(green)(%ar)%C(reset) %C(bold blue)%s%C(reset) %C(bold green)- %an%C(reset)%C(yellow)%d%C(reset)' --all"
alias ts="tig status"
alias tl="tig"

### others {{{2

# coding languages
alias pylab="ipython --pylab"
alias pip_upgrade="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias mne="source $HOME/local/mne/bin/activate && ipython"
alias octave="octave --no-gui"
alias lilyjazz="$HOME/.lyp/lilyponds/2.18.2/bin/lilypond --include='$HOME/.lyp/packages/lilyjazz@0.2.0' '$@'"
alias lilypond="$HOME/.lyp/lilyponds/2.18.2/bin/lilypond '$@'"

# apps
function ranger() { /usr/local/bin/ranger --choosedir=$HOME/.rangerdir $@; cd "`cat $HOME/.rangerdir`" ; }
alias mail="mutt -F $HOME/dotfiles/muttrc"
alias Mail="offlineimap && mutt -F $HOME/dotfiles/muttrc -e 'push <change-folder>=Archive<enter>'"
alias gmail="mutt -F $HOME/dotfiles/mutt/gmail.muttrc"
alias vimdiff="vimdiff -c 'windo set wrap' -c 'windo set number' -c 'hi _DiffDelPos cterm=underline ctermfg=1 ctermbg=0'"
alias pdoc="$HOME/dotfiles/pandoc/pdoc"
alias cite="python $HOME/bin/python/cite/cite.py"
alias rate="python $HOME/bin/python/rate.py"
alias hangups="hangups \
  --date-format '< %Y-%m-%d >' \
  --disable-notifications \
  --key-close-tab 'ctrl x' \
  --col-tab-background-fg yellow \
  --col-tab-background-bg 'dark gray' \
  --col-active-tab-fg 'light gray' \
  --col-active-tab-bg black \
  --col-inactive-tab-fg yellow \
  --col-inactive-tab-bg black \
  --col-status-line-fg yellow \
  --col-status-line-bg 'dark gray' \
  --col-msg-date-fg 'light green' \
  --col-msg-date-bg black \
  --col-msg-sender-fg 'light magenta' \
  --col-msg-sender-bg default \
  --col-msg-self-fg 'dark blue' \
  --col-msg-self-bg default"

### todo, notes, and calendar {{{2
alias tt="grep -r TODO *"
alias ttt="vim -c 'silent vimgrep TODO *' -c 'CiderVinegarQF'"
alias todo="$EDITOR $HOME/todo/todo.txt"
alias pom="thyme"
alias pomd="thyme -d"
alias poms="thyme -s"
alias pomfile="$EDITOR $HOME/pomodoro/$(date +%Y-%m-%d).txt"
alias trello="$HOME/bin/trello-cli/bin/trello"
alias tsync="python ~/bin/task2todotxt/task2todotxt.py"
alias gcal="$HOME/bin/gcalcli_wrapper.sh"
alias wf="python $HOME/bin/Workflows/Workflows.py $HOME/r/notes/"
function notes() { vim "$(gf $@)/notes.md" ; }
function note() {
  notesDir="$HOME/notes/"
  title="$*"
  filename="$notesDir/$title.md"
  if [ ! -f "$filename" ]; then touch "$filename" && echo "# $title"$'\n' >> "$filename"; fi
  "$EDITOR" "$filename"
}
function caplog() {
  if [ "$#" -eq 0 ]; then
    cat "$HOME/todo/caplog.txt"
  else
    today=`date +%Y-%m-%d\ %H:%M:%S`
    echo "$today > $@" >> "$HOME/todo/caplog.txt"
  fi
}

### custom files {{{2
function openmd() { "$EDITOR" -c "MuttonToggle" "$1" ; }
alias ecpaper="openmd ~/Dropbox/research/archive/2014/ec/paper/NespoliGoySinghRusso2017.md"
alias gvpaper="openmd ~/r/gv/paper/Nespoli2017.md"
alias dis="openmd ~/r/phd/proposal/Nespoli_PhD_Proposal.md"
alias cv="$EDITOR ~/r/archive/2017/OGS/cv/NespoliGA_cv.md"

### source other files {{{2
function sourcex() { [ -f "$1" ] && source "$1" ; }
sourcex "$HOME/private/github"
sourcex "$HOME/bin/network_aliases"
sourcex "$HOME/dotfiles/fzfrc"
sourcex "$HOME/.fzf.bash"
