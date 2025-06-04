local utils = require('configs.utils')
local auto_pairs_plugin_spec = nil

if vim.fn.has('nvim-0.7.0') == 1 then
  auto_pairs_plugin_spec = utils.construct_plugin_default_spec(
    'windwp/nvim-autopairs',
    {
      event = "InsertEnter",
      config = true,
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    }
  )
else
  auto_pairs_plugin_spec = utils.construct_plugin_default_spec(
    'Raimondi/delimitMate'
  )
end

return auto_pairs_plugin_spec
