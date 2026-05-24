-- Neovim-specific options
vim.opt.undofile = true

vim.opt.number = true
vim.opt.mouse = ''

if vim.fn.isdirectory(vim.fn.expand('~') .. '/.pyenv/versions/neovim') == 1 then
  vim.g.python3_host_prog = vim.fn.expand('~') .. '/.pyenv/versions/neovim/bin/python'
elseif vim.fn.isdirectory(vim.fn.expand('~') .. '/.pyenv/neovim3') == 1 then
  vim.g.python3_host_prog = vim.fn.expand('~') .. '/.pyenv/neovim3/bin/python'
end

-- termguicolors in tmux
if vim.env.TMUX then
  vim.opt.termguicolors = true
end
