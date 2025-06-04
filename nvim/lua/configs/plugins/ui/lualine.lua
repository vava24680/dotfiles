local highlight_utils = require('configs.highlight.utils')
local utils = require('configs.utils')

local function column_information_component()
  return 'Col: %-v'
end

local filename_component = {
  -- File name componenet. It is provided by lualine.
  'filename',
  symbols = {
    readonly = '[RO]',
  },
}

local line_number_informationn_component = '%3p%% %l/%L'

local no_end_of_line_component = {
  -- No end of line sign component.
  function()
    return '[noeol]'
  end,
  cond = function()
    return not vim.bo.eol
  end,
  draw_empty = false,
}

local paste_mode_component = {
  function()
    return 'PASTE'
  end,
  cond = function()
    return vim.go.paste
  end,
  draw_empty = false,
}

local readonly_sign_component = {
  -- Readonly sign component
  '%R',
  cond = function()
    return vim.bo.readonly
  end,
  draw_empty = false,
}

local file_explorer_extension = {
  sections = {
    lualine_a = {
      'mode',
      paste_mode_component,
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      line_number_informationn_component,
    },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {
      'mode',
      paste_mode_component,
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      'filetype',
    },
  },
  filetypes = {
    'nerdtree',
    'NvimTree',
  }
}

local tags_explorer_extension = {
  sections = {
    lualine_a = {
      'mode',
      paste_mode_component,
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      line_number_informationn_component,
    },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {
      'mode',
      paste_mode_component,
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      'filetype',
    },
  },
  filetypes = {
    'vista',
    'tagbar',
  }
}

local search_result_explorer_extension = {
  sections = {
    lualine_a = {
      'mode',
      paste_mode_component,
    },
    lualine_b = {
      'FugitiveHead',
      'filetype',
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      line_number_informationn_component,
    },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {
      'mode',
      paste_mode_component,
    },
    lualine_b = {
      'filetype',
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  filetypes = {
    'ctrlsf',
  }
}

return utils.construct_plugin_default_spec(
  'nvim-lualine/lualine.nvim',
  {
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = false,
          theme = 'onedark',
          always_show_tabline = true,
          component_separators = {
            left = '|',
            right = '|',
          },
          section_separators = {
            left = '',
            right = '',
          },
        },
        sections = {
          lualine_a = {
            'mode',
            paste_mode_component,
          },
          lualine_b = {
            'FugitiveHead',
            readonly_sign_component,
            filename_component,
            no_end_of_line_component,
          },
          lualine_c = {
          },
          lualine_x = {
            'filetype',
            'encoding',
            'fileformat',
          },
          lualine_y = {
            line_number_informationn_component,
          },
          lualine_z = {
            column_information_component,
          },
        },
        inactive_sections = {
          lualine_a = {
            'mode',
            filename_component,
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {
            'filetype',
            'encoding',
            'fileformat',
          },
          lualine_y = {
            '%3p%% %l/%L',
          },
          lualine_z = {
            column_information_component,
          },
        },
        tabline = {
          lualine_a = {
            {
              -- Tab componenet. It is provided by lualine.
              'tabs',
              mode = 2,
              tab_max_length = 60,
              max_length = function()
                return vim.go.columns / 2
              end,
              show_modified_status = true,
              symbols = {
                modified = '[+]',
              },
              fmt = function(name, context)
                -- Show + if buffer is modified in tab
                local buffer_list = vim.fn.tabpagebuflist(context.tabnr)
                local window_number = vim.fn.tabpagewinnr(context.tabnr)
                local buffer_number = buffer_list[window_number]
                local modified = vim.bo[buffer_number].modified
                local modifiable = vim.bo[buffer_number].modifiable

                if modified then
                  name = name .. ' [+]'
                end

                if not modifiable then
                  name = name .. ' [RO]'
                end

                return name
              end,
              tabs_color = {
                active = 'lualine_tabline_a_active',
                inactive = 'lualine_tabline_a_inactive',
              }
            }
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        extensions = {
          file_explorer_extension,
          tags_explorer_extension,
          search_result_explorer_extension,
        },
      })

      highlight_utils.add_custom_highlight_command_as_autocmd(
        table.concat({
          'highlight lualine_tabline_a_active ',
          'cterm=bold ctermfg=Black ctermbg=LightMagenta ',
          'gui=bold guifg=Black guibg=LightMagenta'
        })
      )
      highlight_utils.add_custom_highlight_command_as_autocmd(
        table.concat({
          'highlight lualine_tabline_a_inactive ',
          'cterm=bold ctermfg=252 ctermbg=235',
          'gui=bold guifg=#D9D9D9 guibg=#263238'
        })
      )
    end,
  }
)
