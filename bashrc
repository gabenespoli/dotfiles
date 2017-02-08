#!/bin/bash

# .bashrc file for Gabriel A. Nespoli
# gabenespoli@gmail.com

# System-specific stuff
# ---------------------

# On a mac, add this to .bash_profile
# if [ -f $HOME/.bashrc ]; then
#       . $HOME/.bashrc
# fi

# Specify terminal depending on the machine
#if [ $HOSTNAME == "gmac" ] || [ $HOSTNAME == "gmac.local" ] || [ $HOSTNAME == "smartmacpro" ]
#then export TERM=xterm-256color-italic
#else export TERM=xterm-256color
#fi
export TERM=xterm-256color

# Mac Options
if [ "$(uname)" == "Darwin" ]
then
    alias ls="ls -hl"
    alias la="ls -hla"
    alias lsa="ls -hla"
    #export LSCOLORS=exFxbxdxBxegedabagacad # colors for ls
    export PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}\007"' # tab titles
    
    # disable ctrl-y as delayed suspend so that it can be re-bound in mutt
    #stty dsusp undef

    #powerline-daemon -q
    #POWERLINE_BASH_CONTINUATION=1
    #POWERLINE_BASH_SELECT=1
    #. /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh

# Linux Options
else
    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi
    alias ls="ls -hl --color"
    alias la="ls -hla --color"
    alias lsa="ls -hla --color"
    alias agi="sudo apt-get -y install"
    alias agu="sudo apt-get update"
    eval `dircolors $HOME/.dir_colors/dircolors`
    LS_COLORS=$LS_COLORS:'di=0;34:ln=0;35:ex=0;31:ow=30;42:' ; export LS_COLORS
    setxkbmap -option ctrl:nocaps
    setxkbmap -option shift:both_capslock
    setxkbmap -option altwin:swap_alt_win
fi

## Environment vars
# ----------------
export PATH="$HOME/bin:$HOME/bin/pandoc:/usr/local/texbin:/usr/local/lib:/usr/local/bin:$PATH"
export EDITOR='vim' # set default text editor
export GOOGLER_COLORS=Lecgxy
export CLICOLOR=1 # colors for ls
export PS1='\[\e[0;34m\] \w \[\e[0;37m\]\$\[\e[m\] '
#PS1='\[\e[0;34m\]\h:\W \$\[\e[m\] '
export VIMPAGER_RC="$HOME/.vimrc"

## Aliases & Functions
# -------------------
function cdl { cd $1; ls;}
alias grep="grep --color"
alias exe="chmod u+x"
alias cls='printf "\033c"'
alias gf="python $HOME/bin/gf.py"
function cdd() { cd "$(gf "$@")" ; }
function lss() { ls "$(gf "$@")" ; }

# todo
alias t="todo.sh"
alias tw="todo.sh list @work"
alias th="todo.sh list @home"
#function todo() { vimcat "$(gf $@)/todo.md" ; }
function notes() { vim "$(gf $@)/notes.md" ; }

# applications
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

# network
alias wifi="sudo networksetup -setairportnetwork en0"
alias smart="ssh gmac@smartmacpro.arts.ryerson.ca"
alias efgh="ssh efgh@192.168.1.12"
alias hrcommons="open vnc://141.117.114.20"

# misc shortcuts
alias paper="vim ~/r/gv/paper/NespoliRusso2016_groove.md"
alias dis="vim ~/r/gv/paper/PhD\ Proposal/Nespoli_PhDProposal.md"
alias gitlog="git log --graph --decorate --oneline"
#source $HOME/bin/utils/tabnew.sh

