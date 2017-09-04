#!/bin/bash

## OS-specific options {{{1
if [ "$(uname)" == "Darwin" ]; then
    ### Mac options
    export PATH="$HOME/bin:/usr/local/texbin:$HOME/Library/Haskell/bin:/usr/local/lib:/usr/local/bin:$PATH"
    alias ls="ls -hl"
    alias la="ls -hla"
    alias lsa="ls -hla"
    alias agi="brew install"
    alias agu="brew update && brew upgrade && brew cleanup"
    alias ql='qlmanage -p &>/dev/null'
    export MATLAB="/Applications/MATLAB_R2017a.app"
    export MATLAB2="/Applications/MATLAB_R2016a.app"
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

else 
    ### Linux options
    export PATH="$HOME/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/lib:/usr/local/bin:$PATH"
    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi
    alias ls="ls -hl --color"
    alias la="ls -hla --color"
    alias lsa="ls -hla --color"
    alias agi="sudo apt-get -y install"
    alias agu="sudo apt-get update"
    alias sambastart="sudo /etc/init.d/samba start"
    alias ranger="/usr/local/bin/ranger"
    alias trash="gvfs-trash"
    export MATLAB="/usr/local/MATLAB/R2017a"
    export MATLAB2="/usr/local/MATLAB/R2016a"
    #eval `dircolors $HOME/.dir_colors/dircolors`
    LS_COLORS=$LS_COLORS:'di=0;34:ln=0;36:ex=0;35:ow=30;42:' ; export LS_COLORS
    setxkbmap -option ctrl:nocaps
    setxkbmap -option shift:both_capslock
fi

## Environment vars {{{1
git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/:\1/' ; }
export PS1='\[\e[0;34m\] \w\[\e[0;37m\]$(git_branch) \$\[\e[m\] '
export EDITOR='vim'
export CLICOLOR=1
export MPLCONFIGDIR="$HOME/dotfiles/matplotlib"
export FZF_DEFAULT_OPTS='--bind=ctrl-j:accept,ctrl-k:kill-line,ctrl-w:backward-kill-word,ctrl-n:down,ctrl-p:up'

# setup ruby env (requires rbenv to be installed)
eval "$(rbenv init -)"

## Aliases & Functions {{{1
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
alias vim="vim -p"
alias pylab="ipython --pylab"
alias matlab="rlwrap -c -a dummy_arg $MATLAB/bin/matlab -nosplash -nodesktop"
alias matlab2="rlwrap -c -a dummy_arg $MATLAB2/bin/matlab -nosplash -nodesktop"
alias pip_upgrade="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
function cdl { cd $1; ls;}
function cdd() { cd "$(gf "$@")" ; }
function lss() { ls "$(gf "$@")" ; }
function catcsv() { call="awk -F \",\" '{print $"$2"}' $1"; eval ${call} ; } # usage: catcsv csvFilename columnNumber
function settitle() { printf "\033k$1\033\\" ; }

### git {{{2
alias gs="git status -sb"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gr="git reset"
alias glog="git log --graph --decorate --oneline"

### todo, notes, and calendar {{{2
alias t="todo.sh -a"
alias in="todo.sh -a add +in"
alias todo="vim -O $HOME/todo/todo.txt $HOME/todo/backlog.txt $HOME/todo/someday.txt"
alias trello="$HOME/bin/trello-cli/bin/trello"
alias ts="trello show-cards -b scrum -l sprint"
alias tsync="python ~/bin/task2todotxt/task2todotxt.py"
alias gcal="$HOME/bin/gcalcli_wrapper.sh"
alias wf="python $HOME/bin/Workflows/Workflows.py $HOME/r/notes/"
function notes() { vim "$(gf $@)/notes.md" ; }
function note() {
    notesDir="$HOME/notes/"
    title="$*"
    filename="$notesDir/$title.md"
    if [ ! -f "$filename" ]; then touch "$filename" && echo "# $title"$'\n' >> "$filename"; fi
    vim "$filename"
}

### others {{{2
alias mail="mutt -F $HOME/dotfiles/muttrc"
alias Mail="offlineimap && mutt -F $HOME/dotfiles/muttrc -e 'push <change-folder>=Archive<enter>'"
alias gmail="mutt -F $HOME/dotfiles/mutt/gmail.muttrc"
alias vimdiff="vimdiff -c 'windo set wrap' -c 'windo set number' -c 'hi _DiffDelPos cterm=underline ctermfg=1 ctermbg=0'"
alias pdoc="$HOME/dotfiles/pandoc/pdoc"
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
alias gvpaper="vim ~/r/gv/paper/Nespoli2017.md"
alias ecpaper='vim ~/Dropbox/research/archive/2014/ec/paper/NespoliGoySinghRusso2017.md'
alias dis="vim ~/r/phd/proposal/Nespoli_PhD_Proposal.md"
alias cv="vim ~/r/archive/2017/OGS/cv/NespoliGA_cv.md"

## network {{{1
alias smart="ssh gmac@smartmacpro.arts.ryerson.ca"
alias smarts="open vnc://gmac@smartmacpro.arts.ryerson.ca"
alias efgh="ssh efgh@192.168.1.12"
function ltm() { mount -t smbfs //gnespoli@ltm.arts.ryerson.ca/smart ~/ltm ; }
function eg () { mount -t smbfs //efgh@192.168.1.12/egdata ~/eg ; }

## internet {{{1
### dns servers {{{2
function dns() {
    case $1 in
        on ) sudo networksetup -setdnsservers Wi-Fi 192.254.74.201 198.27.106.150 208.110.81.50 ;;
        off ) sudo networksetup -setdnsservers Wi-Fi empty ;;
        list|show|get ) networksetup -getdnsservers Wi-Fi ;;
    esac
}

### open websites with keywords {{{2
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
        plex ) webpage="http://192.168.1.12:32400/web" ;;
    esac
    open $webpage
}
