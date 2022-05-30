#!/bin/bash
cd "$HOME"/dotfiles/qmk
mv -v "$HOME"/Downloads/massdrop_carina_c_Carina_Clea_33743.bin .
./mdloader_mac --first --download massdrop_carina_c_Carina_Clea_33743.bin --restart   
# press <Fn>b
cd -
