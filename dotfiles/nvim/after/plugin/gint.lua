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
