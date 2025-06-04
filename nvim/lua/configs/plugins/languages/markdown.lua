local utils = require('configs.utils')

return utils.construct_plugin_default_spec(
  'plasticboy/vim-markdown',
  {
    lazy = true,
    ft = 'markdown',
  }
)
