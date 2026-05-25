-- Plugin specs for lazy.nvim
return {
  -- Shared plugins (config in vimrc)
  'tpope/vim-rsi',
  'tpope/vim-eunuch',
  'tpope/vim-repeat',
  'tpope/vim-commentary',
  'tpope/vim-dotenv',
  'machakann/vim-sandwich',
  'justinmk/vim-dirvish',
  'brianhuster/dirvish-git.nvim',
  'gabenespoli/vim-mutton',
  'gabenespoli/vim-tabsms',
  'tpope/vim-fugitive',
  'rbong/vim-flog',
  'github/copilot.vim',
  { 'Vimjas/vim-python-pep8-indent', ft = 'python' },
  { 'kalekundert/vim-coiled-snake', ft = 'python' },
  { 'gabenespoli/vim-pythonsense', ft = 'python' },
  'christoomey/vim-tmux-navigator',
  'jpalardy/vim-slime',
  'gabenespoli/vim-jupycent',

  -- Nvim-only plugins
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local installed = require('nvim-treesitter').get_installed()
      local ensure = { 'python', 'sql', 'bash', 'json', 'vim', 'lua', 'git_config' }
      local missing = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, ensure)
      if #missing > 0 then
        require('nvim-treesitter').install(missing)
      end
    end,
  },

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
