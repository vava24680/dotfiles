local utils = require('configs.utils')
local colorscheme_plugin_spec = nil

if vim.fn.has('nvim-0.8.0') == 1 then
  colorscheme_plugin_spec = utils.construct_plugin_default_spec(
    'ellisonleao/gruvbox.nvim',
    {
      priority = 1000,
      config = true,
      opts = {
        -- Disable italic in highlight.
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false,
        },
      },
    }
  )
else
  colorscheme_plugin_spec = utils.construct_plugin_default_spec(
    'morhetz/gruvbox',
    {
      priority = 1000,
    }
  )
end

return colorscheme_plugin_spec
