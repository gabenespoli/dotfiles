# https://superuser.com/a/583502/225931
if [ -f /etc/bash_profile ]; then
  PATH=
  source /etc/bash_profile
fi

if [ -f $HOME/.bashrc ]; then
  . $HOME/.bashrc
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/53gnespoli/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/53gnespoli/miniconda/etc/profile.d/conda.sh" ]; then
        . "/Users/53gnespoli/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/53gnespoli/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

