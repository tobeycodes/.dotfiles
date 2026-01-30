-- copilot.lua
-- https://github.com/zbirenbaum/copilot.lua

vim.pack.add { 'https://github.com/zbirenbaum/copilot.lua' }

require('copilot').setup {
  suggestion = {
    auto_trigger = true,
    copilot_model = 'claude-sonnet-4.5',
  },
}