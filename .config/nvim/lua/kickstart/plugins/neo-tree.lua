-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

require('neo-tree').setup {
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
}