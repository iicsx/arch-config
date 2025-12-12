local cmp = require("cmp")
local lspkind = require("lspkind")

local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_mappings = cmp.mapping.preset.insert({
  ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-n"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-Space>"] = cmp.mapping.confirm({ select = true }),
  ["<C-y>"] = cmp.mapping.complete(),
})

cmp.setup({
  mapping = cmp_mappings,
  window = {
    completion = {
      border = "rounded",
    },
    documentation = {
      border = "rounded",
    },
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "text", -- I think cmp may show icons by default so chosing any 'symbol' based option shows two symbols per entry
      maxwidth = {
        menu = 50,
        abbr = 50,
      },
      ellipsis_char = "...",
      show_labelDetails = true,
      before = function(entry, vim_item)
        return vim_item
      end,
    }),
  },
})
