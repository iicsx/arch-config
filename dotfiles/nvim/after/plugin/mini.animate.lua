require("mini.animate").setup({
  scroll = { 
    enable = true,
    timing = function(t) return t / 3 end,
  },

  cursor = { enable = false },
  open = { enable = false },
  close = { enable = false },
  resize = { enable = false },
})
