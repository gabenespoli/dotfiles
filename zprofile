if [ -f /etc/profile ]; then

  # Setup PATH from scratch to avoid duplicates in tmux
  PATH=""
  source /etc/profile

  # Setup homebrew on PATH
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Overwrite builtins on PATH with homebrew-installed GNU ones
  if hash gls 2> /dev/null; then
    for gnu in coreutils findutils grep gnu-sed gawk; do
      export PATH="$HOMEBREW_PREFIX/opt/$gnu/libexec/gnubin:$PATH"
      export MANPATH="$HOMEBREW_PREFIX/opt/$gnu/libexec/gnuman:$MANPATH"
    done
    alias ll="gls -F --color --group-directories-first"
    alias ls="gls -Flh --color --group-directories-first"
    alias la="gls -Flha --color --group-directories-first"
  else
    alias ll="ls -F"
    alias ls="ls -Flh"
    alias la="ls -Flha"
  fi

  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
          . "$HOME/miniconda3/etc/profile.d/conda.sh"
      else
          export PATH="$HOME/miniconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<

fi
