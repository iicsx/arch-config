local builtin = require('telescope.builtin')

require("telescope").setup({
  extensions = {
    fzf = {}
  }
})

require("telescope").load_extension("fzf")

--vim.keymap.set('n', '<leader>fa', builtin.find_files, {})

vim.keymap.set('n', '<leader>fa', function()
  builtin.find_files({
    shorten_path = true,
    cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:gs?\\?/?'),
    path_display = { 'truncate' }
  })
end)

vim.keymap.set('n', '<leader>ft', builtin.git_files, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fd', function()
  builtin.find_files({
    cwd = vim.fn.stdpath("config")
  })
end)
