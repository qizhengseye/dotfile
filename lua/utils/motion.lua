local M = {}
local function pack(...)
  return {n = select("#", ...), ...}
end
local ListUtils = require("utils.list")

local ts_util = require 'nvim-treesitter.ts_utils'

local function pEqual(p1, p2)
  return p1.row == p2.row and p1.col == p2.col
end

local function move_block(pos_cache, re_pos_cache, dir)
  local cur_pos_real = {}
  local tmp = vim.api.nvim_win_get_cursor(0)
  cur_pos_real.row, cur_pos_real.col = tmp[1], tmp[2]
  if not cur_pos_real or not cur_pos_real.row or not cur_pos_real.col then
    print("error: nvim_win_get_cursor return nil")
    return pos_cache, re_pos_cache
  end

  local top = ListUtils.back(pos_cache)
  local re_top = ListUtils.popBack(re_pos_cache)

  if top and not pEqual(top, cur_pos_real) then
     pos_cache = ListUtils.new()
     re_pos_cache = ListUtils.new()
     top = nil
     re_top = nil
  end

  if re_top and not pEqual(re_top, cur_pos_real) then
     pos_cache = ListUtils.new()
     re_pos_cache = ListUtils.new()
     top = nil
     re_top = nil
  end

  local tar_pos = ListUtils.back(re_pos_cache)
  if re_top and tar_pos then
    --print("move back: [%d,%d]->[%d,%d]", cur_pos_real.row, cur_pos_real.col, tar_pos.row, tar_pos.col)
    vim.api.nvim_win_set_cursor(0, {tar_pos.row, tar_pos.col})
    return pos_cache, re_pos_cache
  end

  if not top then
    ListUtils.pushBack(pos_cache, cur_pos_real)
  end

  local node = ts_util.get_node_at_cursor(0)
  if node and pos_cache.first < pos_cache.last then
    node = node:parent()
  end

  tar_pos = { row = cur_pos_real.row, col = cur_pos_real.col }
  if not node then
    return pos_cache, re_pos_cache
  end

  while node and pEqual(tar_pos, cur_pos_real) do
    local sRow, sCol, eRow, eCol = ts_util.get_vim_range(pack(node:range()), nil)
    if dir == 0 then
      tar_pos.row, tar_pos.col = sRow, sCol - 1
    else
      tar_pos.row, tar_pos.col = eRow, eCol - 1
    end
    vim.notify(vim.inspect(node:type()))
    --print("[%d,%d]->[%d,%d]", cur_pos_real.row, cur_pos_real.col, tar_pos.row, tar_pos.col)
    node = node:parent()
  end

  if pEqual(tar_pos, cur_pos_real) then
    return pos_cache, re_pos_cache
  end

  if tar_pos.row < 1 then
    tar_pos.row = 1
  end
  --print("move to: [%d,%d]->[%d,%d]", cur_pos_real.row, cur_pos_real.col, tar_pos.row, tar_pos.col)
  vim.api.nvim_win_set_cursor(0, {tar_pos.row, tar_pos.col})

  if (pos_cache.last - pos_cache.first + 1) > 20 then
    ListUtils.popBack(pos_cache)
  end

  ListUtils.pushBack(pos_cache, tar_pos)
  return pos_cache, re_pos_cache
end

local list_forward = ListUtils.new()
local list_backward = ListUtils.new()
local win_id = 0

M.move_block_forward = function()
  local cur_win_id = vim.api.nvim_get_current_win()
  if cur_win_id ~= win_id then
    win_id = cur_win_id
    list_forward = ListUtils.new()
    list_backward = ListUtils.new()
  end
  list_forward, list_backward = move_block(list_forward, list_backward, 1)
end

M.move_block_backward = function()
  local cur_win_id = vim.api.nvim_get_current_win()
  if cur_win_id ~= win_id then
    win_id = cur_win_id
    list_forward = ListUtils.new()
    list_backward = ListUtils.new()
  end

  list_backward, list_forward = move_block(list_backward, list_forward, 0)
end

M.move_node_forward = function()
  local tmp = vim.api.nvim_win_get_cursor(0)
  local row, col = tmp[1], tmp[2]

  if not row or row < 1 or not col or col < 0 then
    print("error: nvim_win_get_cursor return nil")
  end

  local node = ts_util.get_node_at_cursor(0)
  if not node then
    return
  end

  local _, _, eRow, eCol = ts_util.get_vim_range(pack(node:range()), nil)
  if row < eRow or (row == eRow and col < (eCol - 1)) then
    vim.api.nvim_win_set_cursor(0, {eRow, eCol - 1})
    return
  end

  local sibling = ts_util.get_next_node(node, false, false)
  
  if sibling then
    eRow, eCol, _, _ = ts_util.get_vim_range(pack(sibling:range()), nil)
    vim.api.nvim_win_set_cursor(0, {eRow, eCol- 1})
    return
  end

  node = node:parent()

  if not node then
    return
  end

  _, _, eRow, eCol = ts_util.get_vim_range(pack(node:range()), nil)
  if row < eRow or (row == eRow and col < (eCol - 1)) then
    vim.api.nvim_win_set_cursor(0, {eRow, eCol - 1})
    return
  end

  sibling = nil
  while node and not sibling do
    sibling = ts_util.get_next_node(node, false, false)
    node = node:parent()
  end

  if sibling then
    eRow, eCol, _, _ = ts_util.get_vim_range(pack(sibling:range()), nil)
    vim.api.nvim_win_set_cursor(0, {eRow, eCol- 1})
    return
  end
end

M.move_node_backward = function()
  local tmp = vim.api.nvim_win_get_cursor(0)
  local row, col = tmp[1], tmp[2]

  if not row or row < 1 or not col or col < 0 then
    print("error: nvim_win_get_cursor return nil")
  end

  local node = ts_util.get_node_at_cursor(0)
  if not node then
    print("error: nil node under then cursor")
    return
  end

  local eRow, eCol, _, _ = ts_util.get_vim_range(pack(node:range()), nil)
  if eRow < row or (row == eRow and (eCol - 1) < col) then
    vim.api.nvim_win_set_cursor(0, {eRow, eCol - 1})
    return
  end

  local sibling = ts_util.get_previous_node(node, false, false)
  
  if sibling then
    vim.notify("move to sibling")
    _, _, eRow, eCol = ts_util.get_vim_range(pack(sibling:range()), nil)
    vim.api.nvim_win_set_cursor(0, {eRow, eCol- 1})
    return
  end

  node = node:parent()

  if not node then
    return
  end

  eRow, eCol, _, _ = ts_util.get_vim_range(pack(node:range()), nil)
  vim.notify("move to parent")
  if eRow < row or (row == eRow and (eCol - 1) < col) then
    vim.api.nvim_win_set_cursor(0, {eRow, eCol - 1})
    return
  end

  sibling = nil
  while node and not sibling do
    sibling = ts_util.get_previous_node(node, false, false)
    node = node:parent()
  end

  if sibling then
    _, _, eRow, eCol = ts_util.get_vim_range(pack(sibling:range()), nil)
    vim.api.nvim_win_set_cursor(0, {eRow, eCol - 1})
  end
end

return M
