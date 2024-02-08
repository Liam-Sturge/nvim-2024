-- handy settings for keymapping to allow custom functions to be bound to shortcuts
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Use python to format xml documents
vim.cmd("com! FormatXML :%!python3 -c 'import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())'")

-- Use python to format JSON documents
vim.cmd("com! FormatJSON :%!python3 -m json.tool")

-- Create a new scratch pad file
vim.api.nvim_create_user_command(
  'Scratch',
  function()
    print("Creating Scratch file...")
    vim.api.nvim_exec(
      [[
      e [Scratch]
      setlocal buftype=nofile
      setlocal bufhidden=hide
      setlocal noswapfile
      ]], out)
  end,
  { nargs = 0 }
)
-- Quick call the create scratch pad function
keymap("n", "<C-s>", "<cmd>Scratch<CR>", opts)

-- FixCommand Tidy up
-- steps:
--   1. remove blanks between flags
--   2. attempt to split lines where more than two args are provided
--   3. insert trailing backslash
--   4. remove trailing blanks
--   5. prepend a tab for lines 2 onwards
--   6. hide replacement highliting
--   7. insert a shebang to keep shellcheck happy
--   8. fix indentation around the paragraph
vim.api.nvim_create_user_command(
  'FixCommand',
  function()
    vim.api.nvim_exec(
      [[
      substitute/\s-/\r-/ge
      substitute/\(\s*.*\) \(.*\)/\1\r\2/e
      0,$-1 normal A \
      %substitute/\s*\\$/ \\/e
      2,$ substitute/^/\t/e
      noh
      1 normal O#!/usr/bin/bash
      normal =ap
      ]], out)
    print("Command cleaned up!")
  end,
  { nargs = 0 }
)
