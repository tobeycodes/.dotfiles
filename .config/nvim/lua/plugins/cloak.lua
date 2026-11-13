-- cloak.nvim
-- https://github.com/laytan/cloak.nvim

vim.pack.add { 'https://github.com/laytan/cloak.nvim' }

require('cloak').setup {
  patterns = {
    { file_pattern = '.env*', cloak_pattern = '=.+' },
    {
      file_pattern = 'secrets.fish',
      cloak_pattern = '(set%s+%-%a+%s+[%w_]+%s+).+',
      replace = '%1',
    },
  },
}
