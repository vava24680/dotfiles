local file_explorer_plugin_spec = nil
local utils = require('configs.utils')

if vim.fn.has('nvim-0.9.0') == 1 then
  local function wrap_function(func, ...)
    -- Reference: https://www.reddit.com/r/neovim/comments/sjiwox/question_give_arguments_to_vimkeymapsets_function/
    local args = {...}
    return function()
      func(unpack(args))
    end
  end

  file_explorer_plugin_spec = utils.construct_plugin_default_spec(
    'nvim-tree/nvim-tree.lua',
    {
      version = '*',
      lazy = false,
      opts = {
        disable_netrw = true,
        hijack_netrw = true,
        sort_by = 'case_sensitive',
        modified = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
        },
        filters = {
          custom = {
            [[\.pyc$]],
            '__pycache__',
          },
          exclude = {},
        },
        renderer = {
          group_empty = true,
          add_trailing = true,
          icons = {
            git_placement = 'before',
            modified_placement = 'before',
            webdev_colors = false,
            symlink_arrow = ' -> ',
            show = {
              file = false,
              folder = false,
              folder_arrow = true,
              git = true,
              modified = true,
            },
            glyphs = {
              folder = {
                arrow_closed = '▸',
                arrow_open = '▾',
              },
              symlink = '[L]',
              modified = '[+]',
              git = {
                unstaged = "X",
                staged = "O",
                unmerged = "^",
                renamed = "[GR]",
                untracked = "?",
                deleted = "[GD]",
                ignored = "[GI]",
              },
            },
          },
        },
      },
      config = function(_, opts)
        local nvimtree = require('nvim-tree')
        local api = require("nvim-tree.api")

        vim.keymap.set('n', '<F6>', api.tree.toggle)

        function set_custom_key_binding(buffer_number)
          local function ops_nowait(desc)
            return {
              desc = "nvim-tree: " .. desc,
              buffer = buffer_number,
              noremap = true,
              silent = true,
              nowait = true,
            }
          end

          local function ops_wait(desc)
            return {
              desc = "nvim-tree: " .. desc,
              buffer = buffer_number,
              noremap = true,
              silent = true,
              nowait = false,
            }
          end

          -- Apply default mappings
          api.config.mappings.default_on_attach(buffer_number)

          -- Custom mappings
          vim.keymap.set(
          'n',
          '<C-t>',
          api.tree.change_root_to_parent,
          ops_nowait('Up')
          )
          vim.keymap.set(
          'n',
          '?',
          api.tree.toggle_help,
          ops_nowait('Help')
          )
          vim.keymap.set(
          'n',
          'i',
          api.node.open.horizontal,
          ops_nowait('Open Horizontal split')
          )
          vim.keymap.set(
          'n',
          '<C-]>',
          api.tree.change_root_to_node,
          ops_nowait('Change root to current directory')
          )
          vim.keymap.set(
          'n',
          't',
          api.node.open.tab,
          ops_wait('Open in new tab')
          )
          vim.keymap.set(
          'n',
          'T',
          wrap_function(api.node.open.tab, nil, {focus=false}),
          ops_nowait('Open in new tab silently')
          )
        end

        opts.on_attach = set_custom_key_binding
        nvimtree.setup(opts)
      end,
    }
  )
else
  local keymap = vim.keymap
  local default_options = {
    silent = true,
    noremap = true,
  }

  file_explorer_plugin_spec = utils.construct_plugin_default_spec(
    'preservim/nerdtree',
    {
      init = function()
        -- Delete the buffer of the file which is just deleted with NERDTree.
        vim.g.NERDTreeAutoDeleteBuffer  = 1

        -- Enable sorting bookmarks list in case-sensitive order
        vim.g.NERDTreeBookmarksSort     = 2

        -- Enable case-sensitive filenames sorting in NERDTree explorer.
        vim.g.NERDTreeCaseSensitiveSort = 1

        -- Make NERDTree filter out some temporary files.
        vim.g.NERDTreeIgnore            = '[\'\\.swp$\', \'\\.pyc$\', \'__pycache__\']'

        -- Enable natural sorting order.
        vim.g.NERDTreeNaturalSort       = 1

        -- Enable showing bookmarks.
        vim.g.NERDTreeShowBookmarks     = 1

        -- Show hidden files by default.
        vim.g.NERDTreeShowHidden        = 1

        -- Enable showing line numbers in NERDTree explorer.
        vim.g.NERDTreeShowLineNumbers   = 1

        -- Set the NERDTree window size.
        vim.g.NERDTreeWinSize           = 33
      end,
      config = function()
        keymap.set('', '<F6>', ':NERDTreeToggle<CR>', default_options)
        keymap.set('', '<leader>ntf', ':NERDTreeFind<CR>', default_options)
        -- keymap.set(
        --   '',
        --   '<leader>ntv',
        --   ':NERDTreeToggleVCS<CR>:wincmd p<CR>:NERDTreeFind<CR>',
        --   default_options
        -- )
        keymap.set('', '<leader>ntc', ':NERDTreeClose<CR>', default_options)
      end,
    }
  )
end

return file_explorer_plugin_spec
