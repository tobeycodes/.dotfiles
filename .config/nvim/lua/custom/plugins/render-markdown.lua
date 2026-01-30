-- render-markdown.nvim
-- https://github.com/MeanderingProgrammer/render-markdown.nvim

vim.pack.add {
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/echasnovski/mini.nvim',
}

---@module 'render-markdown'
---@type render.md.UserConfig
require('render-markdown').setup {}