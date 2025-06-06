local autocmd = vim.api.nvim_create_autocmd
local const = require('configs.highlight.const')
local M = {}

function M.add_custom_highlight_command_as_autocmd(highlight_command)
  vim.cmd(highlight_command)

  autocmd('ColorScheme', {
    group = const.highlight_autocmds_group_name,
    callback = function()
      vim.cmd(highlight_command)
    end,
  })
end

return M
