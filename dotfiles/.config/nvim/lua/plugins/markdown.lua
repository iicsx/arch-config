return {
  "MeanderingProgrammer/markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require('render-markdown').setup({
      bullet = {
        right_pad = 1
      }
    })
  end,
}
