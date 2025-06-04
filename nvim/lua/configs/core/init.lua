-- 1. Global Settings {{{1
vim.g.scriptencoding='utf-8'
vim.g.mapleader=','

-- Disable netrw function as recommended by nvim-tree.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- }}}

-- 2. General Settings {{{1
-- 2.1 Editing {{{2
vim.go.confirm=true
-- }}}

-- 2.2 Colors {{{2
-- Enable 24-bit RGB color support.
vim.go.termguicolors = true
-- }}}

-- 2.3 Display {{{2
vim.cmd('syntax enable')

-- Show line number.
vim.wo.number = true

-- Show invisible characters including the following three:
-- 1. Tab
-- 2. Trailing space
-- 3. Non-breakable space
vim.wo.list = true

-- Set other visible characters for some invisible characters.
vim.go.listchars = 'eol:¬,tab:¤·,trail:·'

-- Highlight current line.
vim.wo.cursorline = true

-- Change cursor shape to block.
vim.go.guicursor = 'a:block'
-- }}}

-- 2.4 Search {{{2
-- Enable highlight search.
vim.go.hlsearch = true

-- Ignore case in searching.
vim.go.ignorecase = true

-- Enable incremental searching.
vim.go.incsearch = true

-- Enable case-insensitive searching when search pattern are all lowercase,
-- case-sensitive otherwise.
vim.go.smartcase = true

-- Enable searching with regex.
vim.go.magic = true
-- }}}

-- 2.5 Status line {{{2
-- Make status line always show.
vim.go.laststatus = 2
-- }}}

-- 2.6 Windows, Tabs, Buffers {{{2
-- Make the new vertically splited window put to the right of the current window.
vim.go.splitright = true

-- Make the new horizontally splited window put under the current window.
vim.go.splitbelow = true

-- Always show tab navigation bar.
vim.go.showtabline = 2
-- }}}

-- 2.7 Indentation {{{2
-- Copy the indentation of the current line to next inserted line.
vim.bo.autoindent = true

-- Do smart autoindenting when starting a new line.
vim.bo.smartindent = true
-- }}}

-- 2.8 Files {{{2
-- Auto reload the file when it is changed outside.
vim.go.autoread = true

-- Enable filetype detection.
vim.cmd('filetype on')

-- Enable filetype-specific indenting.
vim.cmd('filetype indent on')

-- Enable filetype-specific plugins load.
vim.cmd('filetype plugin on')
-- }}}

-- 2.9 User interfaces {{{2
-- Enable the use of mouse.
vim.go.mouse = 'a'

-- Keep 8 lines above (below) the cursor when scrolling up (down).
vim.go.scrolloff = 8

-- Enable breaking long lines to multiple lines.
vim.wo.wrap = true

-- Make vim break lines without breaking words.
vim.wo.linebreak = true

-- Make vim show '->' where the lines are wrapped.
vim.go.showbreak = '->'
-- }}}

-- 2.10 Warnings {{{2
-- Disable bell for error messages.
vim.go.errorbells = false

-- Disable visual bells for error messages.
vim.go.visualbell = false
-- }}}

-- 2.11 Tabs {{{2
-- In my tab and space configuratiob, I do not modify default tabstop configuration
-- as recommended in manual.
-- I will set expandtab, shiftwidth and softtabstop.

-- Make vim insert appropriate number of spaces when <Tab> is inserted
-- in "insert" mode.
vim.go.expandtab = true

-- Make vim insert 2 space characters for each of (auto) indent operation like
-- >>, << or cindent.
vim.go.shiftwidth = 4

-- Softtabstop controls how many tab characters and space characters
-- that vim inserts when <Tab> is inserted in "insert" mode.
-- As expandtab feature is on, it contronls how many space characters
-- that vim inserts when <Tab> is inserted in "insert" mode.
-- For current configuration, set to negative value means its value
-- will be as same as the "shiftwidth" option, which means as same as
-- the indentation configuration.
vim.go.softtabstop = -1

vim.go.smarttab = true
-- }}}
-- }}}

-- 3. Custom highlight commands. {{{1
require('configs.highlight.highlight')
-- }}}

-- 4. Plugins {{{1
require('configs.core.lazy')
-- }}}

-- 5. Key Bindings {{{1
require('configs.core.keymap')
-- }}}

-- 6. Language Server Protocol (LSP) Configurations {{{1
-- require('configs.lsp.config')
-- }}}

-- 7. Diagnostic {{{1
-- require('configs.core.diagnostic')
-- }}}

-- 8. Filetype related Configurations {{{1
-- require('configs.filetype.lua')
-- }}}

-- 9. Change colorscheme {{{1
vim.cmd('colorscheme gruvbox')
-- }}}
