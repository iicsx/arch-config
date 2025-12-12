vim.g.barbar_auto_setup = false -- disable auto-setup

local easter_egg_icons = { '󰄛 ', '󰚾 ', '󱄅 ' }

local icons = { '󱓉 ', '󰐙 ', '󰀚 ', '󰎝 ', '󰆃 ', '󰕜 ' }

local function random_normal_icon()
  return icons[math.random(#icons)]
end

local function random_easter_egg_icon()
  return easter_egg_icons[math.random(#easter_egg_icons)]
end

local function get_random_icon()
  if math.random(7) == 3 then
    return random_easter_egg_icon()
  end

  return random_normal_icon()
end


require('barbar').setup({
  icons = {
    separator = { left = ' ', right = '' },
    inactive = {
      separator = { left = ' ', right = '' },
    },
    buffer_number = true,
    separator_at_end = false,
    modified = { button = get_random_icon() },
    filetype = {
      custom_colors = true,
      enabled = true
    },
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
      [vim.diagnostic.severity.WARN] = { enabled = true },
      [vim.diagnostic.severity.INFO] = { enabled = true },
      [vim.diagnostic.severity.HINT] = { enabled = true },
    },
  },
})

-- auto command when adding a  new buffer to run BufferOrderByBufferNumber
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('BufferLine', { clear = true }),
  callback = function()
    vim.cmd('BufferOrderByBufferNumber')
  end,
})
