#!/bin/bash
cd ~/dotfiles/qmk
mv ~/Downloads/massdrop_carina_c_Carina_20399.bin .
./mdloader_mac --first --download massdrop_carina_c_Carina_20399.bin --restart   
# press <Fn>b
cd -
