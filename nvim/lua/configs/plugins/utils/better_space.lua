local utils = require('configs.utils')

return utils.construct_plugin_default_spec(
  'ntpeters/vim-better-whitespace',
  {
    init = function()
      -- Disable auto stripping trailing spaces on file saving.
      vim.g['strip_whitespace_on_save'] = 0
    end
  }
)
