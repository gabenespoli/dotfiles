#!/bin/bash

echo "" && echo "-- Linking python config..."
mkdir -pv "$HOME"/.ipython/profile_default
ln -sfv "$HOME"/dotfiles/python/ipython_config.py "$HOME"/.ipython/profile_default/ipython_config.py
ln -sfv "$HOME"/dotfiles/python/isort.cfg "$HOME"/.isort.cfg
ln -sfv "$HOME"/dotfiles/python/flake8 "$HOME"/.flake8

echo "" && echo "-- Installing miniconda and python environments..."
# https://docs.conda.io/projects/conda/en/latest/user-guide/install/macos.html
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O "$HOME"/miniconda.sh
bash "$HOME"/miniconda.sh -b -p $HOME/miniconda3
rm -v "$HOME"/miniconda.sh
conda init
conda update -n base -c defaults conda

conda create -y -n neovim2
conda deactivate && conda activate neovim2
conda install -y python=2.7.18
pip install neovim

conda create -y -n neovim3
conda deactivate && conda activate neovim3
conda install -y python
pip install pynvim

conda create -y -n base38
conda deactivate && conda activate base38
conda install -y python=3.8
conda install -y -c conda-forge \
  pandas ipython plotly scikit-learn statsmodels sqlalchemy pyodbc python-dotenv

# conda install -c conda-forge jupyterlab jupyterlab_code_formatter black isort
# jupyter serverextension enable --py jupyterlab_code_formatter
# jupyter labextension install @ryantam626/jupyterlab_code_formatter

# Use chesterish theme for jupyter notebooks
# conda install -c conda-forge jupyter jupyterthemes
# $ jt -t chesterish -f roboto
