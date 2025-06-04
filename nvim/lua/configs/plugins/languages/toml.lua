local utils = require('configs.utils')

return utils.construct_plugin_default_spec(
  'cespare/vim-toml',
  {
    enabled = function()
      return vim.fn.has('nvim-0.6.0') == 0
    end,
  }
)
