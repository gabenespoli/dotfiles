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

      -- Server configs
      vim.lsp.config.ruff = {}
      vim.lsp.config.terraformls = {}
      vim.lsp.config.pyright = {
        settings = {
          pyright = { disableOrganizeImports = true },
          python = {
            analysis = {
              diagnosticMode = 'off',
              typeCheckingMode = 'off',
            },
          },
        },
      }

      vim.lsp.enable({ 'ruff', 'pyright', 'terraformls' })
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local filetypes = { 'python', 'vim', 'sql', 'bash', 'yaml', 'html', 'json' }
      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function() vim.treesitter.start() end,
      })
      -- zsh uses bash parser; gitconfig uses git_config parser
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'zsh',
        callback = function() vim.treesitter.start(0, 'bash') end,
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'gitconfig',
        callback = function() vim.treesitter.start(0, 'git_config') end,
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
