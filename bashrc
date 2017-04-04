#!/bin/bash

# https://github.com/gabenespoli/dotfiles/bashrc

## System-specific options

if [ "$(uname)" == "Darwin" ]; then # Mac options
    alias ls="ls -hl"
    alias la="ls -hla"
    alias lsa="ls -hla"
   #export LSCOLORS=exfxcxdxbxegedabagacad # macOS default from `man ls`
   #                1 2 3 4 5 6 7 8 9 1011
   #                -_|_-_-_|_-_-_-_-_-_-_ # changes I've made
    export LSCOLORS=exgxcxdxfxegedabagacad
    export PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}\007"' # tab titles
    
else # Linux options
    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi
    alias ls="ls -hl --color"
    alias la="ls -hla --color"
    alias lsa="ls -hla --color"
    alias agi="sudo apt-get -y install"
    alias agu="sudo apt-get update"
    eval `dircolors $HOME/.dir_colors/dircolors`
    LS_COLORS=$LS_COLORS:'di=0;34:ln=0;36:ex=0;35:ow=30;42:' ; export LS_COLORS
    setxkbmap -option ctrl:nocaps
    setxkbmap -option shift:both_capslock
    setxkbmap -option altwin:swap_alt_win
fi

## Environment vars
# ----------------
export PATH="$HOME/bin:/usr/local/texbin:/usr/local/lib:/usr/local/bin:$PATH"
export EDITOR='vim' # set default text editor
export GOOGLER_COLORS=Lecgxy
export CLICOLOR=1 # colors for ls
export PS1='\[\e[0;34m\] \w \[\e[0;37m\]\$\[\e[m\] '
#PS1='\[\e[0;34m\]\h:\W \$\[\e[m\] '
export VIMPAGER_RC="$HOME/.vimrc"
#export LESS_TERMCAP_so=$'\e[30;43m'

## Aliases & Functions
alias grep="grep --color"
alias df="df -h"
alias du="du -hs"
alias mc="mc -b"
alias ql='qlmanage -p &>/dev/null'
alias ta="tmux a"
alias fold="fold -s"
alias exe="chmod u+x"
alias cls='printf "\033c"'
alias lsl='printf "\033c" && ls'
alias gf="python $HOME/bin/utils/gf.py"
function cdl { cd $1; ls;}
function cdd() { cd "$(gf "$@")" ; }
function lss() { ls "$(gf "$@")" ; }

# git
alias gs='git status'
alias gc='git commit'
alias gd='git diff'
alias gitlog="git log --graph --decorate --oneline"

# notes
function notes() { vim "$(gf $@)/notes.md" ; }
alias wf="python ~/bin/Workflows/Workflows.py ~/r/notes/"

# calendar and todo
alias t="task"
alias tt='printf "\033c" && task calendar && task t'
alias ttmt='printf "\033c" && task calendar && task t project:mt'
alias ttgv='printf "\033c" && task calendar && task t project:gv'
alias ttem='printf "\033c" && task calendar && task t project:em'
alias tta='printf "\033c" && task calendar && task t project:admin'
alias tsync='python $HOME/bin/task2todotxt/task2todotxt.py'
alias todo="todo.sh -a"
alias gcal="gcalcli --includeRc"
alias cme='printf "\033c" && gcalcli agenda --calendar Gabe --calendar EGcal --calendar Research --calendar https://trello.com/calendar/556dc4e1306181318b7faca9/58c0446572e43a9ffe490439/567e8f2d9cb740e5cf2db6fec6b17947.ics'
alias cfam='printf "\033c" && gcalcli agenda --calendar Gabe --calendar erin.nespoli@gmail.com --calendar Olly --calendar yespleasefolk@gmail.com --calendar EGcal --calendar EGtravel'
alias cwork='printf "\033c" && gcalcli agenda --calendar Research --calendar https://trello.com/calendar/556dc4e1306181318b7faca9/58c0446572e43a9ffe490439/567e8f2d9cb740e5cf2db6fec6b17947.ics'
alias clab='printf "\033c" && gcalcli agenda --calendar SINGS --calendar AUDIOMETER\ booking'

# others
alias pdoc="$HOME/dotfiles/pandoc/pdoc"
alias vimdiff="vimdiff -c 'windo set wrap' -c 'windo set number' -c 'hi _DiffDelPos cterm=underline ctermfg=1 ctermbg=0'"
alias gmail="mutt -F ~/dotfiles/muttrc_gmail"
alias cite="python $HOME/bin/cite/cite.py"
alias matlab="/Applications/MATLAB_R2016a.app/bin/matlab -nosplash -nodesktop"
alias rate='python $HOME/bin/utils/rate.py'
alias openx="open -a Microsoft\ Excel.app"
alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
function vman() { vim -c "SuperMan $*"; if [ "$?" != "0" ]; then echo "No manual entry for $*"; fi }
function vimsyntax() { vim "/usr/local/Cellar/vim/8.0.0130/share/vim/vim80/syntax/$1.vim" ; }
alias vimsyntax_pandoc="vim ~/.vim/bundle/vim-pandoc-syntax/syntax/pandoc.vim"
alias lilyjazz='$HOME/.lyp/lilyponds/2.18.2/bin/lilypond --include="$HOME/.lyp/packages/lilyjazz@0.2.0" "$@"'
alias lilypond='$HOME/.lyp/lilyponds/2.18.2/bin/lilypond "$@"'
alias hangups="hangups \
    --date-format '< %Y-%m-%d >' \
    --disable-notifications \
    --key-close-tab 'ctrl x' \
    --col-tab-background-fg yellow \
    --col-tab-background-bg 'dark gray' \
    --col-active-tab-fg white \
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

# network
alias wifi="sudo networksetup -setairportnetwork en0"
alias smart="ssh gmac@smartmacpro.arts.ryerson.ca"
alias efgh="ssh efgh@192.168.1.12"
alias hrcommons="open vnc://141.117.114.20"

# misc shortcuts
alias paper="vim -c 'call CenWinEnable(100)' ~/r/gv/paper/Nespoli2017.md"
alias dis="vim -c 'call CenWinEnable(100)' -c 'call CenWinTodoEnable()' ~/r/phd/NespoliPhDProposal.md"

