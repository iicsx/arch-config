local git = require("gitsigns")

git.setup({
  signs = {
    add          = { text = '¦' },
    change       = { text = '|' },
    delete       = { text = '󰔳' },
    topdelete    = { text = '󰔵' },
    changedelete = { text = '~' },
    untracked    = { text = '»' },
  },
  signs_staged = {
    add          = { text = '¦' },
    change       = { text = '|' },
    delete       = { text = '󰔳' },
    topdelete    = { text = '󰔵' },
    changedelete = { text = '~' },
    untracked    = { text = '»' },
  },
})

vim.keymap.set("n", "<leader>gr", function() git.reset_hunk() end)
vim.keymap.set("n", "<leader>gi", function() git.stage_hunk() end)
vim.keymap.set("n", "<leader>gb", function() git.toggle_current_line_blame() end)
vim.keymap.set("n", "<leader>gd", function() git.diffthis() end)
