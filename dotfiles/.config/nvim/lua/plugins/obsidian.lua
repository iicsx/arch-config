return {
  "epwalsh/obsidian.nvim",
  ft = { "markdown" },
  cmd = { "ObsidianOpen", "ObsidianNew", "ObsidianQuickSwitch", "ObsidianSearch" },
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
