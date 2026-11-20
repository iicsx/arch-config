return {
  "uga-rosa/ccc.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local ccc = require("ccc")
    -- local mapping = ccc.mapping

    ccc.setup({
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    })
  end,
}
