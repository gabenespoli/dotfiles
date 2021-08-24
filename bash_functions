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
