return {
  "iicsx/gint-nvim",
  dependencies = {
    "tpope/vim-fugitive",
  },
  config = function()
    require("gint").setup({
      default = {
        border = "rounded"
      },
      status = {
        enable = true,
      },
      commit = {
        enable = true
      }
    })

    vim.keymap.set("n", "<leader>gs", ":GintStatus<CR>", {})
    vim.keymap.set("n", "<leader>gc", ":GintCommit<CR>", {})
  end,
}
