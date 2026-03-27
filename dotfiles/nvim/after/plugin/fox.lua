require("fox").setup({
  context = {
    enable = true,
    border = "rounded"
  },
})

vim.api.nvim_set_keymap('v', '<leader>cf', ":FoxOpen<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cs', ":FoxSticky<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cc', ":FoxClose<CR>", { noremap = true, silent = true })
