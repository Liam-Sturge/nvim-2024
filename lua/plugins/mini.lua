return {
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.indentscope",
    opts = {},
  },
  {
    "echasnovski/mini.statusline",
  },
  {
    "echasnovski/mini.surround",
    config = function()
      require('mini.surround').setup()
    end,
    version = "*",
    event = "VeryLazy",
  },
  {
    "echasnovski/mini.trailspace",
    opts = {},
  },
  {
    'echasnovski/mini.files',
    name = "mini.files",
    branch = "main",
    version = false,
    config = function()
      require('mini.files').setup()
    end,
    opts = {
      use_as_default_explorer = true,
    },
  },
}
