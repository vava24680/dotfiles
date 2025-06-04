local utils = require('configs.utils')

return utils.construct_plugin_default_spec(
  'lukas-reineke/indent-blankline.nvim',
  {
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = function ()
      local hooks = require('ibl.hooks')

      options = {
        indent = {
          char = {
            '|',
            '¦'
          },
        },
      }

      -- Use hook to disable first indent level.
      -- In v2, it can be disabled by the option 'show_first_indent_level'.
      -- Referece: https://github.com/lukas-reineke/indent-blankline.nvim/issues/777
      hooks.register(
      hooks.type.WHITESPACE,
      hooks.builtin.hide_first_space_indent_level
      )

      return options
    end,
  }
)
