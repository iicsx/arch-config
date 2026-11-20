return {
  "mbbill/undotree",
  cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeHide", "UndotreeFocus" },
  keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undo tree" } },
  config = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
  end,
}
