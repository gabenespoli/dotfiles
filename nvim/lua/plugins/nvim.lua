-- Neovim-only plugins
return {
  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Diagnostics config
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

      -- on_attach
      local on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
        vim.lsp.handlers['textDocument/signature_help'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
      end

      -- Server configs
      vim.lsp.config.efm = { on_attach = on_attach }
      vim.lsp.config.terraformls = { on_attach = on_attach }
      vim.lsp.config.pyright = {
        on_attach = on_attach,
        settings = {
          python = { analysis = { typeCheckingMode = 'off' } },
        },
      }
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local filetypes = { 'python', 'vim', 'sql', 'zsh', 'bash', 'yaml', 'html', 'gitconfig', 'json' }
      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function() vim.treesitter.start() end,
      })
    end,
  },

  -- Gitsigns
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs_staged_enable = true,
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '┃' },
        },
        signs_staged = {
          add          = { text = '┋ ' },
          change       = { text = '┋ ' },
          delete       = { text = '﹍' },
          topdelete    = { text = '﹉' },
          changedelete = { text = '┋ ' },
        },
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          map('v', 'ga', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
          map('v', 'ghu', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
        end,
      })
    end,
  },

  -- Devicons
  {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({
        override_by_extension = {
          ['txt'] = {
            icon = '󰈙',
            color = '#89e051',
            cterm_color = '113',
            name = 'Txt',
          },
        },
      })
    end,
  },

  -- FzfLua
  {
    'ibhagwan/fzf-lua',
    config = function()
      local actions = require('fzf-lua.actions')
      require('fzf-lua').setup({
        actions = {
          files = {
            ['default'] = actions.file_edit,
            ['ctrl-s']  = actions.file_split,
            ['ctrl-v']  = actions.file_vsplit,
            ['ctrl-t']  = actions.file_tabedit,
            ['ctrl-q']  = actions.file_sel_to_qf,
          },
        },
      })
    end,
  },
}
