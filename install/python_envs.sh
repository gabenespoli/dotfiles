#!/bin/bash

echo "" && echo "-- Installing python envs..."

ln -sfv "$HOME"/dotfiles/isort.cfg "$HOME"/.isort.cfg
ln -sfv "$HOME"/dotfiles/flake8 "$HOME"/.flake8

mkdir -pv "$HOME"/.ipython/profile_default
ln -sfv "$HOME"/dotfiles/ipython/profile_default/ipython_config.py \
  "$HOME"/.ipython/profile_default/ipython_config.py

# https://docs.conda.io/projects/conda/en/latest/user-guide/install/macos.html
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O "$HOME"/miniconda.sh
bash "$HOME"/miniconda.sh -b -p $HOME/miniconda3
rm "$HOME"/miniconda.sh
conda init
conda update -n base -c defaults conda

# env for neovim
conda create -y -n neovim3
conda deactivate && conda activate neovim3
conda install -y python
pip install pynvim

conda create -y -n base38
conda deactivate && conda activate base38
conda install -y python=3.8
conda install -y -c conda-forge \
  pandas ipython statsmodels sqlalchemy pyodbc plotly python-dotenv
