local M = {}

local cmp = require'cmp'
local snip = vim.snippet
local keymap = require("cmp.utils.keymap")

M.keymap_cinkeys = function(expr)
  return string.format(keymap.t("<Cmd>set cinkeys=%s<CR>"), expr and vim.fn.escape(expr, "| \t\\") or "")
end

-- mapping functions

M.tab_i = function(fallback)
  if cmp.visible() then
    if #cmp.get_entries() == 1 then
      if vim.bo.filetype == 'cpp' then
        local item = cmp.get_entries()[1].completion_item
        local lable = item.label
        if lable == ' private' or lable == ' public' then
          local indent = vim.fn.indent('.')
          local width = vim.bo.shiftwidth
          item.textEdit.range.start.character = indent > width and indent - width or 0
        end
      end
      cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
    else
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    end
  elseif snip.active({direction = 1}) then
    snip.jump(1)
  else
    fallback()
  end
end

M.tab_c = function (fallback)
  if cmp.visible() then
    if #cmp.get_entries() == 1 then
      cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true})
    else
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
    end
  else
    cmp.complete()
    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
  end
end

M.stab_i = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
  elseif snip.active({direction = -1}) then
    snip.jump(-1)
  else
    fallback()
  end
end

M.stab_c = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
  end
end
return M
