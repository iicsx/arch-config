return {
  "epwalsh/obsidian.nvim",
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "default",
          path = "~/source/notes"
        }
      }
    })
  end,
}
