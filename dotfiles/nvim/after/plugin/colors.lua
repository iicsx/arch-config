local function remove_background(elements)
  for _, element in ipairs(elements) do
    vim.api.nvim_set_hl(0, element, { bg = "none" })
  end
end

local function remove_telescope_background()
  local elements = {
    "TelescopeBorder",
    "TelescopePromptBorder",

    "TelescopeResultsTitle",
    "TelescopePreviewTitle",
    "TelescopePromptTitle",

    "TelescopeResultsNormal",
    "TelescopePreviewNormal",
    "TelescopePromptNormal",

    "GitSignsAdd",
    "GitSignsChange",
    "GitSignsDelete",
  }

  remove_background(elements)
end

local function remove_lsp_background()
  local elements = {
    "DiagnosticSignError",
    "DiagnosticSignWarn",
    "DiagnosticSignInfo",
    "DiagnosticSignHint",
    "DiagnosticVirtualTextError",
    "Pmenu",
    "PmenuSel",
    "MsgArea",
    "LspInfoBorder",
  }

  remove_background(elements)
end

local function remove_git_background()
  local elements = {
    "DiagnosticSignError",
    "DiagnosticSignWarn",
    "DiagnosticSignInfo",
    "DiagnosticSignHint",
  }

  remove_background(elements)
end

local function remove_misc_backgrounds(elements)
  remove_background(elements)
end

local function apply_both_styles(element, style, type)
  vim.api.nvim_set_hl(0, element, { bg = style[type].bg, fg = style[type].fg })
end


local function apply_buffer_colors()
  local buffer_colors = {
    active = {
      bg = '#BCBDBD',
      fg = '#3C3D3D',
      hint = '#E06C75',
      warn = '#E28743',
      info = '#76b5c5',
      changed = '#C678DD',
      error = '#EF2015',
    },
    inactive = {
      bg = '#2C2C2B',
      fg = '#ffffff',
      hint = '#56B6C2',
      warn = '#E5C07B',
      info = '#61AFEF',
      changed = '#C678DD',
      error = '#E06C75',
    }
  }

  local apply_both = {
    active = {
      'BufferCurrent',
      'BufferCurrentMod',
      'BufferCurrentIndex',
      'BufferCurrentIcon',
      'BufferCurrentHINT',
      'BufferCurrentWARN',
      'BufferCurrentINFO',
      'BufferCurrentCHANGED',
    },
    inactive = {
      'BufferInactive',
      'BufferInactiveMod',
      'BufferInactiveIndex',
      'BufferInactiveIcon',
      'BufferInactiveHINT',
      'BufferInactiveWARN',
      'BufferInactiveINFO',
      'BufferInactiveCHANGED',
    },
    visible = {
      'BufferVisible',
      'BufferVisibleIcon',
      'BufferVisibleMod',
      'BufferVisibleIndex',
      'BufferVisibleHINT',
      'BufferVisibleWARN',
      'BufferVisibleINFO',
      'BufferVisibleCHANGED',
    }
  }

  for _, element in ipairs(apply_both.active) do
    apply_both_styles(element, buffer_colors, 'active')
  end
  for _, element in ipairs(apply_both.inactive) do
    apply_both_styles(element, buffer_colors, 'inactive')
  end
  for _, element in ipairs(apply_both.visible) do
    apply_both_styles(element, buffer_colors, 'active')
  end

  -- misc
  vim.api.nvim_set_hl(0, 'BufferCurrent', { bg = buffer_colors.active.bg, fg = buffer_colors.active.fg, bold = true })

  vim.api.nvim_set_hl(0, 'BufferCurrentSign', { fg = buffer_colors.active.bg, bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'BufferCurrentMod', { fg = '#8A5E9B', bg = buffer_colors.active.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentSignRight', { fg = buffer_colors.active.bg, bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'BufferCurrentHINT',
    { fg = buffer_colors.active.hint, bg = buffer_colors.active.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentWARN',
    { fg = buffer_colors.active.warn, bg = buffer_colors.active.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentINFO',
    { fg = buffer_colors.active.info, bg = buffer_colors.active.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentCHANGED',
    { fg = buffer_colors.active.changed, bg = buffer_colors.active.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentERROR',
    { fg = buffer_colors.active.error, bg = buffer_colors.active.bg, bold = true })

  vim.api.nvim_set_hl(0, 'BufferInactiveSign', { fg = buffer_colors.inactive.bg, bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'BufferInactiveSignRight', { fg = buffer_colors.inactive.bg, bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'BufferInactiveMod', { fg = '#519ECF', bg = buffer_colors.inactive.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferInactiveHINT',
    { fg = buffer_colors.inactive.hint, bg = buffer_colors.inactive.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferInactiveWARN',
    { fg = buffer_colors.inactive.warn, bg = buffer_colors.inactive.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferInactiveINFO',
    { fg = buffer_colors.inactive.info, bg = buffer_colors.inactive.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferInactiveCHANGED',
    { fg = buffer_colors.inactive.changed, bg = buffer_colors.inactive.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferInactiveERROR',
    { fg = buffer_colors.inactive.error, bg = buffer_colors.inactive.bg, bold = true })

  vim.api.nvim_set_hl(0, 'BufferVisibleMod', { fg = '#8A5E9B', bg = buffer_colors.active.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferVisibleSign', { fg = buffer_colors.active.bg, bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'BufferVisibleSignRight', { fg = buffer_colors.active.bg, bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'BufferVisibleHINT',
    { fg = buffer_colors.active.hint, bg = buffer_colors.active.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferVisibleWARN',
    { fg = buffer_colors.active.warn, bg = buffer_colors.active.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferVisibleINFO',
    { fg = buffer_colors.active.info, bg = buffer_colors.active.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferVisibleCHANGED',
    { fg = buffer_colors.active.changed, bg = buffer_colors.active.bg, bold = true })
  vim.api.nvim_set_hl(0, 'BufferVisibleERROR',
    { fg = buffer_colors.active.error, bg = buffer_colors.active.bg, bold = true })
end

local function set_diagnostics_colors()
  vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ff5555", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#f1fa8c", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#8be9fd", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#50fa7b", bg = "NONE" })
end

-- exposing this globally for ad-hoc use
function SC(color)
  color = color or DEFAULT_COLOR
  DEFAULT_COLOR = color
  vim.cmd.colorscheme(color)
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    remove_telescope_background()
    remove_lsp_background()
    remove_git_background()

    remove_misc_backgrounds({
      "Normal",
      "NormalNC",
      "NormalFloat",
      "SignColumn",
      "BufferTabpageFill",
      "TabLineFill",
    })

    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "white", bg = "none" })
    vim.api.nvim_set_hl(0, "FloatTitle", { fg = "white", bg = "none" })

    apply_buffer_colors()
    set_diagnostics_colors()
  end
})

SC()
