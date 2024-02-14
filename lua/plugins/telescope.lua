return {
  "nvim-telescope/telescope.nvim",
  branch = '0.1.x',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        layout_strategy = "vertical",
        layout_config = {},
        mappings = {
          n = {
            ["<C-c>"] = "close",
            ["<esc>"] = {
              actions.close,
              type = "action",
              opts = { silent = true, nowait = true }
            },
          },
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        buffers = {
          mappings = {
            n = {
              ["<C-x>"] = actions.delete_buffer,
              ["<C-s>"] = actions.select_horizontal,
            },
            i = {
              ["<C-x>"] = actions.delete_buffer,
              ["<C-s>"] = actions.select_horizontal,
            }
          }
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end,

  opts = {
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  },
}
