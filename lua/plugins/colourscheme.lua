return {
  -- Main / Default colourscheme
  { "echasnovski/mini.base16",
    name = "mini.base16",
    lazy = false,
    version = "*",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme base16-kanagawa]])
    end,
  },
}
