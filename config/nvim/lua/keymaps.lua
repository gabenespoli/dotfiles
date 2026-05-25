-- Neovim-specific keymaps

-- LSP
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<C-k>d', vim.diagnostic.setloclist)
vim.keymap.set('n', 'cod', function() vim.diagnostic.enable(false) end)
vim.keymap.set('n', 'coD', function() vim.diagnostic.enable(true) end)

-- Python LSP
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.keymap.set('n', '<C-w><C-d>', '<C-w><C-v>gdzt', { buffer = true })
    vim.keymap.set('n', '<C-]>', 'gdzt', { buffer = true })
    vim.keymap.set('n', 'gqq', function() vim.lsp.buf.format() end, { buffer = true })
  end,
})

-- FzfLua
vim.keymap.set('n', '<C-p>', ':FzfLua git_files<CR>')
vim.keymap.set('n', '<C-k><C-b>', ':FzfLua buffers<CR>')
vim.keymap.set('n', '<C-k><C-d>', ':FzfLua lsp_document_diagnostics<CR>')
vim.keymap.set('n', '<C-k><C-g>', ':FzfLua live_grep<CR>')
vim.keymap.set('n', '<C-k><C-f>', ':FzfLua files<CR>')
vim.keymap.set('n', '<C-k><C-k>', ':FzfLua resume<CR>')
vim.keymap.set('n', '<C-k><C-l>', ':FzfLua git_commits<CR>')
vim.keymap.set('n', '<C-k><C-o>', ':FzfLua oldfiles<CR>')
vim.keymap.set('n', '<C-k><C-r>', ':FzfLua registers<CR>')
vim.keymap.set('n', '<C-k><C-s>', ':FzfLua git_status<CR>')
vim.keymap.set('n', '<C-k><Space>', ':FzfLua ')
vim.keymap.set('n', '<C-k>gr', ':FzfLua lsp_references<CR>')

-- Gitsigns
vim.keymap.set('n', 'ga', ':Gitsigns stage_hunk<CR>')
vim.keymap.set('n', 'ghu', ':Gitsigns reset_hunk<CR>')
vim.keymap.set('n', 'cogg', ':Gitsigns toggle_signs<CR>')
vim.keymap.set('n', 'cogl', ':Gitsigns toggle_linehl<CR>')
vim.keymap.set('n', 'cogn', ':Gitsigns toggle_numhl<CR>')
vim.keymap.set({ 'v', 'o' }, 'ac', ':<C-U>Gitsigns select_hunk<CR>')
vim.keymap.set('n', 'dac', ':<C-U>Gitsigns select_hunk<CR>d')
vim.keymap.set('n', 'cac', ':<C-U>Gitsigns select_hunk<CR>c')

-- Diagnostic/Gitsigns preview on =
vim.keymap.set('n', '=', function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if #diagnostics > 0 then
    vim.diagnostic.open_float()
  else
    vim.cmd('Gitsigns preview_hunk')
  end
end)

-- Treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python', 'vim', 'sql', 'bash', 'yaml', 'html', 'json' },
  callback = function() vim.treesitter.start() end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'zsh',
  callback = function() vim.treesitter.start(0, 'bash') end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitconfig',
  callback = function() vim.treesitter.start(0, 'git_config') end,
})
