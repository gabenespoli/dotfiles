#!/bin/bash

for rc in isort.cfg flake8; do
  [ -e "$HOME"/."$rc" ] && mv -v "$HOME"/."$rc" "$BAKDIR"/"$rc"
  ln -sfv "$HOME"/dotfiles/"$rc" "$HOME"/."$rc"
done

mkdir -pv "$HOME"/.ipython/profile_default
ln -sfv "$HOME"/dotfiles/ipython/profile_default/ipython_config.py \
  "$HOME"/.ipython/profile_default/ipython_config.py

# https://docs.conda.io/projects/conda/en/latest/user-guide/install/macos.html
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda
conda init
conda update -n base -c defaults conda

# # base 3.7 env
# conda create -y -n base37 python=3.7.10
# conda activate base37
# conda install -c conda-forge -y \
#   flake8 mypy pydocstyle black isort pytest python-language-server jedi \
#   numpy pandas pyarrow matplotlib seaborn plotly dash \
#   scikit-learn statsmodels xgboost catboost lightgbm \
#   python-dotenv sqlalchemy pyodbc \
#   ipython jupyter jupyterlab
# conda install -c conda-forge -c plotly -y jupyter-dash
# pip install jupytext jupyterlab_execute_time
# jupyter labextension install jupyterlab-plotly jupyterlab-dash plotlywidget
# jupyter lab build

# base env
conda activate base
conda install -c conda-forge -y \
  flake8 black isort pytest \
  numpy pandas pyarrow matplotlib seaborn plotly dash dash-bootstrap-components \
  scikit-learn statsmodels xgboost catboost lightgbm \
  # python-language-server jedi \
  ipython jupyter jupyterlab \
  python-dotenv sqlalchemy pyodbc \
  # sphinx sphinx-rtd-theme \
# conda install -c conda-forge -c plotly -y jupyter-dash
# pip install jupytext jupyterlab_execute_time
# pip install pyspark-stubs databricks-cli
# conda install -c conda-forge python-kaleido

# plotly support in jupyter lab
# jupyter labextension install jupyterlab-plotly jupyterlab-dash plotlywidget

# rebuild to activate jupyter-dash extension
# jupyter lab build

# env for neovim
conda create -y -n neovim3
conda activate neovim3
conda install -y python
pip install pynvim
  # flake8 mypy pydocstyle black isort \
  # python-language-server jedi
# pip install neovim pynvim

# conda create -y -n neovim2 python=2.7.15
# conda activate neovim2
# pip install neovim pynvim
