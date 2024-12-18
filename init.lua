require("keymap")
require("options")

G_CONF = require("configs")
G_ICON = require("icon")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {import = "plugins"},
  {import = "plugins.editor"},
  {import = "plugins.lsp"},
  {import = "plugins.treesitter"},
  { import = "plugins.cmp"},
})

require("lsp.common")
