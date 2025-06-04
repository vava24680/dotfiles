local keymap = vim.keymap
local default_options = {
  silent = true,
  noremap = true, -- Disable recursive mapping.
}

-- 1. Window moving related bindings.
keymap.set('n', '<C-w><Left>', ':wincmd h<CR>', default_options)
keymap.set('n', '<C-w><Down>', ':wincmd j<CR>', default_options)
keymap.set('n', '<C-w><Up>', ':wincmd k<CR>', default_options)
keymap.set('n', '<C-w><Right>', ':wincmd l<CR>', default_options)

-- 2. Tab related bindings.
keymap.set('n', 'tn', ':tabnext<CR>', default_options)
keymap.set('n', 'tp', ':tabprevious<CR>', default_options)
keymap.set('n', 'tN', ':tabnew<CR>', default_options)
keymap.set('n', 'tc', ':tabclose<CR>', default_options)
keymap.set('n', 'tf', ':tabfirst<CR>', default_options)
keymap.set('n', 'tl', ':tablast<CR>', default_options)

-- 3. Window split related bindings.
keymap.set('n', 'sh', ':split<CR>', default_options)
keymap.set('n', 'sv', ':vsplit<CR>', default_options)

-- 4. Editing And Reloading Configurations File Bindings.
if vim.env.MYVIMRC ~= nil then
  vim.cmd(
    string.format(
      'nnoremap <leader>ev <ESC>:tabedit %s<CR> :echo "After editing, press \',sv\' to reload"<CR>',
      vim.env.MYVIMRC
    )
  )
  vim.cmd(
    string.format(
      'nnoremap <leader>sv <ESC>:source %s<CR>',
      vim.env.MYVIMRC
    )
  )
end

-- 5. Enable/Disable editing keymap bindings.
-- Enable editing.
keymap.set(
  'n',
  '<leader>ee',
  function()
    vim.bo.modifiable = true
  end,
  default_options
)
-- Disable Editing.
keymap.set(
  'n',
  '<leader>de',
  function()
    vim.bo.modifiable = false
  end,
  default_options
)

-- 6. Toggle showing relative line number keymap binding.
keymap.set(
  'n',
  '<leader>rn',
  function()
    vim.wo.relativenumber = not vim.wo.relativenumber
  end,
  default_options
)
