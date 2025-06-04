local tag_explorer_plugin_spec = nil
local utils = require('configs.utils')

if vim.fn.has('patch-8.0.27') == 1 then
  tag_explorer_plugin_spec = utils.construct_plugin_default_spec(
    'liuchengxu/vista.vim',
    {
      init = function()
        -- Disable icons rendering.
        vim.g['vista#renderer#enable_icon'] = 0
        vim.g['vista_sidebar_width'] = 40
      end,
    }
  )
else
  tag_explorer_plugin_spec = utils.construct_plugin_default_spec(
    'preservim/tagbar'
  )
end

return tag_explorer_plugin_spec
