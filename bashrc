#!/bin/bash

## OS-specific options
if [ "$(uname)" == "Darwin" ]; then # Mac options
    alias ls="ls -hl"
    alias la="ls -hla"
    alias lsa="ls -hla"
    alias agi="brew install"
    alias agu="brew update && brew upgrade && brew cleanup"
    alias ql='qlmanage -p &>/dev/null'
    alias matlab="/Applications/MATLAB_R2016a.app/bin/matlab -nosplash -nodesktop"
    alias openx="open -a Microsoft\ Excel.app"
    alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
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
    export LSCOLORS=exgxcxdxfxegedabagacad
    export PROMPT_COMMAND="echo -ne '\033]0;${HOSTNAME%%.*}\007'" # tab titles
    
else # Linux options
    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi
    alias ls="ls -hl --color"
    alias la="ls -hla --color"
    alias lsa="ls -hla --color"
    alias agi="sudo apt-get -y install"
    alias agu="sudo apt-get update"
    alias sambastart="sudo /etc/init.d/samba start"
    alias matlab="/usr/local/MATLAB/R2016a/bin/matlab -nosplash -nodesktop"
    #eval `dircolors $HOME/.dir_colors/dircolors`
    LS_COLORS=$LS_COLORS:'di=0;34:ln=0;36:ex=0;35:ow=30;42:' ; export LS_COLORS
    setxkbmap -option ctrl:nocaps
    setxkbmap -option shift:both_capslock
    #setxkbmap -option altwin:swap_alt_win
fi

## Environment vars
export PATH="$HOME/bin:/usr/local/texbin:/usr/local/lib:/usr/local/bin:$PATH"
export EDITOR='vim'
export CLICOLOR=1
export PS1='\[\e[0;34m\] \w \[\e[0;37m\]\$\[\e[m\] '

# setup ruby env (requires rbenv to be installed)
eval "$(rbenv init -)"

## Aliases & Functions
alias grep="grep --color"
alias df="df -h"
alias du="du -hs"
alias mc="mc -b"
alias wa="tmux attach"
alias wd="tmux detach"
alias fold="fold -s"
alias exe="chmod u+x"
alias cls='printf "\033c"'
alias lsl='printf "\033c" && ls'
alias gf="python $HOME/bin/utils/gf.py"
alias vim="vim -p" # open multiple files in tabs
function cdl { cd $1; ls;}
function cdd() { cd "$(gf "$@")" ; }
function lss() { ls "$(gf "$@")" ; }
function catcsv() { call="awk -F \",\" '{print $"$2"}' $1"; eval ${call} ; } # usage: catcsv csvFilename columnNumber

# git
alias gs="printf '\033c' && git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
function Gc() {
    printf "\033c"
    git diff $@
    tmux split-window -h -c "#{pane_current_path}" "git commit $@"
    
}

alias gr="git reset"
alias Glog="git log --graph --decorate --oneline"

# todo, notes, and calendar
alias t="task"
alias ta="task add"
alias tsync="python $HOME/bin/task2todotxt/task2todotxt.py"
function tt() {
    tsync
    printf "\033c"
    echo " task" $@
    task calendar
    task t $@
}
alias todo="todo.sh -a"
alias gcal="gcalcli --includeRc"
alias wf="python $HOME/bin/Workflows/Workflows.py $HOME/r/notes/"
function notes() { vim "$(gf $@)/notes.md" ; }
function note() {
    notesDir="$HOME/notes/"
    title="$*"
    filename="$notesDir/$title.md"
    if [ ! -f "$filename" ]; then touch "$filename" && echo "# $title"$'\n' >> "$filename"; fi
    vim "$filename" "+normal G"
}

# others
alias pdoc="$HOME/dotfiles/pandoc/pdoc"
alias vimdiff="vimdiff -c 'windo set wrap' -c 'windo set number' -c 'hi _DiffDelPos cterm=underline ctermfg=1 ctermbg=0'"
alias mail="mutt -F $HOME/dotfiles/muttrc"
alias gmail="mutt -F $HOME/dotfiles/mutt/gmail.muttrc"
alias cite="python $HOME/bin/cite/cite.py"
alias octave="octave --no-gui"
alias rate="python $HOME/bin/utils/rate.py"
alias lilyjazz="$HOME/.lyp/lilyponds/2.18.2/bin/lilypond --include='$HOME/.lyp/packages/lilyjazz@0.2.0' '$@'"
alias lilypond="$HOME/.lyp/lilyponds/2.18.2/bin/lilypond '$@'"
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
alias paper="vim ~/r/gv/paper/Nespoli2017.md"
alias dis="vim ~/r/phd/proposal/Nespoli_PhD_Proposal.md"
alias cv="vim ~/r/archive/2017/OGS/cv/NespoliGA_cv.md"

## network
alias smart="ssh gmac@smartmacpro.arts.ryerson.ca"
alias smarts="open vnc://smartmacpro.arts.ryerson.ca"
alias efgh="ssh efgh@192.168.1.12"
function ltm() { mount -t smbfs //gnespoli@ltm.arts.ryerson.ca/smart ~/ltm ; }
function eg () { mount -t smbfs //efgh@192.168.1.12/egdata ~/eg ; }

## internet
# dns servers
function dns() {
    case $1 in
        on ) sudo networksetup -setdnsservers Wi-Fi 192.254.74.201 198.27.106.150 208.110.81.50 ;;
        off ) sudo networksetup -setdnsservers Wi-Fi empty ;;
        list|show|get ) networksetup -getdnsservers Wi-Fi ;;
    esac
}

# open websites with keywords
function web() {
    case $1 in
        # research
        r|rye|ryerson|myryerson ) webpage="https://my.ryerson.ca" ;;
        l|lib ) webpage="http://learn.library.ryerson.ca/psychology" ;;
        s|scholar|sch ) webpage="http://scholar.google.com" ;;
        m|mendeley ) webpage="https://www.mendeley.com/library/" ;;
        # accounts
        b|bank|rbc ) webpage="https://www1.royalbank.com/cgi-bin/rbaccess/rbunxcgi?F6=1&F7=IB&F21=IB&F22=IB&REQUEST=ClientSignin&LANGUAGE=ENGLISH" ;;
        aft|ad|adfreetime ) webpage="https://adfreetime.com/service/" ;;
        presto ) webpage="https://www.prestocard.ca/en/" ;;
        # sports
        nhl ) webpage="https://www.nhl.com/tv" ;;
        mlb ) webpage="http://mlb.mlb.com/mediacenter/" ;;
        ashl ) webpage="https://bench.icesports.com/apex/pbHome" ;;
        tssc ) webpage="http://www.torontossc.com/profile/" ;;
        # misc
        f|fb|facebook ) webpage="http://www.facebook.com" ;;
    esac
    open $webpage
}
