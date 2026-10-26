return {
  "MeanderingProgrammer/markdown.nvim",
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
