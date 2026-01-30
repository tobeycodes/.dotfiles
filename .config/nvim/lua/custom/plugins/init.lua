-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          auto_trigger = true,
          copilot_model = 'claude-sonnet-4.5',
        },
      }
    end,
  },

  {
    'nickjvandyke/opencode.nvim',
    version = '*', -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        'folke/snacks.nvim',
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...) return require('opencode').snacks_picker_send(...) end,
            },
            win = {
              input = {
                keys = {
                  ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type or field for details
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set({ 'n', 'x' }, '<C-a>', function() require('opencode').ask('@this: ', { submit = true }) end, { desc = 'Ask opencode…' })
      vim.keymap.set({ 'n', 'x' }, '<C-x>', function() require('opencode').select() end, { desc = 'Execute opencode action…' })
      vim.keymap.set({ 'n', 't' }, '<C-.>', function() require('opencode').toggle() end, { desc = 'Toggle opencode' })

      vim.keymap.set({ 'n', 'x' }, 'go', function() return require('opencode').operator '@this ' end, { desc = 'Add range to opencode', expr = true })
      vim.keymap.set('n', 'goo', function() return require('opencode').operator '@this ' .. '_' end, { desc = 'Add line to opencode', expr = true })

      vim.keymap.set('n', '<S-C-u>', function() require('opencode').command 'session.half.page.up' end, { desc = 'Scroll opencode up' })
      vim.keymap.set('n', '<S-C-d>', function() require('opencode').command 'session.half.page.down' end, { desc = 'Scroll opencode down' })

      -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
      vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment under cursor', noremap = true })
      vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement under cursor', noremap = true })
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },

  {
    'windwp/nvim-ts-autotag',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    config = function() require('nvim-ts-autotag').setup() end,
  },

  {
    'mbbill/undotree',
    keys = {
      {
        '<leader>u',
        '<cmd>UndotreeToggle<cr>',
        desc = 'Undo Tree',
      },
    },
  },

  {
    'ruifm/gitlinker.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('gitlinker').setup {
        mappings = nil,
      }
    end,
    keys = {
      {
        '<leader>ho',
        '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        desc = 'Copy link to current line',
        mode = 'n',
      },
      {
        '<leader>ho',
        '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        desc = 'Copy link to current line',
        mode = 'v',
      },
    },
  },

  {
    'laytan/cloak.nvim',
    config = function() require('cloak').setup() end,
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      local notify = require 'notify'
      notify.setup {
        merge_duplicates = true,
        top_down = false,
      }

      require('noice').setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },

  {
    'christoomey/vim-tmux-navigator',
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
}
