# Add `source "%HOME"/dotfiles/bash_aliases` to bashrc/zshrc

export CLICOLOR=1
export LS_COLORS=$LS_COLORS:'di=0;34:ln=0;36:ex=0;35:ow=30;42:'
export EDITOR='nvim'

export HOMEBREW_NO_AUTO_UPDATE=1

alias ll="ls -F"
alias ls="ls -Flh"
alias la="ls -Flha"

alias ta="tmux attach"
alias exe="chmod u+x"
alias weather="curl http://wttr.in/Kitchener"

# python {{{1
alias cl="conda env list"
alias ca="conda deactivate && conda activate"

# git {{{1
alias gs="git status --short"
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
alias gR="git reset HEAD^ && gs"

alias Gl="$EDITOR +'Flog'"
alias GL="$EDITOR +'Flog -all'"
alias Gs="$EDITOR -c ':Gedit :'"
alias GS=Gs

# fzf {{{1
export FZF_DEFAULT_OPTS='
  --layout reverse
  --color=hl:8,fg+:15,bg+:0,hl+:2,info:5,prompt:2,pointer:2,marker:6,spinner:2,header:7
  --preview "bat --style=numbers --color=always --line-range :500 {}"
  '


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


