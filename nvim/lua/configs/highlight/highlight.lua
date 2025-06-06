local augroup = vim.api.nvim_create_augroup
local const = require('configs.highlight.const')
local utils = require('configs.highlight.utils')

-- 1. Create auto command group for custom highlight commands first. {{{1
augroup(const.highlight_autocmds_group_name, {clear = true})
-- }}}

-- 2. Add custom highlight commnand. {{{1
-- Highlight current line. {{{2
utils.add_custom_highlight_command_as_autocmd(
  'highlight Cursorline cterm=bold ctermbg=237 gui=bold guibg=#444444'
)
-- }}}

-- Highlight line numbers. {{{2
utils.add_custom_highlight_command_as_autocmd(
  'highlight LineNr ctermfg=LightGrey guifg=#B8B8B8'
)
-- }}}

-- Highlight current line number. {{{2
utils.add_custom_highlight_command_as_autocmd(
  table.concat(
    {
      'highlight CursorLineNr ',
      'cterm=bold,italic ctermbg=White ctermfg=Blue ',
      'gui=bold,italic guibg=White guifg=Blue',
    },
    ' '
  )
)
-- }}}

-- Highlight eol, extends and precedes these thress invisible characters. {{{2
utils.add_custom_highlight_command_as_autocmd(
  'highlight NonText cterm=bold ctermfg=244 gui=bold guifg=#3886B0'
)
-- }}}

-- Highlight nbsp, space, tab, multispace, lead and trail these characters. {{{2
utils.add_custom_highlight_command_as_autocmd(
  'highlight Whitespace ctermfg=LightGrey guifg=#909090'
)
-- }}}

-- Link group 'SpecialKey' to group 'NonText'. {{{2
utils.add_custom_highlight_command_as_autocmd(
  'highlight! link SpecialKey NonText'
)
-- }}}
-- }}}
