local M = {}
local keymap = require("cmp.utils.keymap")

M.keymap_cinkeys = function(expr)
  return string.format(keymap.t("<Cmd>set cinkeys=%s<CR>"), expr and vim.fn.escape(expr, "| \t\\") or "")
end

return M
