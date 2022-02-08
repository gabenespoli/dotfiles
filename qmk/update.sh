#!/bin/bash
cd "$HOME"/dotfiles/qmk
mv -v "$HOME"/Downloads/massdrop_carina_c_Carina_20399.bin .
./mdloader_mac --first --download massdrop_carina_c_Carina_20399.bin --restart   
# press <Fn>b
cd -
