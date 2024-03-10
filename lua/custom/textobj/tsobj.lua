local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

local nDiag, pDiag = ts_repeat_move.make_repeatable_move_pair(
    vim.diagnostic.goto_next, vim.diagnostic.goto_prev)
vim.keymap.set('n', '[d', pDiag)
vim.keymap.set('n', ']d', nDiag)

local motion = require("utils.motion")
local blockf, blockb = ts_repeat_move.make_repeatable_move_pair(
  motion.move_block_forward, motion.move_block_backward
)

vim.keymap.set('n', ']b', blockf)
vim.keymap.set('n', '[b', blockb)
--vim.keymap.set('n', ']{', nMove)

local M = {}

local _obj = {}

_obj.select = {
  enable = true,
  lookahead = true,

  keymaps = {
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    ["ic"] = "@class.inner",
    ["ac"] = "@class.outer",
    ["ia"] = "@parameter.inner",
    ["aa"] = "@parameter.outer",
  },
}

_obj.move = {
  enable = true,
  set_jumps = true, -- whether to set jumps in the jumplist
  goto_next_start = {
    ["]f"] = "@function.outer",
    ["]c"] = { query = "@class.outer", desc = "Next class start" },
    ["]a"] = "@parameter.inner",
    --
    -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
    --["]o"] = "@loop.*",
    -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
    --
    -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
    -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
    --["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
  },
  goto_next_end = {
    ["]F"] = "@function.outer",
    ["]C"] = "@class.outer",
  },
  goto_previous_start = {
    ["[a"] = "@parameter.inner",
    ["[f"] = "@function.outer",
    ["[c"] = "@class.outer",
    ["[="] = "@assignment.lhs",
  },
  goto_previous_end = {
    ["[F"] = "@function.outer",
    ["[C"] = "@class.outer",
  },
  -- Below will go to either the start or the end, whichever is closer.
  -- Use if you want more granular movements
  -- Make it even more gradual by adding multiple queries and regex.
}

M.textobjects = _obj
return M;
