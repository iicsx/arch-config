require("oil").setup({
  view_options = {
    show_hidden = true,
    natural_order = true,
  },
  float = {
    padding = 3,
    border = "rounded",
  },
  confirmation = {
    padding = 3,
    border = "rounded",
  },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "_", "<CMD>:Oil --float<CR>", { desc = "Open parent directory in floating window" })
