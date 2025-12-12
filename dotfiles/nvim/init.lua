local function module_exists(name)
  local ok, _ = pcall(require, name)

  return ok
end

require("set")
require("lsp")
require("remap")

WITH_CATS = module_exists("nixCats")
if not WITH_CATS then
  require("lze")
end

local theme_index = 3
local themes = {
  "poimandres",
  "NeoSolarized",
  "oh-lucy",
  "sonokai",
  "tokyonight",
}

DEFAULT_COLOR = themes[theme_index]
DEFAULT_BAR_COLOR = "none"

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
  },
})

function CC(index)
  if index <= 0 or index > #themes then
    return vim.notify("Could not change theme, index out of range. Current theme: " .. themes[theme_index])
  end

  SC(themes[index])

  local theme = themes[index]

  vim.notify("Changed color scheme to " .. theme)
  theme_index = index
end

vim.cmd("TransparentEnable")

SC()
