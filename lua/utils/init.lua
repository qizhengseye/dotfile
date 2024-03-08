local Util = {}
function Util.close_floats()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "win" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

Util.has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

Util.lsp_kind_compare = function(kind)
  return function(e1, e2)
    local k1 = e1:get_kind()
    local k2 = e2:get_kind()
    if k1 == kind and k2 ~= kind then
      return true
    end
    if k2 == kind and k1 ~= kind then
      return false
    end
  end
end


return Util
