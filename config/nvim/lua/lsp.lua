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
local diagnostic_display = {
  gutter = false,
  line = false,
  number = true,
}

local diagnostic_signs = {
  [vim.diagnostic.severity.ERROR] = 'E',
  [vim.diagnostic.severity.WARN] = 'W',
  [vim.diagnostic.severity.INFO] = 'I',
  [vim.diagnostic.severity.HINT] = 'H',
}

local diagnostic_sign_highlights = {
  [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
  [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
  [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
  [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
}

local diagnostic_number_highlights = {
  [vim.diagnostic.severity.ERROR] = 'DiagnosticSignErrorNr',
  [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarnNr',
  [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfoNr',
  [vim.diagnostic.severity.HINT] = 'DiagnosticSignHintNr',
}

local diagnostic_line_highlights = {
  [vim.diagnostic.severity.ERROR] = 'DiagnosticLineError',
  [vim.diagnostic.severity.WARN] = 'DiagnosticLineWarn',
  [vim.diagnostic.severity.INFO] = 'DiagnosticLineInfo',
  [vim.diagnostic.severity.HINT] = 'DiagnosticLineHint',
}

local empty_diagnostic_display = {
  [vim.diagnostic.severity.ERROR] = '',
  [vim.diagnostic.severity.WARN] = '',
  [vim.diagnostic.severity.INFO] = '',
  [vim.diagnostic.severity.HINT] = '',
}

local function configure_diagnostics()
  vim.diagnostic.config({
    underline = false,
    virtual_text = false,
    severity_sort = true,
    float = { border = 'rounded' },
    signs = {
      text = diagnostic_display.gutter and diagnostic_signs or empty_diagnostic_display,
      texthl = diagnostic_sign_highlights,
      linehl = diagnostic_display.line and diagnostic_line_highlights or empty_diagnostic_display,
      numhl = diagnostic_display.number and diagnostic_number_highlights or empty_diagnostic_display,
    },
  })
end

local function toggle_diagnostic_display(kind)
  diagnostic_display[kind] = not diagnostic_display[kind]
  configure_diagnostics()
end

configure_diagnostics()

-- Language servers
local python_root_markers = {
  'pyproject.toml',
  'ruff.toml',
  'setup.py',
  'setup.cfg',
}

local function python_root(bufnr, on_dir)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local file_dir = vim.fs.dirname(filename)
  local home = vim.fs.normalize(vim.env.HOME)
  local root = vim.fs.root(filename, python_root_markers)

  if root == home then
    root = nil
  end

  root = root or file_dir
  on_dir(root == home and nil or root)
end

local on_attach = function(client, bufnr)
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
  -- Prevent LSP from overriding formatexpr (use conform.nvim instead)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

vim.lsp.config('terraformls', { on_attach = on_attach })
vim.lsp.config('ruff', {
  on_attach = on_attach,
  root_dir = python_root,
})
vim.lsp.config('pyright', {
  on_init = function(client)
    local venv_python = client.root_dir .. '/.venv/bin/python'
    if vim.fn.filereadable(venv_python) == 1 then
      client.config.settings.python.pythonPath = venv_python
    end
  end,
  on_attach = on_attach,
  root_dir = python_root,
})

vim.lsp.enable({ 'pyright', 'ruff', 'terraformls' })

return {
  toggle_gutter = function() toggle_diagnostic_display('gutter') end,
  toggle_line = function() toggle_diagnostic_display('line') end,
  toggle_number = function() toggle_diagnostic_display('number') end,
}
