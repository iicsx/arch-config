local lsp_servers = {
  "bashls",
  "clangd",
  "haskell-lsp",
  "jdtls",
  "lua_ls",
  "marksman",
  "rust_analzer",
  "tinymist",
  "ts_ls",
  "verible-verilog-lsp",
  "yamlls",
}
vim.lsp.enable(lsp_servers)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
    end

    local opts = { buffer = ev.buf, remap = false }

    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({ border = "rounded", max_height = 25, max_width = 120 })
    end, opts)
    vim.keymap.set("n", "<leader>vws", function()
      vim.lsp.buf.workspace_symbol()
    end, opts)
    --	vim.keymap.set("n", "<leader>vd", function() vim.diagnostics,open_float() end, opts)
    vim.keymap.set("n", "[d", function()
      vim.diagnostics.goto_next()
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostics.goto_prev()
    end, opts)
    vim.keymap.set("n", "<leader>vca", function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>vrr", function()
      vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>vrn", function()
      vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("n", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, opts)
  end,
})

vim.cmd("set completeopt+=noselect")

local severity = vim.diagnostic.severity

vim.diagnostic.config({
  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.HINT] = "󰠠 ",
      [severity.INFO] = " ",
    },
  },
})
