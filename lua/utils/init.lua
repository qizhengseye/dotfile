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

local esc = 27
local win_cmd_map = {
  ["x"] = function() vim.api.nvim_command("wincmd x") end,
  ["L"] = function() vim.api.nvim_command("wincmd L") end,
  ["K"] = function() vim.api.nvim_command("wincmd K") end,
  ["J"] = function() vim.api.nvim_command("wincmd J") end,
  ["H"] = function() vim.api.nvim_command("wincmd H") end,
  ["l"] = function() vim.api.nvim_command("wincmd l") end,
  ["k"] = function() vim.api.nvim_command("wincmd k") end,
  ["j"] = function() vim.api.nvim_command("wincmd j") end,
  ["h"] = function() vim.api.nvim_command("wincmd h") end,
  ["="] = function() vim.api.nvim_command("res +4") end,
  ["-"] = function() vim.api.nvim_command("res -4") end,
  ["+"] = function() vim.api.nvim_command("vert res +4") end,
  ["_"] = function() vim.api.nvim_command("vert res -4") end,
}

local layer = nil
Util.window_mode = function()
  if layer then
    return layer
  end
  print("here")
  local param = {
    layer = {},
    enter = {}
  }

  param.exit = {
    {"n", '<Esc>'}
  }
  
  param.config = {
    on_enter = function()
      print("Window mode start")
      vim.bo.modifiable = false
    end,
    on_exit  = function() 
      print("Window mode exit") 
    end,
  }

  for key, _fn in pairs(win_cmd_map) do
    table.insert(param.layer, {'n', key, _fn})
  end
  layer = require("utils.klayer")(param)
  return layer
end

return Util
