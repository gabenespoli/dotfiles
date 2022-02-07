# working with csv files
# ----------------------
function hgrep() {
  # "header-row grep"
  # usage like grep
  # shows first line of file, then result of grep
  # useful for csv files with a header row
  head -1 "${@: -1}" && grep "$@"
}

function hcgrep() {
  # "header-row grep with column display"
  # basically a prettier-printed version of hgrep
  hgrep "$@" | sed 's/,,/,_,/g' | sed 's/,,/,_,/g' | sed 's/,$/,_/g' | column -ts,
}

function gronflat {
  gron "$@" | grep -v '\[[1-9]\]' | grep -v '{}'
}

# GIT heart FZF
# -------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
}

_gf() {
  # git status
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
  cut -c4- | sed 's/.* -> //'
}

_gb() {
  # git branch
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(6)%cd %C(blue)[%h] %C(8){%an}%C(auto)%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

_gt() {
  # git tags
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
}

_gh() {
  # git log
  is_in_git_repo || return
  git log --date=short --format="%C(6)%cd %C(blue)[%h] %C(8){%an}%C(auto)%d %s" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
}

_gp() {
  # files
  find * -type f |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
}

# _gp() {
#   # conda env revisions
#   conda list --revisions | grep '^
#   find * -type f |
#   fzf-down --multi --preview-window right:70%
# }

if [[ $- =~ i ]]; then
  bind '"\er": redraw-current-line'
  bind '"\C-g\C-f": "$(_gf)\e\C-e\er"'
  bind '"\C-g\C-b": "$(_gb)\e\C-e\er"'
  bind '"\C-g\C-t": "$(_gt)\e\C-e\er"'
  bind '"\C-g\C-h": "$(_gh)\e\C-e\er"'
  bind '"\C-g\C-p": "$(_gp)\e\C-e\er"'
fi
