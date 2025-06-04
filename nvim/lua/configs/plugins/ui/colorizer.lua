local utils = require('configs.utils')

return utils.construct_plugin_default_spec(
  'norcalli/nvim-colorizer.lua',
  {
    config = function()
      require('colorizer').setup()
    end,
  }
)
