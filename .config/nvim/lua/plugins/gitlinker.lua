-- gitlinker.nvim
-- https://github.com/ruifm/gitlinker.nvim

vim.pack.add {
  'https://github.com/ruifm/gitlinker.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
}

require('gitlinker').setup {
  mappings = '<leader>ho',
  opts = {
    action_callback = require('gitlinker.actions').open_in_browser,
  },
}

vim.keymap.del('n', '<leader>ho')
vim.keymap.del('v', '<leader>ho')

vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('gitlinker-keymaps', { clear = true }),
  pattern = 'GitSignsUpdate',
  callback = function(event)
    if type(event.data) ~= 'table' or type(event.data.buffer) ~= 'number' then
      return
    end
    local bufnr = event.data.buffer
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end
    if vim.b[bufnr].gitsigns_head == nil then
      return
    end

    vim.keymap.set('n', '<leader>ho', function()
      require('gitlinker').get_buf_range_url('n')
    end, { desc = 'git [o]pen line in browser', buffer = bufnr })
    vim.keymap.set('v', '<leader>ho', function()
      require('gitlinker').get_buf_range_url('v')
    end, { desc = 'git [o]pen selection in browser', buffer = bufnr })
  end,
})
