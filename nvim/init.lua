-- Author: Gabe Nespoli
-- Email: gabenespoli@gmail.com
-- File: init.lua (neovim)

-- Source shared vimscript settings
vim.cmd('source ' .. vim.fn.stdpath('config') .. '/shared.vim')

-- Neovim-specific modules
require('options')
require('keymaps')
require('statusline')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require('lazy').setup('plugins', {
  change_detection = { notify = false },
})
