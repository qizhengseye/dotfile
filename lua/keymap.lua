local keymapset = vim.keymap.set
local function keymap(mode, lhs, rhs, des)
    local opts = { noremap = true, silent = true, desc = des}
    keymapset(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "
vim.keymap.set("n", "<Space>", "", { noremap = true, silent = true})
-- window navigation
keymap("n",     "<Tab>",    ":wincmd w<CR>",                    "move to next window")
keymap("n",     "<S-Tab>",  ":wincmd W<CR>",                    "move to previous window")
-- keymap("n", "<m-w>", function()
--   util.window_mode():activate()
-- end, opts)

-- vim.keymap.set("n", "<Esc>", function ()
--     util.close_floats()
--     vim.cmd("nohlsearch")
-- end)

-- buffer control
keymap("n",     "<m-e>",    ":bnext<CR>",                       "move to right buffer")
keymap("n",     "<m-d>",    ":bprevious<bar>bdelete #<CR>",     "delete current buffer")
keymap("n",     "<m-q>",    ":bprevious<CR>",                   "move to left buffer")

-- motion modify
keymap("i",     "<C-l>",    "<Esc>g_a",                         "goto end of line")
keymap("i",     "<C-h>",    "<Esc>^i",                          "goto beign of line")
--keymap({ "n", "o", "x" },   "<C-l>",    "g_",                   "goto end of line")
--keymap({ "n", "o", "x" },   "<C-h>",    "^",                    "goto beign of line")

-- save and quit
keymap("n",     "<leader>q",    ":q<CR>",                       "quit current window")
keymap("n",     "<leader>w",    ":w<CR>",                       "write to current window")

-- better indent
keymap("v",     ">",    ">gv",                                  "indent line to right")
keymap("v",     "<",    "<gv",                                  "indent line to left")

-- delete with out save
keymap({"n", "o", "x", "v"},    "<Bs>",     [["_d]],            "delte to blackhole")

-- scrolls
keymap({"n", "v"},      "<C-d>",    "6j",                       "go below")
keymap({"n", "v"},      "<C-u>",    "6k",                       "go above")

-- nevigation
vim.keymap.set({"n", "v"}, "gj", "]", {remap = true})
vim.keymap.set({"n", "v"}, "gk", "[", {remap = true})
keymap({"n", "v"},      "]m",       "]c",                       "]c")
keymap({"n", "v"},      "[m",       "[c",                       "[c")
