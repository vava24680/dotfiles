local highlight_utils = require('configs.highlight.utils')
local utils = require('configs.utils')

return utils.construct_plugin_default_spec(
  'dyng/ctrlsf.vim',
  {
    init = function()
      vim.g.ctrlsf_auto_focus = {
        at = 'done',
      }

      -- Make search result quickfix window use 20% height of current vim window.
      vim.g.ctrlsf_compact_winsize = '20%'

      -- Make search result present in quickfix window.
      vim.g.ctrlsf_default_view_mode = 'compact'

      -- Make line number shown in result window.
      vim.cmd([[
        function! g:CtrlSFAfterMainWindowInit()
          setlocal number
        endfunction
      ]])

      -- Link match result highlight group to "Search" highlight group.
      highlight_utils.add_custom_highlight_command_as_autocmd(
        'highlight link ctrlsfMatch Search'
      )
    end,
  }
)
