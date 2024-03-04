return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    -- Because Null_ls relies on external tools, some commands
    -- provided by Null_ls only apply to files saved to disk!

    null_ls.setup({
      sources = {
        formatting.black,
        formatting.isort,
        formatting.jq,
      }
    })
  end,
}
