#!/bin/bash
echo "" && echo "-- Setting up tmux-256color terminal..."

# https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95
curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz
gunzip terminfo.src.gz
/usr/bin/tic -xe alacritty-direct,tmux-256color terminfo.src
trash terminfo.src

# https://github.com/htop-dev/htop/issues/251#issuecomment-719080271
# https://gist.github.com/nicm/ea9cf3c93f22e0246ec858122d9abea1
curl -L https://gist.githubusercontent.com/nicm/ea9cf3c93f22e0246ec858122d9abea1/raw/37ae29fc86e88b48dbc8a674478ad3e7a009f357/tmux-256color > tmux-256color.terminfo
/usr/bin/tic -x tmux-256color.terminfo
trash tmux-256color.terminfo

# https://github.com/alacritty/alacritty/blob/master/INSTALL.md#terminfo
curl -L https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info > alacritty.info
/usr/bin/tic -xe alacritty,alacritty-direct alacritty.info
trash alacritty.info
