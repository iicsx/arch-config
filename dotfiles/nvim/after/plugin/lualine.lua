local function get_theme()
  if DEFAULT_BAR_COLOR == "none" then
    return nil
  else
    return DEFAULT_BAR_COLOR
  end
end

local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
  yellow = '#ffff00',
  orange = '#ffa64d',
}

local function modified()
  if vim.bo.modified then
    return '+'
  elseif not vim.bo.modifiable or vim.bo.readonly then
    return '-'
  end
  return ''
end

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.white },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
    x = { fg = colors.white }, -- update this after load
    z = { fg = colors.black, bg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.yellow } },
  visual = { a = { fg = colors.black, bg = colors.blue } },
  replace = { a = { fg = colors.black, bg = colors.red } },
  command = { a = { fg = colors.black, bg = colors.orange } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

require('lualine').setup {
  options = {
    theme = get_theme() or bubbles_theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = {
      { "encoding", },
      { "fileformat", },
    },
    lualine_c = {
      'branch',
      'diff',
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'error' },
        diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
        separator = { left = '', right = '' },
      },
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'warn' },
        diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
        separator = { left = '', right = '' },
      },
      {
        '%w',
        cond = function()
          return vim.wo.previewwindow
        end,
      },
      {
        '%r',
        cond = function()
          return vim.bo.readonly
        end,
      },
      {
        '%q',
        cond = function()
          return vim.bo.buftype == 'quickfix'
        end,
      },
    },
    lualine_x = {
      'filetype', 'progress',
      '%=',
    },
    lualine_y = {
      { 'filename', file_status = false, path = 1 },
    },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}

vim.api.nvim_create_autocmd("CmdlineEnter", {
  callback = function()
    require('lualine').hide()
  end
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    require('lualine').hide({ unhide = true })
  end
})
