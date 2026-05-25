-- Shared/vimscript plugins (also used by MacVim via vim-plug)
return {
  -- Editing
  'tpope/vim-rsi',
  'tpope/vim-eunuch',
  'tpope/vim-repeat',
  'tpope/vim-commentary',
  'tpope/vim-dotenv',
  'machakann/vim-sandwich',
  'github/copilot.vim',

  -- Git & Files
  'tpope/vim-fugitive',
  'rbong/vim-flog',
  'justinmk/vim-dirvish',
  'brianhuster/dirvish-git.nvim',

  -- Python
  { 'Vimjas/vim-python-pep8-indent', ft = 'python' },
  { 'kalekundert/vim-coiled-snake', ft = 'python' },
  { 'gabenespoli/vim-pythonsense', ft = 'python' },
  { 'psf/black', ft = 'python' },
  { 'fisadev/vim-isort', ft = 'python' },

  -- Tmux
  'christoomey/vim-tmux-navigator',
  'jpalardy/vim-slime',

  -- My Plugins
  'gabenespoli/vim-mutton',
  'gabenespoli/vim-tabsms',
  'gabenespoli/vim-jupycent',
}
