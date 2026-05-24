-- Neovim-specific keymaps (shared keymaps are in shared.vim)

-- echo syntax under cursor (nvim has :Inspect)
vim.keymap.set('n', 'zS', ':Inspect<CR>')

-- Tmux navigator
if vim.env.TMUX then
  vim.keymap.set('n', '<M-h>', ':TmuxNavigateLeft<CR>', { silent = true })
  vim.keymap.set('n', '<M-j>', ':TmuxNavigateDown<CR>', { silent = true })
  vim.keymap.set('n', '<M-k>', ':TmuxNavigateUp<CR>', { silent = true })
  vim.keymap.set('n', '<M-l>', ':TmuxNavigateRight<CR>', { silent = true })
  vim.keymap.set('i', '<M-h>', '<Esc>:TmuxNavigateLeft<CR>', { silent = true })
  vim.keymap.set('i', '<M-j>', '<Esc>:TmuxNavigateDown<CR>', { silent = true })
  vim.keymap.set('i', '<M-k>', '<Esc>:TmuxNavigateUp<CR>', { silent = true })
  vim.keymap.set('i', '<M-l>', '<Esc>:TmuxNavigateRight<CR>', { silent = true })
  vim.keymap.set('v', '<M-h>', '<Esc>:TmuxNavigateLeft<CR>', { silent = true })
  vim.keymap.set('v', '<M-j>', '<Esc>:TmuxNavigateDown<CR>', { silent = true })
  vim.keymap.set('v', '<M-k>', '<Esc>:TmuxNavigateUp<CR>', { silent = true })
  vim.keymap.set('v', '<M-l>', '<Esc>:TmuxNavigateRight<CR>', { silent = true })
  vim.keymap.set('t', '<M-h>', '<C-\\><C-N>:TmuxNavigateLeft<CR>', { silent = true })
  vim.keymap.set('t', '<M-j>', '<C-\\><C-N>:TmuxNavigateDown<CR>', { silent = true })
  vim.keymap.set('t', '<M-k>', '<C-\\><C-N>:TmuxNavigateUp<CR>', { silent = true })
  vim.keymap.set('t', '<M-l>', '<C-\\><C-N>:TmuxNavigateRight<CR>', { silent = true })
else
  vim.keymap.set('', '<D-h>', '<C-w>h')
  vim.keymap.set('', '<D-j>', '<C-w>j')
  vim.keymap.set('', '<D-k>', '<C-w>k')
  vim.keymap.set('', '<D-l>', '<C-w>l')
end

-- LSP keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { silent = true })
vim.keymap.set('n', '<C-k>d', vim.diagnostic.setloclist)
vim.keymap.set('n', '<C-k>r', vim.lsp.buf.rename)
vim.keymap.set('n', 'cod', function() vim.diagnostic.enable(false) end)
vim.keymap.set('n', 'coD', function() vim.diagnostic.enable(true) end)

-- Python LSP navigation
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.keymap.set('n', '<C-w><C-d>', '<C-w><C-v>gdzt', { buffer = true })
    vim.keymap.set('n', '<C-]>', 'gdzt', { buffer = true })
  end,
})

-- FzfLua keymaps
vim.keymap.set('n', '<C-p>',        ':FzfLua git_files<CR>')
vim.keymap.set('n', '<C-k><C-b>',   ':FzfLua buffers<CR>')
vim.keymap.set('n', '<C-k><C-d>',   ':FzfLua lsp_document_diagnostics<CR>')
vim.keymap.set('n', '<C-k><C-g>',   ':FzfLua live_grep<CR>')
vim.keymap.set('n', '<C-k><C-f>',   ':FzfLua files<CR>')
vim.keymap.set('n', '<C-k><C-k>',   ':FzfLua resume<CR>')
vim.keymap.set('n', '<C-k><C-l>',   ':FzfLua git_commits<CR>')
vim.keymap.set('n', '<C-k><C-o>',   ':FzfLua oldfiles<CR>')
vim.keymap.set('n', '<C-k><C-r>',   ':FzfLua registers<CR>')
vim.keymap.set('n', '<C-k><C-s>',   ':FzfLua git_status<CR>')
vim.keymap.set('n', '<C-k><Space>',  ':FzfLua<Space>')
vim.keymap.set('n', '<C-k>gr',      ':FzfLua lsp_references<CR>')

-- Diagnostic + GitSigns preview on =
vim.keymap.set('n', '=', function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if #diagnostics > 0 then
    vim.diagnostic.open_float()
  else
    vim.cmd('Gitsigns preview_hunk')
  end
end)

-- Gitsigns keymaps
vim.keymap.set('n', 'ga', ':Gitsigns stage_hunk<CR>')
vim.keymap.set('n', 'ghu', ':Gitsigns reset_hunk<CR>')
vim.keymap.set('n', 'cogg', ':Gitsigns toggle_signs<CR>')
vim.keymap.set('n', 'cogl', ':Gitsigns toggle_linehl<CR>')
vim.keymap.set('n', 'cogn', ':Gitsigns toggle_numhl<CR>')
vim.keymap.set({ 'v', 'o' }, 'ac', ':<C-U>Gitsigns select_hunk<CR>')
vim.keymap.set('n', 'dac', ':<C-U>Gitsigns select_hunk<CR>d')
vim.keymap.set('n', 'cac', ':<C-U>Gitsigns select_hunk<CR>c')
