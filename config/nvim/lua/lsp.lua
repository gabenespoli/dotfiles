-- LSP configuration

-- Completion kinds
require('vim.lsp.protocol').CompletionItemKind = {
  ' Class',
  ' Color',
  ' Constant',
  ' Constructor',
  ' Enum',
  ' EnumMember',
  '󰄶 Field',
  ' File',
  ' Folder',
  ' Function',
  '󰜰 Interface',
  '󰌆 Keyword',
  'ƒ Method',
  '󰏗 Module',
  ' Property',
  '󰘍 Snippet',
  ' Struct',
  ' Text',
  ' Unit',
  '󰎠 Value',
  ' Variable',
}

-- Diagnostics
vim.diagnostic.config({
  underline = false,
  virtual_text = false,
  severity_sort = true,
  float = { border = 'rounded' },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
  },
})

-- Language servers
local on_attach = function(client, bufnr)
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
end

vim.lsp.config('terraformls', { on_attach = on_attach })
vim.lsp.config('ruff', { on_attach = on_attach })
vim.lsp.config('pyright', {
  on_init = function(client)
    local venv_python = client.root_dir .. '/.venv/bin/python'
    if vim.fn.filereadable(venv_python) == 1 then
      client.config.settings.python.pythonPath = venv_python
    end
  end,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'off',
        diagnosticMode = 'off',
      },
    },
  },
})

vim.lsp.enable({ 'pyright', 'ruff', 'terraformls' })
