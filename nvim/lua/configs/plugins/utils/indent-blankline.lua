local utils = require('configs.utils')
local indent_line_plugin_spec = nil

if vim.fn.has('nvim-0.8.0') == 1 then
  indent_line_plugin_spec = utils.construct_plugin_default_spec(
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
      enabled = function()
        return vim.fn.has('nvim-0.9.0') == 1
      end,
    }
  )
else
  indent_line_plugin_spec = utils.construct_plugin_default_spec(
    'Yggdroot/indentLine',
    {
      init = function()
        vim.g.indentLine_enabled        = 1
        vim.g.indentLine_setColors      = 1
        vim.g.indentLine_color_term     = 242
        vim.g.indentLine_color_gui      = '#6c6c6c'
        vim.g.indentLine_char_list      = {'|', '¦'}
        vim.g.indentLine_bufTypeExclude = {
          'help',
          'terminal',
          'quickfix',
        }
      end,
    }
  )
end

return indent_line_plugin_spec
