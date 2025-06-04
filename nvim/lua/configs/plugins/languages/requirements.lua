local utils = require('configs.utils')

return utils.construct_plugin_default_spec(
  'raimon49/requirements.txt.vim',
  {
    enabled = function()
      return vim.fn.has('patch-9.1.0326') == 0
    end,
    -- Disable lazy loading first due to some errors.
    -- ft = 'requirements',
  }
)
