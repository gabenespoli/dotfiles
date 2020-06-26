# https://superuser.com/a/583502/225931
if [ -f /etc/bash_profile ]; then
  PATH=
  source /etc/bash_profile
fi

if [ -f $HOME/.bashrc ]; then
  . $HOME/.bashrc
fi
