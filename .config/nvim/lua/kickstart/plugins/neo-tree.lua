-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    window = {
      position = 'float',
      popup = {
        title = 'Files',
      },
      mappings = {
        ['P'] = {
          'toggle_preview',
          config = {
            use_float = true,
            use_image_nvim = true,
            use_snacks_image = true,
            title = 'Preview',
          },
        },
      },
    },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        never_show = {
          '.git',
          '.jj',
        },
      },
      use_libuv_file_watcher = true,
    },
  },
}
