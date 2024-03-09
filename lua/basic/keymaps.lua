local opts = { noremap = true, silent = true}
local util = require("utils")
vim.g.mapleader = " "
vim.keymap.set("n", "<Space>", "", opts)
-- window navigation
vim.keymap.set("n", "<Tab>", ":wincmd w<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":wincmd W<CR>", opts)
vim.keymap.set("n", "<m-w>", function()
  util.window_mode():activate()
end, opts)

vim.keymap.set("n", "<Esc>", function ()
    util.close_floats()
    vim.cmd("nohlsearch")
end)

-- buffer control
vim.keymap.set("n", "<m-e>", ":bnext<CR>", opts)
vim.keymap.set("n", "<m-d>", ":bprevious<bar>bdelete #<CR>", opts)
vim.keymap.set("n", "<m-q>", ":bprevious<CR>", opts)

-- motion modify
vim.keymap.set("i", "<C-l>", "<Esc>g_a", opts)
vim.keymap.set("i", "<C-h>", "<Esc>^i", opts)
vim.keymap.set({ "n", "o", "x" }, "<s-h>", "^", opts)
vim.keymap.set({ "n", "o", "x" }, "<s-l>", "g_", opts)

-- save and quit
vim.keymap.set("n", "<leader>q", ":q<CR>", opts)
vim.keymap.set("n", "<leader>w", ":w<CR>", opts)

-- better indent
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<", "<gv", opts)

-- delete with out save
vim.keymap.set({"n", "o", "x", "v"}, "<Bs>", [["_d]], opts)

-- scrolls
vim.keymap.set({"n", "v"}, "<C-d>", "6j", opts)
vim.keymap.set({"n", "v"}, "<C-u>", "6k", opts)

-- test
