local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

local wk = require("which-key")
wk.register(mappings, opts)

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes Key
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- ============================================================================
-- = Normal                                                                   =
-- ============================================================================

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Easy close buffer & quit with confirmation to save
keymap("n", "<Leader>q", ":confirm bd<CR>", opts)
keymap("n", "<Leader>Q", ":confirm qa<CR>", opts)

-- Restore clear screen function because above overwrites it
keymap("n", "<esc><esc>", ":mode<CR>:noh<CR>:diffupdate<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -3<CR>", opts)
keymap("n", "<C-Down>", ":resize +3<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -3<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +3<CR>", opts)

-- Easy start/end of line navigation
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)
keymap("v", "H", "^", opts)
keymap("v", "L", "$", opts)
keymap("x", "H", "^", opts)
keymap("x", "L", "$", opts)
keymap("o", "H", "^", opts)
keymap("o", "L", "$", opts)

-- Move text up and down
keymap("n", "<A-j>", "<cmd>m .+1<CR>", opts)
keymap("n", "<A-k>", "<cmd>m .-2<CR>", opts)

-- Page u/d f/b with cursor anchored to middle of screen. Overrides default
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-f>", "<C-f>zz", opts)
keymap("n", "<C-b>", "<C-b>zz", opts)

-- Search with cursor anchored to middle of screen. Overrides default
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Change next search match using g. then subsequently .
keymap("n", "g.", "zzcgn<C-A><ESC>", opts)

-- Quickly list / change buffers
keymap("n", "<leader>l", "<cmd>ls<cr>:b ", opts)

-- yank and put stuff
keymap("n", "<C-y>", "<cmd>%y<CR>", opts) -- yank all
keymap("n", "gp", "`[v`]", opts) -- reselect pasted text

-- ============================================================================
-- = Terminal
-- ============================================================================

keymap("t", "<Esc>", "<C-\\><C-n>", opts) -- Enter norm mode in terminal

-- =============================================================================
-- = Visual                                                                    =
-- =============================================================================

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "p", '"_dP', opts)
keymap("v", "<A-j>", "<cmd>m .+1<CR>", opts)
keymap("v", "<A-k>", "<cmd>m .-2<CR>", opts)

-- =============================================================================
-- = Visual Block                                                              =
-- =============================================================================

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Diagnostic keymaps
-- keymap('n', '[d', vim.diagnostic.goto_prev, opts)
-- keymap('n', ']d', vim.diagnostic.goto_next, opts)
-- keymap('n', '<leader>E', vim.diagnostic.open_float, opts)
-- keymap('n', '<leader>q', vim.diagnostic.setloclist, opts)

wk.register({
-- -- =============================================================================
-- -- = Leader Keymaps                                                            =
-- -- =============================================================================

  -- Search misc.
  ['<space>'] = { require('telescope.builtin').buffers, "[ ] Find existing buffers" },
  ['?'] = {require('telescope.builtin').oldfiles, "[?] Find recently opened files"},
  ['/'] = {
    function()
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, })
    end, "[/] Fuzzily search in current buffer]" },

  e = {
    function()
      if (vim.bo.buftype == "nofile") then
        require('mini.files').close()
      else
        require('mini.files').open()
      end
    end, "[E]xplore"
  },

   -- Find stuff using Telescope
  f = {
    name = "+find",
    f = { require('telescope.builtin').find_files, "[F]ind [F]iles" },
    h = { require('telescope.builtin').help_tags, "[F]ind [H]elp" },
    w = { require('telescope.builtin').grep_string, "[F]ind current [W]ord" },
    g = { require('telescope.builtin').live_grep, "[F]ind by [G]rep" },
    d = { require('telescope.builtin').diagnostics, "[F]ind [D]iagnostics" },
  },

   -- Git (Fugitive)
  g = {
    name = "+git",
    s = { "<cmd>G<CR>", "[G]it [S]tatus" },
    vs = { "<cmd>vert G<CR>", "[G]it [S]tatus" },
  },

  c = {
    name = "+quickfix",
    c = { "<cmd>cclose<CR>", "quickfix [C]lose" },
    o = { "<cmd>copen<CR>", "quickfix [O]pen" },
    n = { "<cmd>cn<CR>", "quickfix [N]ext" },
    p = { "<cmd>cp<CR>", "quickfix [P]revious" },
  },

   -- Call up Telescope menu
   t = { "<cmd>Telescope<cr>", "[T]elescope" },
}, { prefix = "<leader>" })
