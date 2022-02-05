#!/bin/bash

# https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95

echo "" && echo "-- Setting up tmux-256color terminal..."
curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz
gunzip terminfo.src.gz
/usr/bin/tic -xe alacritty-direct,tmux-256color terminfo.src
trash terminfo.src
