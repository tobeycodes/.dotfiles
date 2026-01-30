-- gitlinker.nvim
-- https://github.com/ruifm/gitlinker.nvim

vim.pack.add {
  'https://github.com/ruifm/gitlinker.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
}

require('gitlinker').setup {
  mappings = nil,
}

vim.keymap.set('n', '<leader>ho', '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', { desc = 'Copy link to current line' })
vim.keymap.set('v', '<leader>ho', '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', { desc = 'Copy link to current line' })