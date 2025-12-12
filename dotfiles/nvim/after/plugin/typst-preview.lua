local CURRENT_SCHEME = "never"

local function run_setup()
  require('typst-preview').setup({
    invert_colors = CURRENT_SCHEME,
    port = 45443 -- required to allow updating documents in-place
  })
end

local function restart_typst()
  vim.cmd("TypstPreviewStop")
  vim.cmd("TypstPreview")
end


local function toggle_typst()
  if CURRENT_SCHEME == "always" then
    CURRENT_SCHEME = "never"
    vim.notify("Set Typst Preview to 'light'")
  else
    CURRENT_SCHEME = "always"
    vim.notify("Set Typst Preview to 'dark'")
  end

  run_setup()
  restart_typst()
end

vim.keymap.set("n", "<leader>lt", toggle_typst, { noremap = true })
vim.keymap.set("n", "<leader>p", restart_typst, { noremap = true })

run_setup()
