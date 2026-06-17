local highligh_utils = require('configs.highlight.utils')
local utils = require('configs.utils')

return utils.construct_plugin_default_spec(
  'hiphish/rainbow-delimiters.nvim',
  {
    tag = 'v0.12.0',
    enabled = function()
      -- Only install and enable this plugin if neovim has stable
      -- treesitter support.
      return 1 == vim.fn.has('nvim-0.9.0')
    end
  }
)

