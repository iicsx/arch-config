if not WITH_CATS then
  return
end

local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/*.lua", false, true)
for _, path in ipairs(plugin_files) do
  local name = vim.fn.fnamemodify(path, ":t:r")
  local spec = require("plugins." .. name)
  if type(spec.init) == "function" then
    spec.init(spec)
  end
  if type(spec.config) == "function" then
    spec.config(spec, spec.opts or {})
  end
end
