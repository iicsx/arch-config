vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>S", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>ff", "<Cmd>lua vim.lsp.buf.format()<CR>")
vim.keymap.set("n", "<leader><tab>", ":quit<CR>")

vim.keymap.set("n", "<C-S-J>", "o<Esc>k")
vim.keymap.set("n", "<C-S-K>", "O<Esc>j")

vim.keymap.set("n", "<leader>n", ":bnext<CR>")
vim.keymap.set("n", "<leader>b", ":bprevious<CR>")
vim.keymap.set("n", "<leader>t", ":enew<CR>")
vim.keymap.set("n", "<leader>x", ":bd!<CR>")
vim.keymap.set("n", "<leader>X", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) and buf ~= bufnr then
      if vim.bo[buf].modified then
        vim.cmd("write")
      end
      vim.cmd("bd! " .. buf)
    end
  end
end, { noremap = true })

vim.keymap.set("n", "<leader>o", ":BufferOrderByBufferNumber<CR>")

vim.keymap.set("n", "<leader><S-J>", "<C-W>j")
vim.keymap.set("n", "<leader><S-K>", "<C-W>k")
vim.keymap.set("n", "<leader><S-H>", "<C-W>h")
vim.keymap.set("n", "<leader><S-L>", "<C-W>l")

-- No longer needed due to mini.animate (causes issues with scrolling)
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1) -- jump to immediate context
end, { silent = true })

vim.keymap.set("n", "<leader>cx", ":call VrcQuery()<CR>", { noremap = true })

BUFNUM_GROUP = vim.api.nvim_create_augroup("BufferNumber", { clear = true })

vim.keymap.set("n", "<leader>qg", function()
  local git_status = vim.fn.systemlist("git status --porcelain")
  local items = {}
  for _, line in ipairs(git_status) do
    table.insert(items, { filename = line:sub(4), text = line })
  end

  vim.fn.setqflist(items, "r")
  vim.cmd("copen")
end)


-- INTERNAL FUNCTIONS --
local function get_active_buffers()
  local active_buffers = {}

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.fn.buflisted(buf) == 1 then
      table.insert(active_buffers, buf)
    end

    if #active_buffers >= 9 then
      break
    end
  end

  return active_buffers
end

local function attach_buffer_map(i, bufnr)
  vim.keymap.set("n", "<leader>" .. i, function()
    vim.api.nvim_set_current_buf(bufnr)
  end)
end

local function clear_maps()
  vim.api.nvim_clear_autocmds({ group = BUFNUM_GROUP })
end

local events = {
  "BufAdd",
  "BufWinEnter",
  "WinEnter",
  "BufDelete",
  "BufWipeout",
  "BufReadPost"
}

for _, event in ipairs(events) do
  clear_maps()

  vim.api.nvim_create_autocmd(event, {
    group = BUFNUM_GROUP,
    callback = function()
      vim.schedule(function()
        local active_buffers = get_active_buffers()

        for i, buf in ipairs(active_buffers) do
          attach_buffer_map(i, buf)
        end
      end)
    end
  })
end
